struct Tagger
  JSON.mapping(
    name: String,
    email: String,
    date: String
  )
end

struct TagObject
  JSON.mapping(
    type: String,
    sha: String,
    url: String
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

struct Tag
  JSON.mapping(
    node_id: String,
    tag: String,
    sha: String,
    url: String,
    message: String,
    tagger: Tagger,
    object: TagObject,
    verification: Verification
  )
end
