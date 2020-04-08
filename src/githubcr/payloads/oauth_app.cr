require "json"

record OAuthTokenPayload,
  access_token : String do
    include JSON::Serializable
end

record ContentAttachmentPayload,
  title : String,
  body : String do
    include JSON::Serializable
end
