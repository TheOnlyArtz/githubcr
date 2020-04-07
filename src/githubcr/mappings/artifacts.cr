require "json"

struct Artifact
end

struct Artifact::ArtifactData
  JSON.mapping(
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    name: {type: String, setter: false},
    size_in_bytes: {type: Int32, setter: false},
    url: {type: String, setter: false},
    archive_download_url: {type: String, setter: false},
    expired: {type: Bool, setter: false},
    created_at: {type: String, setter: false},
    expires_at: {type: String, setter: false}
  )
end

struct Artifact
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    artifacts: {type: Array(ArtifactData), setter: false}
  )
end
