module GitHub
  # The basic class which represents a GitHub client / user
  # the client will be used to send REST requests to the GitHub
  # API.
  #
  # ```cr
  # client = GitHub::Client.new(username: "TheOnlyArtz", token: "4f10YOU8654d442b5be610054e9sWISH7a813c4")
  #```
  # With this client you will be able to make API requests to Discord
  class Client
    def initialize(@username : String, @access_token : String)
    end
  end
end
