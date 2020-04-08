require "json"

struct OAuthToken
  JSON.mapping(
    id: {type: Int32, setter: false},
    url: {type: String, setter: false},
    scopes: {type: Array(String), setter: false},
    token: {type: String, setter: false},
    token_last_eight: {type: String, setter: false},
    hashed_token: {type: String, setter: false},
    app: {type: App, setter: false},
    note: {type: String, setter: false},
    note_url: {type: String, setter: false},
    updated_at: {type: String, setter: false},
    created_at: {type: String, setter: false},
    fingerprint: {type: String, setter: false},
    user: {type: User, setter: false}
  )
end

struct OAuthToken::App
  JSON.mapping(
    url: {type: String, setter: false},
    name: {type: String, setter: false},
    client_id: {type: String, setter: false}
  )
end
