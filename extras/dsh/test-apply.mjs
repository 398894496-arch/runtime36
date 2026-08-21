#!/usr/bin/env node
/**
 * Register + execute against the template vault. Does not import DSH peers
 * and does not call `dsh plugin add`.
 */
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { registerKrouterTools } from "./lib/register.js";

const HERE = dirname(fileURLToPath(import.meta.url));
const registered = [];
registerKrouterTools(
  {
    tools: {
      register(tool) {
        registered.push(tool);
      },
    },
  },
  {
    vaultPath: join(HERE, "../../template"),
    routerScript: join(HERE, "../../skill/krouter-obsidian/scripts/route_knowledge.sh"),
  },
  (spec) => spec,
);

const names = registered.map((t) => t.name);
if (names.join() !== "krouter_status,krouter_search,krouter_suggest") {
  console.error("FAIL tool names", names);
  process.exit(1);
}

const search = registered.find((t) => t.name === "krouter_search");
const out = await Promise.resolve(search.execute({ query: "home" }));
if (!out.ok || out.canonical_id !== "Q01" || out.canonical_match !== "true") {
  console.error("FAIL execute search home", out);
  process.exit(1);
}

const suggest = registered.find((t) => t.name === "krouter_suggest");
const hint = await Promise.resolve(suggest.execute({ query: "homz" }));
if (!hint.text.includes("Q01") || hint.canonical_match === "true") {
  console.error("FAIL execute suggest", hint);
  process.exit(1);
}

console.log("ok register + execute on template");
