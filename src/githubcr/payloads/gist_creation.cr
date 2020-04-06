# Represents a file
struct GistCreationFilePayload
  property content
  def initialize(@content : String)
  end

  def to_h
    {
      "content" => @content
    }
  end
end

# Represents gist creation payload
struct GistCreationPayload
  def initialize(@description : String, @public : Bool, @files : Hash(String, GistCreationFilePayload))
  end

  def to_h
    {
      "description" => @description,
      "public" => @public,
      "files" => @files
    }
  end
end
