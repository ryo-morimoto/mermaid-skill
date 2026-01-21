import { describe, test, expect } from "bun:test";
import { $ } from "bun";

const VALIDATOR = `${import.meta.dir}/../plugins/dist/validate.mjs`;

describe("validate", () => {
  test("file input", async () => {
    const tmpFile = "/tmp/test.mmd";
    await Bun.write(tmpFile, "flowchart TD\n    A --> B");

    const result = await $`node ${VALIDATOR} ${tmpFile}`.text();
    await $`rm -f ${tmpFile}`;

    expect(result).toContain("✅ Valid - flowchart");
  });

  test("stdin input", async () => {
    const result = await $`echo 'sequenceDiagram
    A->>B: Hello' | node ${VALIDATOR}`.text();

    expect(result).toContain("✅ Valid - sequence");
  });

  test("invalid diagram", async () => {
    const result = await $`echo 'invalid' | node ${VALIDATOR}`.nothrow().text();

    expect(result).toContain("❌ Invalid");
  });
});
