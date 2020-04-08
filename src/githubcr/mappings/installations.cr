require "json"

struct Installation
end

struct Installation::Account
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

struct Installation::Permission
  JSON.mapping(
    metadata: {type: String, setter: false},
    contents: {type: String, setter: false},
    issues: {type: String, setter: false},
    single_file: {type: String, setter: false}
  )
end

struct Installation
  JSON.mapping(
    id: {type: Int32, setter: false},
    account: {type: Account, setter: false},
    access_tokens_url: {type: String, setter: false},
    repositories_url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    app_id: {type: Int32, setter: false},
    target_id: {type: Int32, setter: false},
    target_type: {type: String, setter: false},
    permissions: {type: Permission, setter: false},
    events: {type: Array(String), setter: false},
    single_file_name: {type: String, setter: false},
    repository_selection: {type: String, setter: false}
  )
end

struct InstallationToken
end

struct InstallationToken::Permissions
  JSON.mapping(
    issues: {type: String, setter: false},
    contents: {type: String, setter: false}
  )
end

struct InstallationToken::RepositoriesPermissions
  JSON.mapping(
    admin: {type: Bool, setter: false},
    push: {type: Bool, setter: false},
    pull: {type: Bool, setter: false}
  )
end

struct InstallationToken::Repositories
  JSON.mapping(
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    name: {type: String, setter: false},
    full_name: {type: String, setter: false},
    owner: {type: User, setter: false},
    private: {type: Bool, setter: false},
    html_url: {type: String, setter: false},
    description: {type: String, setter: false},
    fork: {type: Bool, setter: false},
    url: {type: String, setter: false},
    archive_url: {type: String, setter: false},
    assignees_url: {type: String, setter: false},
    blobs_url: {type: String, setter: false},
    branches_url: {type: String, setter: false},
    collaborators_url: {type: String, setter: false},
    comments_url: {type: String, setter: false},
    commits_url: {type: String, setter: false},
    compare_url: {type: String, setter: false},
    contents_url: {type: String, setter: false},
    contributors_url: {type: String, setter: false},
    deployments_url: {type: String, setter: false},
    downloads_url: {type: String, setter: false},
    events_url: {type: String, setter: false},
    forks_url: {type: String, setter: false},
    git_commits_url: {type: String, setter: false},
    git_refs_url: {type: String, setter: false},
    git_tags_url: {type: String, setter: false},
    git_url: {type: String, setter: false},
    issue_comment_url: {type: String, setter: false},
    issue_events_url: {type: String, setter: false},
    issues_url: {type: String, setter: false},
    keys_url: {type: String, setter: false},
    labels_url: {type: String, setter: false},
    languages_url: {type: String, setter: false},
    merges_url: {type: String, setter: false},
    milestones_url: {type: String, setter: false},
    notifications_url: {type: String, setter: false},
    pulls_url: {type: String, setter: false},
    releases_url: {type: String, setter: false},
    ssh_url: {type: String, setter: false},
    stargazers_url: {type: String, setter: false},
    statuses_url: {type: String, setter: false},
    subscribers_url: {type: String, setter: false},
    subscription_url: {type: String, setter: false},
    tags_url: {type: String, setter: false},
    teams_url: {type: String, setter: false},
    trees_url: {type: String, setter: false},
    clone_url: {type: String, setter: false},
    mirror_url: {type: String, setter: false},
    hooks_url: {type: String, setter: false},
    svn_url: {type: String, setter: false},
    homepage: {type: String, setter: false},
    language: String?,
    forks_count: {type: Int32, setter: false},
    stargazers_count: {type: Int32, setter: false},
    watchers_count: {type: Int32, setter: false},
    size: {type: Int32, setter: false},
    default_branch: {type: String, setter: false},
    open_issues_count: {type: Int32, setter: false},
    is_template: {type: Bool, setter: false},
    topics: {type: Array(String), setter: false},
    has_issues: {type: Bool, setter: false},
    has_projects: {type: Bool, setter: false},
    has_wiki: {type: Bool, setter: false},
    has_pages: {type: Bool, setter: false},
    has_downloads: {type: Bool, setter: false},
    archived: {type: Bool, setter: false},
    disabled: {type: Bool, setter: false},
    visibility: {type: String, setter: false},
    pushed_at: {type: String, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false},
    permissions: {type: RepositoriesPermissions, setter: false},
    allow_rebase_merge: {type: Bool, setter: false},
    template_repository: String?,
    temp_clone_token: {type: String, setter: false},
    allow_squash_merge: {type: Bool, setter: false},
    allow_merge_commit: {type: Bool, setter: false},
    subscribers_count: {type: Int32, setter: false},
    network_count: {type: Int32, setter: false}
  )
end

struct InstallationToken
  JSON.mapping(
    token: {type: String, setter: false},
    expires_at: {type: String, setter: false},
    permissions: {type: Permissions, setter: false},
    repositories: {type: Array(InstallationToken::Repositories), setter: false}
  )
end

struct Installation::InstallationRepositories
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    repositories: {type: Array(InstallationToken::Repositories), setter: false}
  )
end

struct Installation::InstallationUsers
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    installations: {type: Array(InstallationToken::Repositories), setter: false}
  )
end
