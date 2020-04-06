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
function generate(payload, name, indentationLevel = 2) {
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
      newKey = key.replaceAt(0, key[0].toUpperCase());
      code.push("  ".repeat(indentationLevel) + `${key}: <CHANGE_ME>`);
    } else if (typeof(payload[key]) == "object" && payload[key].length == undefined){
      newKey = key.replaceAt(0, key[0].toUpperCase());
      children.push(generate(payload[key], newKey, indentationLevel));
      code.push("  ".repeat(indentationLevel) + `${key}: ${newKey}`);
    } else if (typeof(payload[key]) == "object" && payload[key].length != undefined) {
      // ARRAY
      newKey = key.replaceAt(0, key[0].toUpperCase());
      console.log(generate(payload[key][0], newKey, indentationLevel))
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

console.log(generate(JSON, "Commit"));
