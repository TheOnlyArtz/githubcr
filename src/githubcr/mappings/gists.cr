require "json"

# This structs represent a single file in the files property
struct GistFile
  JSON.mapping(
    filename: String,
    type: String,
    language: String,
    raw_url: String,
    size: Int32
  )
end

struct GistUser
  # TODO
end

# A struct which represents the owenr of the gist.
struct GistOwner
  JSON.mapping(
    login: String?,
    id: Int32?,
    node_id: String?,
    avatar_url: String?,
    gravatar_id: String?,
    url: String?,
    html_url: String?,
    followers_url: String?,
    gists_url: String?,
    starred_url: String?,
    subscriptions_url: String,
    organizations_url: String,
    repos_url: String?,
    events_url: String,
    received_events_url: String,
    type: String?,
    site_admin: Bool
  )
end

# This structs represents a Gist payload.
# see https://developer.github.com/v3/gists/#list-gists-for-a-user
struct Gist
  JSON.mapping(
    url: String,
    forks_url: String,
    commits_url: String,
    id: String,
    node_id: String,
    git_pull_url: String,
    git_push_url: String,
    html_url: String,
    files: Hash(String, GistFile),
    public: Bool,
    created_at: String,
    updated_at: String,
    description: String,
    comments: Int32,
    # user: GistUser?, # (always got null, no idea what to put here.)
    comments_url: String,
    owner: GistOwner,
    truncated: Bool
  )
end
