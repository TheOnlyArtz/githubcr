require "json"

# Represents gist creation payload
# NOTE: Fields which are required to gist creation
# `public`
record GistPayload,
  files : Hash(String, GistPayload::GistFilePayload),
  description : String? = nil,
  public : Bool? = nil do
  include JSON::Serializable
end

# Represents a file
# NOTE: Fields which are required to gist creation
# `filename`
record GistPayload::GistFilePayload,
  content : String,
  filename : String? = nil do
  include JSON::Serializable
end
