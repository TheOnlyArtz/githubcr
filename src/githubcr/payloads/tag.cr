require "json"

record TagPayload,
  tag : String,
  message : String,
  object : String,
  type : String,
  tagger : TagPayload::Tagger? = nil do
  include JSON::Serializable
end

record TagPayload::Tagger,
  name : String? = nil,
  email : String? = nil,
  date : String? = nil do
  include JSON::Serializable
end
