require "http/client"
require "./mappings/*"

module GitHub
  # This module enables GitHub.cr to interact with the
  # GitHub API through HTTP requests
  module REST
    # This module is specifically for interacting with
    # the Events endpoint GitHub offer us to use.
    # see [GitHub Events endpoints](https://developer.github.com/v3/activity/events/)
    # TODO ↑
    module Events

    end

    # This module is specifically for interacting with
    # the Gists endpoints GitHub offers us to use.
    # see [GitHub Gists endpoints](https://developer.github.com/v3/gists/)
    module Gists

    end
  end
end
