require "json"

record RefPayload,
  ref : String,
  sha : String do
    include JSON::Serializable
end

record RefPatchPayload,
  sha : String,
  force : Bool? = nil do
    include JSON::Serializable
end
