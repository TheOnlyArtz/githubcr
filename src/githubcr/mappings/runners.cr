struct SelfHostedRunners
  JSON.mapping(
    total_count: {type: Int32, setter: false},
    runners: {type: Array(SelfHostedRunnerData), setter: false}
  )
end

struct SelfHostedRunners::SelfHostedRunnerData
  JSON.mapping(
    os: {type: String, setter: false},
    architecture: {type: String, setter: false},
    download_url: {type: String, setter: false},
    filename: {type: String, setter: false}
  )
end

struct RegistrationToken
  JSON.mapping(
    token: {type: String, setter: false},
    expires_at: {type: String, setter: false}
  )
end
