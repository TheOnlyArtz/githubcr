require "json"

# This structs represent a single file in the files property
struct GistFile
  JSON.mapping(
    filename: String,
    type: String,
    language: String?,
    raw_url: String,
    size: Int32
  )
end

# This structs represents a Gist payload.
# see https://developer.github.com/v3/gists/#list-gists-for-a-user
struct Gist
  JSON.mapping(
    url: {type: String, setter: false},
    forks_url: {type: String, setter: false},
    commits_url: {type: String, setter: false},
    id: {type: String, setter: false},
    node_id: {type: String, setter: false},
    git_pull_url: {type: String, setter: false},
    git_push_url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    files: {type: Hash(String, GistFile), setter: false},
    public: {type: Bool, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false},
    description: {type: String, setter: false},
    comments: {type: Int32, setter: false},
    user: User?,
    comments_url: {type: String, setter: false},
    owner: {type: User?, setter: false},
    truncated: {type: Bool, setter: false}
  )
end

# This struct represent the change status of a commit.
struct GistCommitChangeStatus
  JSON.mapping(
    deletions: Int32,
    additions: Int32,
    total: Int32
  )
end

# This struct represent a single commit.
struct GistCommit
  JSON.mapping(
    url: String,
    version: String,
    user: User,
    change_status: GistCommitChangeStatus,
    committed_at: String
  )
end
