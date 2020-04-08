require "base64"
require "./rest.cr"

module GitHub
  # The basic class which represents a GitHub client / user
  # the client will be used to send REST requests to the GitHub
  # API.
  #
  # ```cr
  # client = GitHub::Client.new(username: "TheOnlyArtz", token: "4f10YOU8654d442b5be610054e9sWISH7a813c4")
  # ```
  # With this client you will be able to make API requests to GitHub
  class Client
    include REST::Gists
    include REST::Blobs
    include REST::Commits
    include REST::References
    include REST::Tags
    include REST::Trees
    include REST::Artifacts
    include REST::Secrets
    include REST::SelfHostedWorkflowRunners
    include REST::Workflows
    include REST::WorkflowJobs
    include REST::WorkflowRuns
    include REST::GitHubApps
    include REST::Installations

    def initialize(@username : String, @access_token : String)
    end

    # This method will generate the auth header to GitHub
    def get_auth_header
      "Basic #{Base64.strict_encode("#{@username}:#{@access_token}")}"
    end
  end
end
