require "../spec_helper.cr"
describe BlobPayload do
  it "Should serialize" do
    payload = BlobPayload.new(
      content: "This is some content"
    ).to_json

    equal = {
      "content" => "This is some content",
      "encode" => "utf-8"
    }

    payload.should eq(equal.to_json)
  end
end
