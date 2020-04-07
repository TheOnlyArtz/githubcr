require "json"

record CommitPayload,
  message : String,
  tree : String,
  parents : Array(String),
  author : CommitPayload::Author? = nil,
  committer : CommitPayload::Author? = nil,
  signature : String? = nil do
  include JSON::Serializable
end

record CommitPayload::Author,
  name : String? = nil,
  email : String? = nil,
  date : String? = nil do
  include JSON::Serializable
end
