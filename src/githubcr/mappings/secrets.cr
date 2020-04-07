require "json"

struct PublicKey
  JSON.mapping(
    key_id: {type: String, setter: false},
    key: {type: String, setter: false}
  )
end

struct Secrets
end

struct Secrets::SecretData
  JSON.mapping(
    name: {type: String, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false}
  )
end

struct Secrets
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    secrets: {type: Array(SecretData), setter: false}
  )
end
