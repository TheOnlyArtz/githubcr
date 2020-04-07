require "../spec_helper"

describe RefPayload do
  it "Should serialize" do
    payload = RefPayload.new(
      ref: "refs/heads/featureA",
      sha: "aa218f56b14c9653891f9e74264a383fa43fefbd"
    ).to_json

    equal = {
      "ref" => "refs/heads/featureA",
      "sha" => "aa218f56b14c9653891f9e74264a383fa43fefbd",
    }

    payload.should eq(equal.to_json)
  end
end
