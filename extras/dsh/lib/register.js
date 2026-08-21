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

export function registerKrouterTools(ctx, config, defineTool) {
  const vault = config.vaultPath || "";
  const router = config.routerScript || "";

  ctx.tools.register(
    defineTool({
      name: "krouter_status",
      description:
        "KRouter status for the shared Obsidian vault. Read-only. Cite the receipt source.",
      parameters: {},
      output: { schema: RESULT_SCHEMA, render: renderText },
      execute: () => textResult(runRoute({ route: "status", vault, router })),
    }),
  );

  ctx.tools.register(
    defineTool({
      name: "krouter_search",
      description:
        "KRouter search: one short noun. Alias table first, then literal rg. Not a vector search. If canonical_match is true, open canonical_source.",
      parameters: {
        query: {
          type: "string",
          required: true,
          description: "One contiguous short noun, not a full question.",
        },
      },
      output: { schema: RESULT_SCHEMA, render: renderText },
      execute: (args) =>
        textResult(runRoute({ route: "search", query: args.query, vault, router })),
    }),
  );

  ctx.tools.register(
    defineTool({
      name: "krouter_suggest",
      description:
        "Nearest alias hints on a miss. Hints are not hits. Retry one alias with krouter_search.",
      parameters: {
        query: {
          type: "string",
          required: true,
          description: "The noun that missed.",
        },
      },
      output: { schema: RESULT_SCHEMA, render: renderText },
      execute: (args) =>
        textResult(runRoute({ route: "suggest", query: args.query, vault, router })),
    }),
  );
}
