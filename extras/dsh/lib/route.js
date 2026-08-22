#!/usr/bin/env node
/**
 * Spawn KRouter. No vector store. Read-only routes only.
 */
import { spawnSync } from "node:child_process";
import { existsSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const ALLOWED = new Set([
  "status",
  "preference",
  "correction",
  "memory",
  "project",
  "search",
  "suggest",
]);

const HERE = dirname(fileURLToPath(import.meta.url));

function isForeignLiveRouter(path) {
  return String(path).includes("obsidian-knowledge-router");
}

export function resolveRouter(explicit) {
  const bundled = resolve(
    HERE,
    "../../../skill/krouter-obsidian/scripts/route_knowledge.sh",
  );
  const installed = join(
    homedir(),
    ".agents/skills/krouter-obsidian/scripts/route_knowledge.sh",
  );
  const candidates = [
    explicit,
    process.env.KROUTER_ROUTER,
    bundled,
    installed,
  ].filter(Boolean);
  for (const path of candidates) {
    if (isForeignLiveRouter(path)) continue;
    if (existsSync(path)) return path;
  }
  return null;
}

export function resolveVault(explicit) {
  return explicit || process.env.OBSIDIAN_VAULT || process.env.KROUTER_VAULT || "";
}

export function runRoute({ route, query = "", vault, router, timeoutMs = 20000 } = {}) {
  if (!ALLOWED.has(route)) {
    return {
      ok: false,
      code: 2,
      stdout: "",
      stderr: `refused route: ${route}. read-only: ${[...ALLOWED].join("|")}\n`,
    };
  }
  const vaultRoot = resolveVault(vault);
  if (!vaultRoot) {
    return { ok: false, code: 2, stdout: "", stderr: "set OBSIDIAN_VAULT or vaultPath\n" };
  }
  const script = resolveRouter(router);
  if (!script) {
    return {
      ok: false,
      code: 2,
      stdout: "",
      stderr: "route_knowledge.sh not found. run ./scripts/install.sh or set KROUTER_ROUTER\n",
    };
  }
  const args = [route];
  if (query) args.push(query);
  const result = spawnSync(script, args, {
    encoding: "utf8",
    timeout: timeoutMs,
    env: { ...process.env, OBSIDIAN_VAULT: vaultRoot },
  });
  return {
    ok: result.status === 0,
    code: result.status ?? 1,
    stdout: result.stdout || "",
    stderr: result.stderr || (result.error ? String(result.error) : ""),
  };
}

export function parseReceipt(text) {
  const fields = {};
  for (const line of text.split("\n")) {
    const idx = line.indexOf(":");
    if (idx < 1) continue;
    const key = line.slice(0, idx).trim();
    const value = line.slice(idx + 1).trim();
    if (key && !(key in fields)) fields[key] = value;
  }
  return fields;
}
