require "json"

record TreePayload,
  tree : Array(TreePayload::Tree),
  base_tree : String? = nil do
  include JSON::Serializable
end

record TreePayload::Tree,
  path : String,
  mode : String,
  type : String,
  sha : String do
  include JSON::Serializable
end
