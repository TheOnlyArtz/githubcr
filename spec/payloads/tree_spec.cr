require "../spec_helper.cr"
describe TreePayload do
  it "Should serialize" do
    payload = TreePayload.new(
      tree: [
        TreePayload::Tree.new(
          path: "file.rb",
          mode: "100644",
          type: "blob",
          sha: "44b4fc6d56897b048c772eb4087f854f46256132"
        ),
      ],
      base_tree: "9fb037999f264ba9a7fc6274d15fa3ae2ab98312"
    ).to_json

    equal = {
      "tree" => [
        {
          "path" => "file.rb",
          "mode" => "100644",
          "type" => "blob",
          "sha"  => "44b4fc6d56897b048c772eb4087f854f46256132",
        },
      ],
      "base_tree" => "9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
    }

    payload.should eq(equal.to_json)
  end
end
