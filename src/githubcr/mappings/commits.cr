struct CommitAuthor
  JSON.mapping(
    name: {type: String, setter: false},
    email: {type: String, setter: false},
    date: {type: String, setter: false}
  )
end

struct CommitCommitter
  JSON.mapping(
    name: {type: String, setter: false},
    email: {type: String, setter: false},
    date: {type: String, setter: false}
  )
end

struct CommitTree
  JSON.mapping(
    sha: {type: String, setter: false},
    url: {type: String, setter: false}
  )
end

struct CommitVerification
  JSON.mapping(
    verified: {type: Bool, setter: false},
    reason: {type: String, setter: false},
    signature: {type: String?, setter: false},
    payload: {type: String?, setter: false}
  )
end

struct CommitData
  JSON.mapping(
    author: {type: CommitAuthor, setter: false},
    committer: {type: CommitCommitter, setter: false},
    message: {type: String, setter: false},
    tree: {type: CommitTree, setter: false},
    url: {type: String, setter: false},
    comment_count: {type: Int32, setter: false},
    verification: {type: CommitVerification, setter: false}
  )
end

struct Parent
  JSON.mapping(
    sha: {type: String, setter: false},
    url: {type: String, setter: false},
    html_url: {type: String, setter: false}
  )
end

struct Stats
  JSON.mapping(
    total: {type: Int32, setter: false},
    additions: {type: Int32, setter: false},
    deletions: {type: Int32, setter: false}
  )
end

struct CommitFile
  JSON.mapping(
    sha: {type: String, setter: false},
    filename: {type: String, setter: false},
    status: {type: String, setter: false},
    additions: {type: Int32, setter: false},
    deletions: {type: Int32, setter: false},
    changes: {type: Int32, setter: false},
    blob_url: {type: String, setter: false},
    raw_url: {type: String, setter: false},
    contents_url: {type: String, setter: false},
    patch: {type: String, setter: false}
  )
end

struct Commit
  JSON.mapping(
    sha: {type: String, setter: false},
    node_id: {type: String, setter: false},
    commit: {type: CommitData, setter: false},
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    comments_url: {type: String, setter: false},
    author: {type: User, setter: false},
    committer: {type: User, setter: false},
    parents: {type: Array(Parent), setter: false},
    stats: {type: Stats, setter: false},
    files: {type: Array(CommitFile), setter: false}
  )
end
