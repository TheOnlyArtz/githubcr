struct GitReferenceObject
  JSON.mapping(
    type: String,
    sha: String,
    url: String
  )
end

# Reference is a reserved class
struct GitReference
  JSON.mapping(
    ref: String,
    node_id: String,
    url: String,
    object: GitReferenceObject
  )
end
