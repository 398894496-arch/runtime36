import { parseReceipt, runRoute } from "./route.js";

function textResult(run) {
  const body = [run.stdout, run.stderr].filter(Boolean).join("\n").trim();
  const fields = parseReceipt(run.stdout);
  return {
    ok: run.ok,
    code: run.code,
    canonical_match: fields.canonical_match || "false",
    canonical_id: fields.canonical_id || "",
    canonical_source: fields.canonical_source || "",
    text: body,
  };
}

const RESULT_SCHEMA = {
  type: "object",
  additionalProperties: false,
  properties: {
    ok: { type: "boolean", required: true },
    code: { type: "integer", required: true },
    canonical_match: { type: "string", required: true },
    canonical_id: { type: "string", required: true },
    canonical_source: { type: "string", required: true },
    text: { type: "string", required: true },
  },
};

function renderText(_args, value) {
  return [{ type: "text", text: value.text }];
}

const QUERY = {
  type: "string",
  required: true,
  description: "One contiguous short noun, not a full question.",
};

const TOOLS = [
  {
    name: "krouter_status",
    route: "status",
    needsQuery: false,
    description:
      "Agent second brain home / vault status. Includes lamp and self-evolution key. If host_action is present, tell the host. Read-only. Cite the receipt source.",
  },
  {
    name: "krouter_preference",
    route: "preference",
    needsQuery: true,
    description:
      "Memory system: host preferences and constraints. Short noun. If canonical_match is true, open canonical_source.",
  },
  {
    name: "krouter_correction",
    route: "correction",
    needsQuery: true,
    description:
      "Memory system: corrections and supersedes. Short noun. If canonical_match is true, open canonical_source.",
  },
  {
    name: "krouter_memory",
    route: "memory",
    needsQuery: true,
    description:
      "Memory system: high-trust memory index. Short noun. Not a vector search. If canonical_match is true, open canonical_source.",
  },
  {
    name: "krouter_project",
    route: "project",
    needsQuery: true,
    description:
      "Knowledge base: literal search under 01 项目. Short noun. If canonical_match is true, open canonical_source.",
  },
  {
    name: "krouter_search",
    route: "search",
    needsQuery: true,
    description:
      "Knowledge base search: alias table first, then literal rg. Not a vector search. If canonical_match is true, open canonical_source.",
  },
  {
    name: "krouter_suggest",
    route: "suggest",
    needsQuery: true,
    description:
      "Nearest alias hints on a miss. Hints are not hits. Retry one alias with krouter_search.",
  },
];

export const KROUTER_TOOL_NAMES = TOOLS.map((t) => t.name);

export function registerKrouterTools(ctx, config, defineTool) {
  const vault = config.vaultPath || "";
  const router = config.routerScript || "";

  for (const tool of TOOLS) {
    ctx.tools.register(
      defineTool({
        name: tool.name,
        description: tool.description,
        parameters: tool.needsQuery ? { query: QUERY } : {},
        output: { schema: RESULT_SCHEMA, render: renderText },
        execute: (args = {}) =>
          textResult(
            runRoute({
              route: tool.route,
              query: tool.needsQuery ? args.query : "",
              vault,
              router,
            }),
          ),
      }),
    );
  }
}
