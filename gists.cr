struct FilesHello_world.rb
  JSON.mapping(
    filename: {type: String, setter: false},
    type: {type: String, setter: false},
    language: {type: String, setter: false},
    raw_url: {type: String, setter: false},
    size: {type: Int32, setter: false}
  )
end

struct Files
  JSON.mapping(
    hello_world.rb: {type: FilesHello_world.rb, setter: false}
  )
end

struct Owner
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

struct Gist
  JSON.mapping(
    url: {type: String, setter: false},
    forks_url: {type: String, setter: false},
    commits_url: {type: String, setter: false},
    id: {type: String, setter: false},
    node_id: {type: String, setter: false},
    git_pull_url: {type: String, setter: false},
    git_push_url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    files: {type: Files, setter: false},
    public: {type: Bool, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false},
    description: {type: String, setter: false},
    comments: {type: Int32, setter: false},
    user: <CHANGE_ME>,
    comments_url: {type: String, setter: false},
    owner: {type: Owner, setter: false},
    truncated: {type: Bool, setter: false}
  )
end
