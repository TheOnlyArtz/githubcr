require "uri"
require "http/client"
require "json"
require "./payloads/*"
require "./mappings/*"

module GitHub
  # This module enables GitHub.cr to interact with the
  # GitHub API through HTTP requests
  module REST(T)
    API_BASE     = "api.github.com"
    HTTP_CLIENT  = HTTP::Client.new API_BASE, tls: true
    GLOBAL_MUTEX = Mutex.new

    # :nodoc:
    struct MalformedMessage
      JSON.mapping(
        message: String,
        documentation_url: String
      )
    end

    # This function is responsible for requesting the API
    def self.raw_request(method : String, path : String, headers : HTTP::Headers, body : String?)
      request_done = false
      pp API_BASE + path
      until request_done
        GLOBAL_MUTEX.synchronize { }

        response = HTTP_CLIENT.exec(
          method: method,
          path: path,
          headers: headers,
          body: body
        )

        if response.status_code == 429 || response.headers["X-RateLimit-Remaining"]? == 0
          retry_after_val = response.headers["X-RateLimit-Reset-After"]?
          retry_after = retry_after_val.not_nil!.to_f

          GLOBAL_MUTEX.synchronize { sleep retry_after }

          request_done = true unless response.status_code == 429
        else
          request_done = true
        end
      end

      response.not_nil!
    end

    def self.request(method : String, path : String, headers : HTTP::Headers, body : String?)
      response = raw_request(method, path, headers, body)
      unless response.success?
        raise "Unknown/bad payload" unless response.content_type.not_nil!.includes?("application/json")
        raise MalformedMessage.from_json(response.body).message
      end

      T.from_json(response.body)
    end

    # This module is specifically for interacting with
    # the Events endpoint GitHub offer us to use.
    # see [GitHub Events endpoints](https://developer.github.com/v3/activity/events/)
    # TODO ↑
    module Events
    end

    # This module is specifically for interacting with
    # the Gists endpoints GitHub offers us to use.
    # see [GitHub Gists endpoints](https://developer.github.com/v3/gists/)
    module Gists
      # NOTE: This will return the public repositories only
      # if it wasn't obvious already...
      def get_all_gists(owner : String) : Array(Gist)
        json = REST(Array(Gist)).request(
          "GET",
          "/users/#{owner}/gists",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Gets the authenticated user's gists
      def get_my_gists : Array(Gist)
        get_all_gists(@username)
      end

      # List public gists sorted by most recently updated to least recently updated.
      # NOTE: With pagination, you can fetch up to 3000 gists. For example
      # you can fetch 100 pages with 30 gists per page or 30 pages with 100 gists per page.
      #
      # ```cr
      # gists = client.get_public_gists(
      #    Time.local(2018, 3, 8, 22, 5, 13, location: Time::Location.load("Europe/Berlin"))
      # )
      # ```
      def get_public_gists(since : Time) : Array(Gist)
        params = HTTP::Params.encode({
          "since" => URI.parse(since.to_s).to_s,
        })
        json = REST(Array(Gist)).request(
          "GET",
          "/gists/public?#{params}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # List the auth user's starred gists
      # TODO check if since can be null
      def get_starred_gists(since : Time) : Array(Gist)
        params = HTTP::Params.encode({
          "since" => URI.parse(since.to_s).to_s,
        })
        json = REST(Array(Gist)).request(
          "GET",
          "/gists/starred?#{params}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Get a gist by it's ID
      def get_gist(id : String) : Gist
        json = REST(Gist).request(
          "GET",
          "/gists/#{id}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Get a revision of a gist by it's ID and sha
      def get_gist_revision(id : String, sha : String) : Gist
        json = REST(Gist).request(
          "GET",
          "/gists/#{id}/#{sha}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Creates a gist on the auth user's account.
      # ```
      # payload = GistCreationPayload.new(
      #   description: "This is a description",
      #   public: true,
      #   files: {
      #     "test.cr" => GistCreationFilePayload.new(content: "This is some content"),
      #   }
      # )
      # client.create_gist(payload)
      # ```
      def create_gist(payload : GistPayload) : Gist
        json = REST(Gist).request(
          "POST",
          "/gists",
          HTTP::Headers{
            "Authorization" => get_auth_header,
            "Content-Type"  => "application/json",
          },
          payload.to_json
        )
      end

      # Allows you to update or delete a gist file and rename gist files
      # Files from the previous version of the gist that aren't
      # explicitly changed during an edit are unchanged.
      # TODO: Look into the different [new fields](https://developer.github.com/v3/gists/#update-a-gist)
      # that might appear
      def update_gist(id : String, payload : GistPayload) : Gist
        json = REST(Gist).request(
          "PATCH",
          "/gists/#{id}",
          HTTP::Headers{"Authorization" => get_auth_header},
          payload.to_json
        )
      end

      # Allows you to list the commits of a gist by it's ID
      def list_gist_commits(id : String) : Array(GistCommit)
        json = REST(Array(GistCommit)).request(
          "GET",
          "/gists/#{id}/commits",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Allows you star a gist by it's ID
      def star_gist(id : String) : Nil
        response = REST.request(
          "PUT",
          "/gists/#{id}/star",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Allows you to unstar a gist by it's ID
      def unstar_gist(id : String) : Nil
        response = REST.request(
          "DELETE",
          "/gists/#{id}/star",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Allows you to check whether a gist is starred
      def gist_starred?(id : String) : Bool
        response = REST.request(
          "GET",
          "/gists/#{id}/star",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        true
      end

      # Allows you to fork a gist by it's ID
      def fork_gist(id : String) : Gist
        json = REST(Gist).request(
          "POST",
          "/gists/#{id}/forks",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Allows you to delete a gist by it's ID
      def delete_gist(id : String) : Nil
        response = REST.request(
          "DELETE",
          "/gists/#{id}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end
    end

    # This module is specifically for interacting with
    # the Blobs endpoints GitHub offers us to use.
    # see [GitHub Blobs endpoints](https://developer.github.com/v3/git/blobs/)
    module Blobs
      # The content in the response will always be Base64 encoded.
      # NOTE: This API supports blobs up to 100 megabytes in size.
      def get_blob(owner : String, repository : String, file_sha : String) : Blob
        json = REST(Blob).request(
          "GET",
          "/repos/#{owner}/#{repository}/git/blobs/#{file_sha}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      def create_blob(owner : String, repository : String, payload : BlobPayload)
        json = REST.request(
          "POST",
          "/repos/#{owner}/#{repository}/git/blobs",
          HTTP::Headers{"Authorization" => get_auth_header},
          payload.to_json
        )

        pp json # TODO: finish this
      end
    end

    # This module is specifically for interacting with
    # the Commits endpoints GitHub offers us to use.
    # see [GitHub Commits endpoints](https://developer.github.com/v3/git/commits/)
    module Commits
      # Gets a Git commit object.
      def get_commit(owner : String, repository : String, commit_sha : String) : Commit
        json = REST(Commit).request(
          "GET",
          "/repos/#{owner}/#{repository}/commits/#{commit_sha}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      def create_commit(owner : String, repository : String, payload : CommitPayload) : Commit
        json = REST(Commit).request(
          "POST",
          "/repos/#{owner}/#{repository}/git/commits",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end
    end

    # This module is specifically for interacting with
    # the Reference endpoints GitHub offers us to use.
    # A Git reference (git ref) is just a file that contains a Git commit SHA-1 hash.
    # When referring to a Git commit, you can use the Git reference,
    # which is an easy-to-remember name, rather than the hash.
    # The Git reference can be rewritten to point to a new commit.
    # A branch is just a Git reference that stores the new Git commit hash.
    # These endpoints allow you to read and write references to your Git database on GitHub.
    # see [GitHub Refs endpoints](https://developer.github.com/v3/git/refs/)
    module References
      # Get a single Reference by it's ID
      def get_reference(owner : String, repository : String, reference : String) : Ref
        json = REST(Ref).request(
          "GET",
          "/repos/#{owner}/#{repository}/ref/#{reference}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Returns an array of references from your Git database that match the supplied name.
      # The :ref in the URL must be formatted as heads/<branch name> for branches and tags/<tag name> for tags.
      # If the :ref doesn't exist in the repository, but existing refs start with :ref, they will be returned as an array.
      def get_matching_references(owner : String, repository : String, reference : String) : Array(Ref)
        json = REST(Array(Ref)).request(
          "GET",
          "/repos/#{owner}/#{repository}/git/matching-refs/#{reference}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Creates a reference for your repository.
      # You are unable to create new references for empty repositories,
      # even if the commit SHA-1 hash used exists.
      # Empty repositories are repositories without branches.
      def create_reference(owner : String, repository : String, payload : RefPayload) : Ref
        json = REST(Ref).request(
          "POST",
          "/repos/#{owner}/#{repository}/git/refs",
          HTTP::Headers{"Authorization" => get_auth_header},
          payload.to_json
        )
      end

      def update_reference(owner : String, repository : String, payload : RefPatchPayload) : Ref
        json = REST(Ref).request(
          "PATCH",
          "/repos/#{owner}/#{repository}/git/refs",
          HTTP::Headers{"Authorization" => get_auth_header},
          payload.to_json
        )
      end

      # NOTE: If this raises an error, you've failed to delete the reference.
      def delete_reference(owner : String, repository : String, reference : String) : Nil
        json = REST.request(
          "DELETE",
          "/repos/#{owner}/#{repository}/git/refs/#{reference}",
          HTTP::Headers{"Authorization" => get_auth_header},
        )
      end

      # TODO: Check out the endpoint since it's missing in the docs.
      def delete_reference_tag
      end
    end

    # This module is specifically for interacting with
    # the Tags endpoints GitHub offers us to use.
    # see [GitHub Tags endpoints](https://developer.github.com/v3/git/tags/)
    module Tags
      def get_tag(owner : String, repository : String, tag_sha : String) : Tag
        json = REST(Tag).request(
          "GET",
          "/repos/#{owner}/#{repository}/git/tags/#{tag_sha}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # Note that creating a tag object does not create the reference that makes a tag in Git.
      # create an annotated tag in Git, you have to do this call to create the tag object.
      # and then create the refs/tags/[tag] reference.
      #  f you want to create a lightweight tag, you only have to create the tag
      # reference - this call would be unnecessary.
      def create_tag(owner : String, repository : String, payload : TagPayload) : Tag
        json = REST(Tag).request(
          "POST",
          "/repos/#{owner}/#{repository}/git/tags",
          HTTP::Headers{"Authorization" => get_auth_header},
          payload.to_json
        )
      end
    end

    # This module is specifically for interacting with
    # the Trees endpoints GitHub offers us to use.
    # see [GitHub Trees endpoints](https://developer.github.com/v3/git/trees/)
    module Trees
      # If truncated is true in the response then the number
      # of items in the tree array exceeded our maximum limit.
      # If you need to fetch more items, use the non-recursive.
      # method of fetching trees, and fetch one sub-tree at a time.
      def get_tree(owner : String, repository : String, tree_sha : String) : Tree
        json = REST(Tree).request(
          "GET",
          "/repos/#{owner}/#{repository}/git/trees/#{tree_sha}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      def create_tree(owner : String, repository : String, payload : TreePayload) : Tree
        json = REST(Tree).request(
          "POST",
          "/repos/#{owner}/#{repository}/git/trees",
          HTTP::Headers{"Authorization" => get_auth_header},
          payload.to_json
        )
      end
    end

    # This module is specifically for interacting with
    # the Artifacts endpoints GitHub offers us to use.
    # see [GitHub Artifacts endpoints](https://developer.github.com/v3/git/artifacts/)
    module Artifacts
      def list_repo_artifacts(owner : String, repository : String) : Artifact
        json = REST(Artifact).request(
          "GET",
          "/repos/#{owner}/#{repository}/actions/artifacts",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      def list_run_artifacts(owner : String, repository : String, run_id : String) : Artifact
        json = REST(Artifact).request(
          "GET",
          "/repos/#{owner}/#{repository}/actions/runs/#{run_id}/artifacts",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      def get_artifact(owner : String, repository : String, artifact_id : String) : Artifact
        json = REST(Artifact).request(
          "GET",
          "/repos/#{owner}/#{repository}/actions/artifacts/#{artifact_id}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # TODO
      def download_artifact
      end

      # NOTE: If raises error, the artifact was not found.
      def delete_artifact(owner : String, repository : String, artifact_id : String) : Nil
        REST.request(
          "DELETE",
          "/repos/#{owner}/#{repository}/actions/artifacts/#{artifact_id}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end
    end

    # This module is specifically for interacting with
    # the Secrets endpoints GitHub offers us to use.
    # see [GitHub Secrets endpoints](https://developer.github.com/v3/git/secrets/)
    module Secrets
      # Gets your public key, which you must store.
      # You need your public key to use other secrets
      # endpoints. Use the returned key to encrypt your secrets.
      # Anyone with read access to the repository can use this endpoint.
      # GitHub Apps must have the secrets permission to use this endpoint.
      def get_my_public_key(owner : String, repository : String) : PublicKey
        REST(PublicKey).request(
          "GET",
          "/repos/#{owner}/#{repository}/actions/secrets/public-key",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # NOTE: Secrets is NOT an array! it contains an array of SecretData
      # SEE [this](https://developer.github.com/v3/actions/secrets/#list-secrets-for-a-repository).
      def list_secrets(owner : String, repository : String) : Secrets
        REST(Secrets).request(
          "GET",
          "/repos/#{owner}/#{repository}/actions/secrets/public-key",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      def get_secret(owner : String, repository : String, name : String) : Secrets::SecretData
        REST(Secrets::SecretData).request(
          "GET",
          "/repos/#{owner}/#{repository}/actions/secrets/#{name}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end

      # TODO
      def create_or_update_secret
      end

      # NOTE: Raises an error when not found
      def delete_secret(owner : String, repository : String, name : String) : Nil
        REST.request(
          "DELETE",
          "/repos/#{owner}/#{repository}/actions/secrets/#{name}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )
      end
    end
  end
end
