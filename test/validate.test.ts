// TODO: Ideally this should be co-located with validate.sh in plugins/mermaid-validator/scripts/.
// However, Claude Code plugin system has no file exclusion mechanism (no .pluginignore).
// Entire plugin directory is copied to cache, so test files must be placed externally.

import { describe, test, expect } from "bun:test";
import { $ } from "bun";

const VALIDATOR = `${import.meta.dir}/../plugins/mermaid-validator/scripts/validate.sh`;

describe("validate.sh", () => {
  test("file input", async () => {
    const tmpFile = "/tmp/test.mmd";
    await Bun.write(tmpFile, "flowchart TD\n    A --> B");

    const result = await $`bash ${VALIDATOR} ${tmpFile}`.text();
    await $`rm -f ${tmpFile}`;

    expect(result).toContain("✅ Valid - flowchart");
  });

  test("stdin input", async () => {
    const result = await $`echo 'sequenceDiagram
    A->>B: Hello' | bash ${VALIDATOR}`.text();

    expect(result).toContain("✅ Valid - sequence");
  });

  test("invalid diagram", async () => {
    const result = await $`echo 'invalid' | bash ${VALIDATOR}`.nothrow().text();

    expect(result).toContain("❌ Invalid");
  });
});
