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

function generate(name, payload, rootname) {
  let children = [];
  let keys = Object.keys(payload);

  let code = `record ${name === rootname ? name : `${rootname}::${name}`},\n`;
  let generatedCode = "";

  keys.forEach((key, i) => {
    if (payload[key] === null) code += generateNull(name, key);
    else if (payload[key] instanceof Array) {

      let newKey = key.replaceAt(0, key[0].toUpperCase());
      generatedCode = generate(newKey, payload[key][0], rootname);
      children.push(generatedCode);
      code += `  ${key} : Array(${name}::${newKey})`
    } else if (payload[key] instanceof Object) {
      let newKey = key.replaceAt(0, key[0].toUpperCase());
      generatedCode = generate(newKey, payload[key], rootname);
      children.push(generatedCode);
      code += `  ${key} : ${name}::${newKey}`
    } else {
      code += `  ${key} : ${keyMappings[typeof(payload[key])]}`
    }
    if (i != keys.length - 1) code += ',\n';
    else code += " "
  });

  code += "do\n    include JSON::Serializable\nend\n"

  if (rootname === name)
  {
    children.push(code);
    children = children.reverse();
    children.forEach(s => console.log(s));
    // children.forEach(s => console.log(s));
  }
  return code;
}

function generateNull(key) {
  return `  ${key} : <CHANGE_ME>`;
}

let JSON = {
  "base_tree": "9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
  "tree": [
    {
      "path": "file.rb",
      "mode": "100644",
      "type": "blob",
      "sha": "44b4fc6d56897b048c772eb4087f854f46256132"
    }
  ]
}

let name = "Tree";
console.log("require \"json\"\n");
generate(name + "Payload", JSON, name + "Payload");
