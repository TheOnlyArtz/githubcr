struct Workflow
end

struct Workflow::WorkflowData
  JSON.mapping(
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    name: {type: String, setter: false},
    path: {type: String, setter: false},
    state: {type: String, setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false},
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    badge_url: {type: String, setter: false}
  )
end

struct Workflow
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    workflows: {type: Array(WorkflowData), setter: false}
  )
end

struct WorkflowJob
end

struct WorkflowJob::Steps
  JSON.mapping(
    name: {type: String, setter: false},
    status: {type: String, setter: false},
    conclusion: {type: String, setter: false},
    number: {type: Int32, setter: false},
    started_at: {type: String, setter: false},
    completed_at: {type: String, setter: false}
  )
end

struct WorkflowRunJobs
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    jobs: {type: Array(WorkflowRunJobData), setter: false}
  )
end

struct WorkflowRunJobs::WorkflowRunJobData
  JSON.mapping(
    id: {type: Int32, setter: false},
    run_id: {type: Int32, setter: false},
    run_url: {type: String, setter: false},
    node_id: {type: String, setter: false},
    head_sha: {type: String, setter: false},
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    status: {type: String, setter: false},
    conclusion: {type: String, setter: false},
    started_at: {type: String, setter: false},
    completed_at: {type: String, setter: false},
    name: {type: String, setter: false},
    steps: {type: Array(WorkflowJob::WorkflowJobStep), setter: false},
    check_run_url: {type: String, setter: false}
  )
end

struct WorkflowJob
end

struct WorkflowJob::WorkflowJobStep
  JSON.mapping(
    name: {type: String, setter: false},
    status: {type: String, setter: false},
    conclusion: {type: String, setter: false},
    number: {type: Int32, setter: false},
    started_at: {type: String, setter: false},
    completed_at: {type: String, setter: false}
  )
end

struct WorkflowJob
  JSON.mapping(
    id: {type: Int32, setter: false},
    run_id: {type: Int32, setter: false},
    run_url: {type: String, setter: false},
    node_id: {type: String, setter: false},
    head_sha: {type: String, setter: false},
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    status: {type: String, setter: false},
    conclusion: {type: String, setter: false},
    started_at: {type: String, setter: false},
    completed_at: {type: String, setter: false},
    name: {type: String, setter: false},
    steps: {type: Array(WorkflowJobStep), setter: false},
    check_run_url: {type: String, setter: false}
  )
end

# ================================================= #
struct WorkflowRun
end

struct WorkflowRun::WorkflowRunHeadCommitAuthor
  JSON.mapping(
    name: {type: String, setter: false},
    email: {type: String, setter: false}
  )
end

struct WorkflowRun::WorkflowRunHeadCommitCommitter
  JSON.mapping(
    name: {type: String, setter: false},
    email: {type: String, setter: false}
  )
end

struct WorkflowRun::WorkflowRunHeadCommit
  JSON.mapping(
    id: {type: String, setter: false},
    tree_id: {type: String, setter: false},
    message: {type: String, setter: false},
    timestamp: {type: String, setter: false},
    author: {type: WorkflowRunHeadCommitAuthor, setter: false},
    committer: {type: WorkflowRunHeadCommitCommitter, setter: false}
  )
end

struct WorkflowRun::WorkflowRunHeadRepositoryOwner
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

struct WorkflowRun::WorkflowRunData
  JSON.mapping(
    id: {type: Int32, setter: false},
    node_id: {type: String, setter: false},
    head_branch: {type: String, setter: false},
    head_sha: {type: String, setter: false},
    run_number: {type: Int32, setter: false},
    event: {type: String, setter: false},
    status: {type: String, setter: false},
    conclusion: String?,
    url: {type: String, setter: false},
    html_url: {type: String, setter: false},
    # TODO:
    # pull_requests: {type: Array(PullRequest), setter: false},
    created_at: {type: String, setter: false},
    updated_at: {type: String, setter: false},
    jobs_url: {type: String, setter: false},
    logs_url: {type: String, setter: false},
    check_suite_url: {type: String, setter: false},
    artifacts_url: {type: String, setter: false},
    cancel_url: {type: String, setter: false},
    rerun_url: {type: String, setter: false},
    workflow_url: {type: String, setter: false},
    head_commit: {type: WorkflowRunHeadCommit, setter: false},
    repository: {type: Repository, setter: false},
    head_repository: {type: Repository, setter: false}
  )
end

struct WorkflowRun
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    workflow_runs: {type: Array(WorkflowRunData), setter: false}
  )
end
