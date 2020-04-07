require "../spec_helper.cr"

describe CommitPayload do
  it "Should serialize" do
    payload = CommitPayload.new(
      message: "My commit message",
      tree: "827efc6d56897b048c772eb4087f854f46256132",
      parents: [
        "7d1b31e74ee336d15cbd21741bc88a537ed063a0"
      ],
      author: CommitPayload::Author.new(
        name: "Amit Katz"
      ),
      signature: "MY LONG SIGNATURE"
    ).to_json

    equal = {
      "message" => "My commit message",
      "tree" => "827efc6d56897b048c772eb4087f854f46256132",
      "parents" => [
        "7d1b31e74ee336d15cbd21741bc88a537ed063a0"
      ],
      "author" => {
        "name" => "Amit Katz"
      },
      "signature" => "MY LONG SIGNATURE"
    }

    payload.should eq(equal.to_json)
  end
end
