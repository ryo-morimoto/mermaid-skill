import { readFileSync } from "fs";
import { parse } from "mermaid-ast";

const file = process.argv[2];
let input: string;

if (file && file !== "-") {
  input = readFileSync(file, "utf8");
} else {
  input = readFileSync("/dev/stdin", "utf8");
}

try {
  const ast = parse(input.trim());
  console.log("✅ Valid -", ast.type);
  process.exit(0);
} catch (e) {
  console.log("❌ Invalid");
  console.log((e as Error).message);
  process.exit(1);
}
