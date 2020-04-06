require "json"

struct Parent
  JSON.mapping(
    url: String,
    sha: String
  )
end


struct Author
  JSON.mapping(
    date: String,
    name: String,
    email: String
  )
end

struct Committer
  JSON.mapping(
    date: String,
    name: String,
    email: String
  )
end

struct Tree
  JSON.mapping(
    url: String,
    sha: String
  )
end

struct Verification
  JSON.mapping(
    verified: Bool,
    reason: String,
    signature: String,
    payload: String
  )
end

struct Commit
  JSON.mapping(
    sha: String,
    url: String,
    author: Author,
    committer: Committer,
    message: String,
    tree: Tree,
    parents: Array(Parent),
    verification: Verification
  )
end
