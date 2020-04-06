require "json"

struct Blob
  JSON.mapping(
    content: String,
    encoding: String,
    url: String,
    sha: String,
    size: Int32
  )
end
