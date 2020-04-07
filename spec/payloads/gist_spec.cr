require "../spec_helper.cr"

describe GistPayload do
  it "Should serialize" do
    payload = GistPayload.new(
      description: "This is a description",
      public: true,
      files: {
        "test.cr"  => GistPayload::GistFilePayload.new(content: "This is some content"),
        "test2.cr" => GistPayload::GistFilePayload.new(content: "This is some content"),
      }
    )

    equal = {
      "files" => {
        "test.cr" => {
          "content" => "This is some content",
        },
        "test2.cr" => {
          "content" => "This is some content",
        },
      },
      "description" => "This is a description",
      "public"      => true,
    }

    payload.to_json.should eq(equal.to_json)
  end
end
