require "json"

# Represents a file
record GistFilePayload,
  content : String,
  filename : String? = nil do
  include JSON::Serializable
end

# Represents gist creation payload
record GistCreationPayload,
 description : String,
 public : Bool,
 files : Hash(String, GistFilePayload) do
  include JSON::Serializable
end
