struct CommitAuthor
  JSON.mapping(
    name: String,
    email: String,
    date: String
  )
end

struct CommitCommitter
  JSON.mapping(
    name: String,
    email: String,
    date: String
  )
end

struct CommitTree
  JSON.mapping(
    sha: String,
    url: String
  )
end

struct CommitVerification
  JSON.mapping(
    verified: Bool,
    reason: String,
    signature: String?,
    payload: String?
  )
end

struct CommitData
  JSON.mapping(
    author: CommitAuthor,
    committer: CommitCommitter,
    message: String,
    tree: CommitTree,
    url: String,
    comment_count: Int32,
    verification: CommitVerification
  )
end

struct Committer
  JSON.mapping(
    login: String,
    id: Int32,
    node_id: String,
    avatar_url: String,
    gravatar_id: String,
    url: String,
    html_url: String,
    followers_url: String,
    following_url: String,
    gists_url: String,
    starred_url: String,
    subscriptions_url: String,
    organizations_url: String,
    repos_url: String,
    events_url: String,
    received_events_url: String,
    type: String,
    site_admin: Bool
  )
end

struct Parent
  JSON.mapping(
    sha: String,
    url: String,
    html_url: String
  )
end

struct Stats
  JSON.mapping(
    total: Int32,
    additions: Int32,
    deletions: Int32
  )
end

struct CommitFile
  JSON.mapping(
    sha: String,
    filename: String,
    status: String,
    additions: Int32,
    deletions: Int32,
    changes: Int32,
    blob_url: String,
    raw_url: String,
    contents_url: String,
    patch: String
  )
end

struct Commit
  JSON.mapping(
    sha: String,
    node_id: String,
    commit: CommitData,
    url: String,
    html_url: String,
    comments_url: String,
    author: Committer,
    committer: Committer,
    parents: Array(Parent),
    stats: Stats,
    files: Array(CommitFile)
  )
end
