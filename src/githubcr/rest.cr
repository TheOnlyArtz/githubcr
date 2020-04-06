require "http/client"
require "./mappings/*"

module GitHub
  # This module enables GitHub.cr to interact with the
  # GitHub API through HTTP requests
  module REST

    API_BASE = "api.github.com"
    HTTP_CLIENT = HTTP::Client.new API_BASE, tls: true
    GLOBAL_MUTEX = Mutex.new

    # This function is responsible for requesting the API

    def self.raw_request(method : String, path : String, headers : HTTP::Headers, body : String?)
      request_done = false

      until request_done
        GLOBAL_MUTEX.synchronize {}

        response = HTTP_CLIENT.exec(
          method: method,
          path: path,
          headers: headers,
          body: body
        )

        if response.status_code == 429 || response.headers["X-RateLimit-Remaining"]? == 0
          retry_after_val = response.headers["X-RateLimit-Reset-After"]?
          retry_after = retry_after_val.not_nil!.to_f

          GLOBAL_MUTEX.synchronize {sleep retry_after}

          request_done = true unless response.status_code == 429
        else
          request_done = true
        end
      end

      response.not_nil!
    end

    def self.request(method : String, path : String, headers : HTTP::Headers, body : String?)
      response = raw_request(method, path, headers, body)

      unless response.success?
        raise "Unknown payload" unless response.content_type == "application/json; charset=utf-8"
      end

      response.body
    end

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
      # NOTE: This will return the public repositories only
      # if it wasn't obvious already...
      def get_all_gists(owner : String)
        json = REST.request(
          "GET",
          "/users/#{owner}/gists",
          HTTP::Headers{"Authorization" => get_auth_header},
          nil
        )

        Array(Gist).from_json(json)
      end
    end
  end
end
