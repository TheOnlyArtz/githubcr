require "json"

# Represents gist creation payload
# NOTE: Fields which are required to gist creation
# `public`
record BlobPayload,
  content : String,
  encode : String? = "utf-8" do
  include JSON::Serializable
end
