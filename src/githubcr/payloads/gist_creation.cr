require "json"

# Represents a file
record GistCreationFilePayload, content : String do
  include JSON::Serializable
end

# Represents gist creation payload
record GistCreationPayload,
 description : String,
 public : Bool,
 files : Hash(String, GistCreationFilePayload) do
  include JSON::Serializable
end
