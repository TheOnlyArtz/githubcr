require "json"
require "./spec_helper"

describe GitHub do
  # TODO: Write tests

  it "works" do
    false.should eq(false)
  end
end

describe GistCreationPayload do
  it "Should serialize" do
    payload = GistCreationPayload.new(
        description: "This is a description",
        public: true,
        files: {
          "test.cr" => GistFilePayload.new(content: "This is some content"),
          "test2.cr" => GistFilePayload.new(content: "This is some content")
        }
    )

    equal = {
      "description" => "This is a description",
      "public" => true,
      "files" => {
        "test.cr" => {
          "content" => "This is some content"
        },
        "test2.cr" => {
          "content" => "This is some content"
        }
      }
    }

    payload.to_json.should eq(equal.to_json)
  end
end
