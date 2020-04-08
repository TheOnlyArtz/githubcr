require "json"

struct GitHubApp
end

struct GitHubApp::Owner
  JSON.mapping(
    login: {type: String, setter: false},
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    url: {type: String, setter: false},
    repos_url: {type: String, setter: false},
    events_url: {type: String, setter: false},
    hooks_url: {type: String, setter: false},
    issues_url: {type: String, setter: false},
    members_url: {type: String, setter: false},
    public_members_url: {type: String, setter: false},
    avatar_url: {type: String, setter: false},
    description: {type: String, setter: false}
  )
end

struct GitHubApp::Permissions
  JSON.mapping(
    metadata: {type: String, setter: false},
    contents: {type: String, setter: false},
    issues: {type: String, setter: false},
    single_file: {type: String, setter: false}
  )
end

struct GitHubApp
  JSON.mapping(
    id: {type: Int32, setter: false},
    slug: {type: String, setter: false},
    node_id: {type: String, setter: false},
    owner: {type: Owner, setter: false},
    name: {type: String, setter: false},
    description: {type: String, setter: false},
    external_url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false},
    permissions: {type: Permissions?, setter: false},
    events: {type: Array(String)?, setter: false},
    client_id: {type: String?, setter: false},
    client_secret: {type: String?, setter: false},
    webhook_secret: {type: String?, setter: false},
    pem: {type: String?, setter: false}

  )
end
