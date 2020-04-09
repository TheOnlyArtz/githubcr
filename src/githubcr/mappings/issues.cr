require "json"

struct Issue
end

struct Issue::Label
  JSON.mapping(
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    url: {type: String, setter: false},
    name: {type: String, setter: false},
    description: {type: String, setter: false},
    color: {type: String, setter: false},
    default: {type: Bool, setter: false}
  )
end

struct Issue::Milestone
  JSON.mapping(
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    labels_url: {type: String, setter: false},
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    number: {type: Int32, setter: false},
    state: {type: String, setter: false},
    title: {type: String, setter: false},
    description: {type: String, setter: false},
    creator: {type: User, setter: false},
    open_issues: {type: Int32, setter: false},
    closed_issues: {type: Int32, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false},
    closed_at: {type: String, setter: false},
    due_on: {type: String, setter: false}
  )
end

struct Issue::PullRequest
  JSON.mapping(
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    diff_url: {type: String, setter: false},
    patch_url: {type: String, setter: false}
  )
end

struct Issue::RepositoryPermissions
  JSON.mapping(
    admin: {type: Bool, setter: false},
    push: {type: Bool, setter: false},
    pull: {type: Bool, setter: false}
  )
end

struct Issue
  JSON.mapping(
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    url: {type: String, setter: false},
    repository_url: {type: String, setter: false},
    labels_url: {type: String, setter: false},
    comments_url: {type: String, setter: false},
    events_url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    number: {type: Int32, setter: false},
    state: {type: String, setter: false},
    title: {type: String, setter: false},
    body: {type: String, setter: false},
    user: {type: User, setter: false},
    labels: {type: Array(Label), setter: false},
    assignee: {type: User?, setter: false},
    assignees: {type: Array(String), setter: false},
    milestone: {type: Milestone?, setter: false},
    locked: {type: Bool, setter: false},
    active_lock_reason: {type: String?, setter: false},
    comments: {type: Int32, setter: false},
    pull_request: {type: PullRequest?, setter: false},
    closed_at: {type: String?, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String?, setter: false},
    repository: {type: Repository?, setter: false}
  )
end

struct Issue::Reactions
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    up_votes: {type: Int32, setter: false, key: "+1"},
    down_votes: {type: Int32, setter: false, key: "-1"},
    laugh: {type: Int32, setter: false},
    confused: {type: Int32, setter: false},
    heart: {type: Int32, setter: false},
    hooray: {type: Int32, setter: false},
    url: {type: String, setter: false}
  )
end

struct Issue::Comment
  JSON.mapping(
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    body: {type: String, setter: false},
    user: {type: User, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false}
  )
end
