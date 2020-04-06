struct Tagger
  JSON.mapping(
    name: {type: String, setter: false},
    email: {type: String, setter: false},
    date: {type: String, setter: false}
  )
end

struct TagObject
  JSON.mapping(
    type: {type: String, setter: false},
    sha: {type: String, setter: false},
    url: {type: String, setter: false}
  )
end

struct Verification
  JSON.mapping(
    verified: {type: Bool, setter: false},
    reason: {type: String, setter: false},
    signature: {type: String, setter: false},
    payload: {type: String?, setter: false}
  )
end

struct Tag
  JSON.mapping(
    node_id: {type: String, setter: false},
    tag: {type: String, setter: false},
    sha: {type: String, setter: false},
    url: {type: String, setter: false},
    message: {type: String, setter: false},
    tagger: {type: Tagger, setter: false},
    object: {type: TagObject, setter: false},
    verification: {type: Verification, setter: false}
  )
end
