require "json"

struct User
  JSON.mapping(
    login: {type: String, setter: false},
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    avatar_url: {type: String, setter: false},
    gravatar_id: {type: String, setter: false},
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    followers_url: {type: String, setter: false},
    following_url: {type: String, setter: false},
    gists_url: {type: String, setter: false},
    starred_url: {type: String, setter: false},
    subscriptions_url: {type: String, setter: false},
    organizations_url: {type: String, setter: false},
    repos_url: {type: String, setter: false},
    events_url: {type: String, setter: false},
    received_events_url: {type: String, setter: false},
    type: {type: String, setter: false},
    site_admin: {type: Bool, setter: false}
  )
end
