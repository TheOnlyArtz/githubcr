require "../spec_helper.cr"

describe TagPayload do
  it "Should serialize" do
    payload = TagPayload.new(
      tag: "v0.0.1",
      message: "Initial version\n",
      object: "c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c",
      type: "commit",
      tagger: TagPayload::Tagger.new(
        name: "Amit"
      )
    ).to_json

    equal = {
      "tag"     => "v0.0.1",
      "message" => "Initial version\n",
      "object"  => "c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c",
      "type"    => "commit",
      "tagger"  => {
        "name" => "Amit",
      },
    }

    payload.should eq(equal.to_json)
  end
end
