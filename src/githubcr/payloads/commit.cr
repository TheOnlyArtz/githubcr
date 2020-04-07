require "json"

record CommitPayload,
  message : String,
  author : CommitPayload::Author,
  tree : String,
  signature : String do
    include JSON::Serializable
end

record CommitPayload::Author,
  name : String,
  email : String,
  date : String do
    include JSON::Serializable
end

