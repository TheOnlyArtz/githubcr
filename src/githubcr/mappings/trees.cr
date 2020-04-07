require "json"

struct Tree
end

struct Tree::TreeData
  JSON.mapping(
    path: {type: String, setter: false},
    mode: {type: String, setter: false},
    type: {type: String, setter: false},
    size: {type: Int32?, setter: false},
    sha: {type: String, setter: false},
    url: {type: String, setter: false}
  )
end

struct Tree
  JSON.mapping(
    sha: {type: String, setter: false},
    url: {type: String, setter: false},
    tree: {type: Array(TreeData), setter: false},
    truncated: {type: Bool, setter: false}
  )
end
