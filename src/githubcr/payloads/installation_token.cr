require "json"

record InstallationTokenPayload,
  repository_ids : Array(String),
  permissions : InstallationTokenPayload::Permissions do
  include JSON::Serializable
end

record InstallationTokenPayload::Permissions,
  issues : String,
  contents : String do
  include JSON::Serializable
end
