keyMappings = {
  "string": "String",
  "boolean": "Bool",
  "number": "Int32",

}

String.prototype.replaceAt=function(index, replacement) {
    return this.substr(0, index) + replacement+ this.substr(index + replacement.length);
}

/**
* @param {Object} payload
**/
function generate(payload, name, indentationLevel = 2, root = true) {
  if (!payload)
  {
    return "";
  }
  let keys = Object.keys(payload);
  let code = [
    `struct ${name}`,
    "  JSON.mapping("
  ];

  // Children structs
  let children = []
  let i = 0;
  keys.forEach(key => {
    if (payload[key] == null) {
      let newKey = key.replaceAt(0, key[0].toUpperCase());
      code.push("  ".repeat(indentationLevel) + `${key}: <CHANGE_ME>`);
    } else if (typeof(payload[key]) == "object" && payload[key].length == undefined){
      let newKey = key.replaceAt(0, key[0].toUpperCase());
      newKey = root ? newKey : name + newKey;
      children.push(generate(payload[key], newKey, indentationLevel, false));
      code.push("  ".repeat(indentationLevel) + `${key}: {type: ${newKey}, setter: false}`);
    } else if (typeof(payload[key]) == "object" && payload[key].length != undefined) {
      // ARRAY
      let newKey = key.replaceAt(0, key[0].toUpperCase());
      children.push(generate(payload[key][0], newKey, indentationLevel, false));
      code.push("  ".repeat(indentationLevel) + `${key}: {type: Array(${newKey}), setter: false}`);
    } else {
      code.push("  ".repeat(indentationLevel) + `${key}: {type: ${keyMappings[typeof(payload[key])]}, setter: false}`);
    }
    if (i != keys.length - 1) {
      code[code.length - 1] += ",";
    }
    i++;

  });
  code.push("  )");
  code.push("end\n\n");
  if (indentationLevel == 2)
  {
    let finalCode = ""
    children.forEach(s => finalCode += s);
    return finalCode + code.join("\n");
  }

  return code.join("\n");
}

const JSON = {
    "url": "https://api.github.com/gists/aa5a315d61ae9438b18d",
    "forks_url": "https://api.github.com/gists/aa5a315d61ae9438b18d/forks",
    "commits_url": "https://api.github.com/gists/aa5a315d61ae9438b18d/commits",
    "id": "aa5a315d61ae9438b18d",
    "node_id": "MDQ6R2lzdGFhNWEzMTVkNjFhZTk0MzhiMThk",
    "git_pull_url": "https://gist.github.com/aa5a315d61ae9438b18d.git",
    "git_push_url": "https://gist.github.com/aa5a315d61ae9438b18d.git",
    "html_url": "https://gist.github.com/aa5a315d61ae9438b18d",
    "files": {
      "hello_world.rb": {
        "filename": "hello_world.rb",
        "type": "application/x-ruby",
        "language": "Ruby",
        "raw_url": "https://gist.githubusercontent.com/octocat/6cad326836d38bd3a7ae/raw/db9c55113504e46fa076e7df3a04ce592e2e86d8/hello_world.rb",
        "size": 167
      }
    },
    "public": true,
    "created_at": "2010-04-14T02:15:15Z",
    "updated_at": "2011-06-20T11:34:15Z",
    "description": "Hello World Examples",
    "comments": 0,
    "user": null,
    "comments_url": "https://api.github.com/gists/aa5a315d61ae9438b18d/comments/",
    "owner": {
      "login": "octocat",
      "id": 1,
      "node_id": "MDQ6VXNlcjE=",
      "avatar_url": "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id": "",
      "url": "https://api.github.com/users/octocat",
      "html_url": "https://github.com/octocat",
      "followers_url": "https://api.github.com/users/octocat/followers",
      "following_url": "https://api.github.com/users/octocat/following{/other_user}",
      "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
      "organizations_url": "https://api.github.com/users/octocat/orgs",
      "repos_url": "https://api.github.com/users/octocat/repos",
      "events_url": "https://api.github.com/users/octocat/events{/privacy}",
      "received_events_url": "https://api.github.com/users/octocat/received_events",
      "type": "User",
      "site_admin": false
    },
    "truncated": false
}

console.log(generate(JSON, "Commit", 2, true));
