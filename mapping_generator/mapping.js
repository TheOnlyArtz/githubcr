let keyMappings = {
  "string": "String",
  "boolean": "Bool",
  "number": "Int32",

}

let reserved = [
  "File",
  "Object",
  "Reference"
];

let predefined = [
  "User"
];

String.prototype.replaceAt=function(index, replacement) {
    return this.substr(0, index) + replacement+ this.substr(index + replacement.length);
}

function getNewKey(key, name, root, array = false) {
  let newKey = key.replaceAt(0, key[0].toUpperCase());
  if (array) newKey = newKey.replaceAt(newKey.length - 1, ""); // delete the last char `s`
  if (reserved.includes(newKey))
    newKey = name + newKey;

  return newKey;
}

function generate(payload, name, indentationLevel = 2, root = true, rootName) {
  if (!payload)
    return "";

  let keys = Object.keys(payload);
  let code = [
    `struct ${!root ? rootName + "::" : ""}${name}`,
    "  JSON.mapping("
  ];

  // Children structs
  let children = []
  let i = 0;
  keys.forEach(key => {
    if (payload[key] == null) {
      let newKey = getNewKey(key, name, root);
      code.push("  ".repeat(indentationLevel) + `${key}: <CHANGE_ME>`);
    } else if (typeof(payload[key]) == "object" && payload[key].length == undefined){
      let newKey = getNewKey(key, name, root);
      newKey = root ? newKey : name + newKey;
      children.push(generate(payload[key], newKey, indentationLevel, false, rootName));
      code.push("  ".repeat(indentationLevel) + `${key}: {type: ${newKey}, setter: false}`);
    } else if (typeof(payload[key]) == "object" && payload[key].length != undefined) {
      // ARRAY
      let newKey = getNewKey(key, name, root, true);
      children.push(generate(payload[key][0], newKey, indentationLevel, false, rootName));
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
  "total_count": 1,
  "workflow_runs": [
    {
      "id": 30433642,
      "node_id": "MDEyOldvcmtmbG93IFJ1bjI2OTI4OQ==",
      "head_branch": "master",
      "head_sha": "acb5820ced9479c074f688cc328bf03f341a511d",
      "run_number": 562,
      "event": "push",
      "status": "queued",
      "conclusion": null,
      "url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642",
      "html_url": "https://github.com/octo-org/octo-repo/actions/runs/30433642",
      "pull_requests": [

      ],
      "created_at": "2020-01-22T19:33:08Z",
      "updated_at": "2020-01-22T19:33:08Z",
      "jobs_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/jobs",
      "logs_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/logs",
      "check_suite_url": "https://api.github.com/repos/octo-org/octo-repo/check-suites/414944374",
      "artifacts_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/artifacts",
      "cancel_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/cancel",
      "rerun_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/rerun",
      "workflow_url": "https://api.github.com/repos/octo-org/octo-repo/actions/workflows/30433642",
      "head_commit": {
        "id": "acb5820ced9479c074f688cc328bf03f341a511d",
        "tree_id": "d23f6eedb1e1b9610bbc754ddb5197bfe7271223",
        "message": "Create linter.yml",
        "timestamp": "2020-01-22T19:33:05Z",
        "author": {
          "name": "Octo Cat",
          "email": "octocat@github.com"
        },
        "committer": {
          "name": "GitHub",
          "email": "noreply@github.com"
        }
      },
      "repository": {
        "id": 1296269,
        "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
        "name": "Hello-World",
        "full_name": "octocat/Hello-World",
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
        "private": false,
        "html_url": "https://github.com/octocat/Hello-World",
        "description": "This your first repo!",
        "fork": false,
        "url": "https://api.github.com/repos/octocat/Hello-World",
        "archive_url": "http://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
        "assignees_url": "http://api.github.com/repos/octocat/Hello-World/assignees{/user}",
        "blobs_url": "http://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
        "branches_url": "http://api.github.com/repos/octocat/Hello-World/branches{/branch}",
        "collaborators_url": "http://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
        "comments_url": "http://api.github.com/repos/octocat/Hello-World/comments{/number}",
        "commits_url": "http://api.github.com/repos/octocat/Hello-World/commits{/sha}",
        "compare_url": "http://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
        "contents_url": "http://api.github.com/repos/octocat/Hello-World/contents/{+path}",
        "contributors_url": "http://api.github.com/repos/octocat/Hello-World/contributors",
        "deployments_url": "http://api.github.com/repos/octocat/Hello-World/deployments",
        "downloads_url": "http://api.github.com/repos/octocat/Hello-World/downloads",
        "events_url": "http://api.github.com/repos/octocat/Hello-World/events",
        "forks_url": "http://api.github.com/repos/octocat/Hello-World/forks",
        "git_commits_url": "http://api.github.com/repos/octocat/Hello-World/git/commits{/sha}",
        "git_refs_url": "http://api.github.com/repos/octocat/Hello-World/git/refs{/sha}",
        "git_tags_url": "http://api.github.com/repos/octocat/Hello-World/git/tags{/sha}",
        "git_url": "git:github.com/octocat/Hello-World.git",
        "issue_comment_url": "http://api.github.com/repos/octocat/Hello-World/issues/comments{/number}",
        "issue_events_url": "http://api.github.com/repos/octocat/Hello-World/issues/events{/number}",
        "issues_url": "http://api.github.com/repos/octocat/Hello-World/issues{/number}",
        "keys_url": "http://api.github.com/repos/octocat/Hello-World/keys{/key_id}",
        "labels_url": "http://api.github.com/repos/octocat/Hello-World/labels{/name}",
        "languages_url": "http://api.github.com/repos/octocat/Hello-World/languages",
        "merges_url": "http://api.github.com/repos/octocat/Hello-World/merges",
        "milestones_url": "http://api.github.com/repos/octocat/Hello-World/milestones{/number}",
        "notifications_url": "http://api.github.com/repos/octocat/Hello-World/notifications{?since,all,participating}",
        "pulls_url": "http://api.github.com/repos/octocat/Hello-World/pulls{/number}",
        "releases_url": "http://api.github.com/repos/octocat/Hello-World/releases{/id}",
        "ssh_url": "git@github.com:octocat/Hello-World.git",
        "stargazers_url": "http://api.github.com/repos/octocat/Hello-World/stargazers",
        "statuses_url": "http://api.github.com/repos/octocat/Hello-World/statuses/{sha}",
        "subscribers_url": "http://api.github.com/repos/octocat/Hello-World/subscribers",
        "subscription_url": "http://api.github.com/repos/octocat/Hello-World/subscription",
        "tags_url": "http://api.github.com/repos/octocat/Hello-World/tags",
        "teams_url": "http://api.github.com/repos/octocat/Hello-World/teams",
        "trees_url": "http://api.github.com/repos/octocat/Hello-World/git/trees{/sha}"
      },
      "head_repository": {
        "id": 217723378,
        "node_id": "MDEwOlJlcG9zaXRvcnkyMTc3MjMzNzg=",
        "name": "octo-repo",
        "full_name": "octo-org/octo-repo",
        "private": true,
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
        "html_url": "https://github.com/octo-org/octo-repo",
        "description": null,
        "fork": false,
        "url": "https://api.github.com/repos/octo-org/octo-repo",
        "forks_url": "https://api.github.com/repos/octo-org/octo-repo/forks",
        "keys_url": "https://api.github.com/repos/octo-org/octo-repo/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/octo-org/octo-repo/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/octo-org/octo-repo/teams",
        "hooks_url": "https://api.github.com/repos/octo-org/octo-repo/hooks",
        "issue_events_url": "https://api.github.com/repos/octo-org/octo-repo/issues/events{/number}",
        "events_url": "https://api.github.com/repos/octo-org/octo-repo/events",
        "assignees_url": "https://api.github.com/repos/octo-org/octo-repo/assignees{/user}",
        "branches_url": "https://api.github.com/repos/octo-org/octo-repo/branches{/branch}",
        "tags_url": "https://api.github.com/repos/octo-org/octo-repo/tags",
        "blobs_url": "https://api.github.com/repos/octo-org/octo-repo/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/octo-org/octo-repo/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/octo-org/octo-repo/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/octo-org/octo-repo/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/octo-org/octo-repo/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/octo-org/octo-repo/languages",
        "stargazers_url": "https://api.github.com/repos/octo-org/octo-repo/stargazers",
        "contributors_url": "https://api.github.com/repos/octo-org/octo-repo/contributors",
        "subscribers_url": "https://api.github.com/repos/octo-org/octo-repo/subscribers",
        "subscription_url": "https://api.github.com/repos/octo-org/octo-repo/subscription",
        "commits_url": "https://api.github.com/repos/octo-org/octo-repo/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/octo-org/octo-repo/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/octo-org/octo-repo/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/octo-org/octo-repo/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/octo-org/octo-repo/contents/{+path}",
        "compare_url": "https://api.github.com/repos/octo-org/octo-repo/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/octo-org/octo-repo/merges",
        "archive_url": "https://api.github.com/repos/octo-org/octo-repo/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/octo-org/octo-repo/downloads",
        "issues_url": "https://api.github.com/repos/octo-org/octo-repo/issues{/number}",
        "pulls_url": "https://api.github.com/repos/octo-org/octo-repo/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/octo-org/octo-repo/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/octo-org/octo-repo/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/octo-org/octo-repo/labels{/name}",
        "releases_url": "https://api.github.com/repos/octo-org/octo-repo/releases{/id}",
        "deployments_url": "https://api.github.com/repos/octo-org/octo-repo/deployments"
      }
    }
  ]
}

let name = "WorkflowRun"
console.log(`struct ${name}\nend\n\n`);
console.log(generate(JSON, name, 2, true, name));
