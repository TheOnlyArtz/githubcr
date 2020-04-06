require "json"

struct Blob
  JSON.mapping(
    content: {type: String, setter: false},
    encoding: {type: String, setter: false},
    url: {type: String, setter: false},
    sha: {type: String, setter: false},
    size: {type: Int32, setter: false}
  )
end
