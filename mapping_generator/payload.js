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
    else if (payload[key] instanceof Object) {
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
  "message": "my commit message",
  "author": {
    "name": "Mona Octocat",
    "email": "octocat@github.com",
    "date": "2008-07-09T16:13:30+12:00"
  },
  "tree": "827efc6d56897b048c772eb4087f854f46256132",
  "signature": "-----BEGIN PGP SIGNATURE-----\n\niQIzBAABAQAdFiEESn/54jMNIrGSE6Tp6cQjvhfv7nAFAlnT71cACgkQ6cQjvhfv\n7nCWwA//XVqBKWO0zF+bZl6pggvky3Oc2j1pNFuRWZ29LXpNuD5WUGXGG209B0hI\nDkmcGk19ZKUTnEUJV2Xd0R7AW01S/YSub7OYcgBkI7qUE13FVHN5ln1KvH2all2n\n2+JCV1HcJLEoTjqIFZSSu/sMdhkLQ9/NsmMAzpf/iIM0nQOyU4YRex9eD1bYj6nA\nOQPIDdAuaTQj1gFPHYLzM4zJnCqGdRlg0sOM/zC5apBNzIwlgREatOYQSCfCKV7k\nnrU34X8b9BzQaUx48Qa+Dmfn5KQ8dl27RNeWAqlkuWyv3pUauH9UeYW+KyuJeMkU\n+NyHgAsWFaCFl23kCHThbLStMZOYEnGagrd0hnm1TPS4GJkV4wfYMwnI4KuSlHKB\njHl3Js9vNzEUQipQJbgCgTiWvRJoK3ENwBTMVkKHaqT4x9U4Jk/XZB6Q8MA09ezJ\n3QgiTjTAGcum9E9QiJqMYdWQPWkaBIRRz5cET6HPB48YNXAAUsfmuYsGrnVLYbG+\nUpC6I97VybYHTy2O9XSGoaLeMI9CsFn38ycAxxbWagk5mhclNTP5mezIq6wKSwmr\nX11FW3n1J23fWZn5HJMBsRnUCgzqzX3871IqLYHqRJ/bpZ4h20RhTyPj5c/z7QXp\neSakNQMfbbMcljkha+ZMuVQX1K9aRlVqbmv3ZMWh+OijLYVU2bc=\n=5Io4\n-----END PGP SIGNATURE-----\n"
}

let name = "CommitPayload";
console.log("require \"json\"\n");
generate(name, JSON, name);
