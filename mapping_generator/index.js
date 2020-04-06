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

/**
* @param {Object} payload
**/

function getNewKey(key, name, root, array = false) {
  let newKey = key.replaceAt(0, key[0].toUpperCase());
  if (array) newKey = newKey.replaceAt(newKey.length - 1, ""); // delete the last char `s`
  if (reserved.includes(newKey))
    newKey = name + newKey;

  return newKey;
}

function generate(payload, name, indentationLevel = 2, root = true) {
  if (!payload)
    return "";

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
      let newKey = getNewKey(key, name, root);
      code.push("  ".repeat(indentationLevel) + `${key}: <CHANGE_ME>`);
    } else if (typeof(payload[key]) == "object" && payload[key].length == undefined){
      let newKey = getNewKey(key, name, root);
      newKey = root ? newKey : name + newKey;
      children.push(generate(payload[key], newKey, indentationLevel, false));
      code.push("  ".repeat(indentationLevel) + `${key}: {type: ${newKey}, setter: false}`);
    } else if (typeof(payload[key]) == "object" && payload[key].length != undefined) {
      // ARRAY
      let newKey = getNewKey(key, name, root, true);
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
  "ref": "refs/heads/featureA",
  "node_id": "MDM6UmVmcmVmcy9oZWFkcy9mZWF0dXJlQQ==",
  "url": "https://api.github.com/repos/octocat/Hello-World/git/refs/heads/featureA",
  "object": {
    "type": "commit",
    "sha": "aa218f56b14c9653891f9e74264a383fa43fefbd",
    "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/aa218f56b14c9653891f9e74264a383fa43fefbd"
  }
}

console.log(generate(JSON, "Ref", 2, true));
