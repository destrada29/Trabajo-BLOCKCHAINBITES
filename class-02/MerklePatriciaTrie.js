var { Trie } = require("@ethereumjs/trie");

async function main() {
  var trie = new Trie();

  await trie.put(buffer("0xblock01"), buffer("0xblock01Value"));
  await trie.put(buffer("0xblock01B"), buffer("0xblock012Value"));
  await trie.put(buffer("0xblock019001"), buffer("0xblock012001Value"));
  await trie.put(buffer("0xblock01X002"), buffer("0xblock012002Value"));
  await trie.put(buffer("0xblock012003"), buffer("0xblock012003Value"));
  await trie.put(
    buffer("0xblock012004AAAAAA"),
    buffer("0xblock012004AAAAAAValue")
  );
  await trie.put(
    buffer("0xblock012004AAAAAB"),
    buffer("0xblock012004AAAAABValue")
  );
  await trie.put(
    buffer("0xblock012004BBBBBB"),
    buffer("0xblock012004BBBBBBValue")
  );
}

function buffer(data) {
  return Buffer.from(data);
}

main();
