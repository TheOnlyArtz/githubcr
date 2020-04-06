require "uri"
require "http/client"
require "json"
require "./payloads/*"
require "./mappings/*"

module GitHub
  # This module enables GitHub.cr to interact with the
  # GitHub API through HTTP requests
  module REST
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

      response.body
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
        json = REST.request(
          "GET",
          "/users/#{owner}/gists",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Array(Gist).from_json(json)
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
        json = REST.request(
          "GET",
          "/gists/public?#{params}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Array(Gist).from_json(json)
      end

      # List the auth user's starred gists
      # TODO check if since can be null
      def get_starred_gists(since : Time) : Array(Gist)
        params = HTTP::Params.encode({
          "since" => URI.parse(since.to_s).to_s,
        })
        json = REST.request(
          "GET",
          "/gists/starred?#{params}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Array(Gist).from_json(json)
      end

      # Get a gist by it's ID
      def get_gist(id : String)
        json = REST.request(
          "GET",
          "/gists/#{id}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Gist.from_json(json)
      end

      # Get a revision of a gist by it's ID and sha
      def get_gist_revision(id : String, sha : String)
        json = REST.request(
          "GET",
          "/gists/#{id}/#{sha}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Gist.from_json(json)
      end

      # Creates a gist on the auth user's account.
      #```
      # payload = GistCreationPayload.new(
      #     description: "This is a description",
      #     public: true,
      #     files: {
      #       "test.cr" => GistCreationFilePayload.new(content: "This is some content")
      #     }
      # )
      # client.create_gist(payload)
      # ```
      def create_gist(payload : GistPayload) : Gist
        json = REST.request(
          "POST",
          "/gists",
          HTTP::Headers{
            "Authorization" => get_auth_header,
            "Content-Type"  => "application/json",
          },
          payload.to_json
        )

        Gist.from_json(json)
      end

      # Allows you to update or delete a gist file and rename gist files
      # Files from the previous version of the gist that aren't
      # explicitly changed during an edit are unchanged.
      # TODO: Look into the different [new fields](https://developer.github.com/v3/gists/#update-a-gist)
      # that might appear
      def update_gist(id : String, payload : GistPayload) : Gist
        json = REST.request(
          "PATCH",
          "/gists/#{id}",
          HTTP::Headers{
            "Authorization" => get_auth_header,
            "Content-Type"  => "application/json",
          },
          payload.to_json
        )

        Gist.from_json(json)
      end

      # Allows you to list the commits of a gist by it's ID
      def list_gist_commits(id : String) : Array(GistCommit)
        json = REST.request(
          "GET",
          "/gists/#{id}/commits",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Array(GistCommit).from_json(json)
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
        json = REST.request(
          "POST",
          "/gists/#{id}/forks",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Gist.from_json(json)
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
    # see [GitHub Gists endpoints](https://developer.github.com/v3/git/blobs/)
    module Blobs
      # The content in the response will always be Base64 encoded.
      # NOTE: This API supports blobs up to 100 megabytes in size.
      def get_blob(owner : String, repository : String, file_sha : String) : Blob
        json = REST.request(
          "GET",
          "/repos/#{owner}/#{repository}/git/blobs/#{file_sha}",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Blob.from_json(json)
      end

      def create_blob(owner : String, repository : String, payload : BlobPayload)
        json = REST.request(
          "POST",
          "/repos/#{owner}/#{repository}/git/blobs",
          HTTP::Headers{"Authorization" => get_auth_header},
          payload.to_json
        )

        pp json
      end
    end
  end
end
