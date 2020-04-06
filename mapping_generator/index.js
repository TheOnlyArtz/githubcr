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
      code.push("  ".repeat(indentationLevel) + `${key}: ${newKey}`);
    } else if (typeof(payload[key]) == "object" && payload[key].length != undefined) {
      // ARRAY
      let newKey = key.replaceAt(0, key[0].toUpperCase());
      children.push(generate(payload[key][0], newKey, indentationLevel, false));
      code.push("  ".repeat(indentationLevel) + `${key}: Array(${newKey})`);
    } else {
      code.push("  ".repeat(indentationLevel) + `${key}: ${keyMappings[typeof(payload[key])]}`);
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
  "sha": "388e61b6c707367aca2b9737766835f4cbe2cbb4",
  "node_id": "MDY6Q29tbWl0NTY1MTAyMTk6Mzg4ZTYxYjZjNzA3MzY3YWNhMmI5NzM3NzY2ODM1ZjRjYmUyY2JiNA==",
  "commit": {
    "author": {
      "name": "SinisterRectus",
      "email": "sinister.rectus@gmail.com",
      "date": "2020-03-06T17:09:36Z"
    },
    "committer": {
      "name": "SinisterRectus",
      "email": "sinister.rectus@gmail.com",
      "date": "2020-03-06T17:09:36Z"
    },
    "message": "Fixes ratelimit header lookup",
    "tree": {
      "sha": "4dc8c11d8c1a0e588a7a05ce103fcf5ca3e63a0d",
      "url": "https://api.github.com/repos/SinisterRectus/Discordia/git/trees/4dc8c11d8c1a0e588a7a05ce103fcf5ca3e63a0d"
    },
    "url": "https://api.github.com/repos/SinisterRectus/Discordia/git/commits/388e61b6c707367aca2b9737766835f4cbe2cbb4",
    "comment_count": 0,
    "verification": {
      "verified": false,
      "reason": "unsigned",
      "signature": null,
      "payload": null
    }
  },
  "url": "https://api.github.com/repos/SinisterRectus/Discordia/commits/388e61b6c707367aca2b9737766835f4cbe2cbb4",
  "html_url": "https://github.com/SinisterRectus/Discordia/commit/388e61b6c707367aca2b9737766835f4cbe2cbb4",
  "comments_url": "https://api.github.com/repos/SinisterRectus/Discordia/commits/388e61b6c707367aca2b9737766835f4cbe2cbb4/comments",
  "author": {
    "login": "SinisterRectus",
    "id": 11720541,
    "node_id": "MDQ6VXNlcjExNzIwNTQx",
    "avatar_url": "https://avatars1.githubusercontent.com/u/11720541?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/SinisterRectus",
    "html_url": "https://github.com/SinisterRectus",
    "followers_url": "https://api.github.com/users/SinisterRectus/followers",
    "following_url": "https://api.github.com/users/SinisterRectus/following{/other_user}",
    "gists_url": "https://api.github.com/users/SinisterRectus/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/SinisterRectus/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/SinisterRectus/subscriptions",
    "organizations_url": "https://api.github.com/users/SinisterRectus/orgs",
    "repos_url": "https://api.github.com/users/SinisterRectus/repos",
    "events_url": "https://api.github.com/users/SinisterRectus/events{/privacy}",
    "received_events_url": "https://api.github.com/users/SinisterRectus/received_events",
    "type": "User",
    "site_admin": false
  },
  "committer": {
    "login": "SinisterRectus",
    "id": 11720541,
    "node_id": "MDQ6VXNlcjExNzIwNTQx",
    "avatar_url": "https://avatars1.githubusercontent.com/u/11720541?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/SinisterRectus",
    "html_url": "https://github.com/SinisterRectus",
    "followers_url": "https://api.github.com/users/SinisterRectus/followers",
    "following_url": "https://api.github.com/users/SinisterRectus/following{/other_user}",
    "gists_url": "https://api.github.com/users/SinisterRectus/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/SinisterRectus/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/SinisterRectus/subscriptions",
    "organizations_url": "https://api.github.com/users/SinisterRectus/orgs",
    "repos_url": "https://api.github.com/users/SinisterRectus/repos",
    "events_url": "https://api.github.com/users/SinisterRectus/events{/privacy}",
    "received_events_url": "https://api.github.com/users/SinisterRectus/received_events",
    "type": "User",
    "site_admin": false
  },
  "parents": [
    {
      "sha": "8ad5334d8fe27223383cc98a1941b31f0fa113e8",
      "url": "https://api.github.com/repos/SinisterRectus/Discordia/commits/8ad5334d8fe27223383cc98a1941b31f0fa113e8",
      "html_url": "https://github.com/SinisterRectus/Discordia/commit/8ad5334d8fe27223383cc98a1941b31f0fa113e8"
    }
  ],
  "stats": {
    "total": 8,
    "additions": 4,
    "deletions": 4
  },
  "files": [
    {
      "sha": "ff06915c2aa905d35c5072246a16cfbe6109ca29",
      "filename": "libs/client/API.lua",
      "status": "modified",
      "additions": 4,
      "deletions": 4,
      "changes": 8,
      "blob_url": "https://github.com/SinisterRectus/Discordia/blob/388e61b6c707367aca2b9737766835f4cbe2cbb4/libs/client/API.lua",
      "raw_url": "https://github.com/SinisterRectus/Discordia/raw/388e61b6c707367aca2b9737766835f4cbe2cbb4/libs/client/API.lua",
      "contents_url": "https://api.github.com/repos/SinisterRectus/Discordia/contents/libs/client/API.lua?ref=388e61b6c707367aca2b9737766835f4cbe2cbb4",
      "patch": "@@ -187,15 +187,15 @@ function API:commit(method, url, req, payload, retries)\n \tend\n \n \tfor i, v in ipairs(res) do\n-\t\tres[v[1]] = v[2]\n+\t\tres[v[1]:lower()] = v[2]\n \t\tres[i] = nil\n \tend\n \n-\tif res['X-RateLimit-Remaining'] == '0' then\n-\t\tdelay = max(1000 * res['X-RateLimit-Reset-After'], delay)\n+\tif res['x-ratelimit-remaining'] == '0' then\n+\t\tdelay = max(1000 * res['x-ratelimit-reset-after'], delay)\n \tend\n \n-\tlocal data = res['Content-Type'] == JSON and decode(msg, 1, null) or msg\n+\tlocal data = res['content-type'] == JSON and decode(msg, 1, null) or msg\n \n \tif res.code < 300 then\n "
    }
  ]
}

console.log(generate(JSON, "Commit", 2, true));
