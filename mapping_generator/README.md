## Usage
```js
const JSON = {
  "sha": "7638417db6d59f3c431d3e1f261cc637155684cd",
  "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
  "author": {
    "date": "2014-11-07T22:01:45Z",
    "name": "Monalisa Octocat",
    "email": "octocat@github.com"
  },
  "committer": {
    "date": "2014-11-07T22:01:45Z",
    "name": "Monalisa Octocat",
    "email": "octocat@github.com"
  },
  "message": "added readme, because im a good github citizen",
  "tree": {
    "url": "https://api.github.com/repos/octocat/Hello-World/git/trees/691272480426f78a0138979dd3ce63b77f706feb",
    "sha": "691272480426f78a0138979dd3ce63b77f706feb"
  },
  "parents": [
    {
      "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/1acc419d4d6a9ce985db7be48c6349a0475975b5",
      "sha": "1acc419d4d6a9ce985db7be48c6349a0475975b5"
    }
  ],
  "verification": {
    "verified": false,
    "reason": "unsigned",
    "signature": null,
    "payload": null
  }
}

generate(JSON, "Commit");
```

### Generates:
```cr
struct Parents
  JSON.mapping(
    url: String,
    sha: String
  )
end


struct Author
  JSON.mapping(
    date: String,
    name: String,
    email: String
  )
end

struct Committer
  JSON.mapping(
    date: String,
    name: String,
    email: String
  )
end

struct Tree
  JSON.mapping(
    url: String,
    sha: String
  )
end

struct Verification
  JSON.mapping(
    verified: Bool,
    reason: String,
    signature: <CHANGE_ME>,
    payload: <CHANGE_ME>
  )
end

struct Commit
  JSON.mapping(
    sha: String,
    url: String,
    author: Author,
    committer: Committer,
    message: String,
    tree: Tree,
    parents: Array(Parents),
    verification: Payload
  )
end
```
