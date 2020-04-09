require "json"

record IssuePayload,
  title : String,
  body : String? = nil,
  assignees : Array(String)? = nil,
  milestone : Int32? = 0,
  labels : Array(String)? = [] of String do
  include JSON::Serializable
end

record IssueLockPayload,
  locked : Bool,
  active_lock_reason : String do
  include JSON::Serializable
end

record AssigneePayload, assignees : Array(String) do
end

record CommentPayload, body : String do
end
