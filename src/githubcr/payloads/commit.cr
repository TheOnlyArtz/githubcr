require "json"

record CommitPayload,
  message : String,
  parents : Array(String),
  tree : String,
  author : CommitPayload::Author? = nil,
  signature : String? = nil do
    include JSON::Serializable
end

record CommitPayload::Author,
  name : String? = nil,
  email : String? = nil,
  date : String? = nil do
    include JSON::Serializable
end
