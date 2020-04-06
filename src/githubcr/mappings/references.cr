struct RefObject
  JSON.mapping(
    type: {type: String, setter: false},
    sha: {type: String, setter: false},
    url: {type: String, setter: false}
  )
end

struct Ref
  JSON.mapping(
    ref: {type: String, setter: false},
    node_id: {type: String, setter: false},
    url: {type: String, setter: false},
    object: {type: RefObject, setter: false}
  )
end
