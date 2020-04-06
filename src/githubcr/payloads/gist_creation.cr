require "json"

# Represents a file
# NOTE: Fields which are required to gist creation
# `filename`
record GistFilePayload,
  content : String,
  filename : String? = nil do
  include JSON::Serializable
end

# Represents gist creation payload
# NOTE: Fields which are required to gist creation
# `public`
record GistPayload,
 description : String,
 files : Hash(String, GistFilePayload),
 public : Bool? = nil, do
  include JSON::Serializable
end
