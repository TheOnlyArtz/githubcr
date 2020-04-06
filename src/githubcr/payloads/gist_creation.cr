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
  files : Hash(String, GistFilePayload),
  description : String? = nil,
  public : Bool? = nil do
  include JSON::Serializable
end
