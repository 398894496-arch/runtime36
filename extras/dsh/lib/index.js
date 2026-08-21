import { defineTool } from "@deepseek-ai/dsh-tools";
import z from "@deepseek-ai/schemastery";
import { registerKrouterTools } from "./register.js";

export const name = "dsh-krouter";
export const inject = ["tools"];

export const Config = z.object({
  vaultPath: z
    .string()
    .default("")
    .description("Absolute Obsidian vault path. Empty uses OBSIDIAN_VAULT."),
  routerScript: z
    .string()
    .default("")
    .description(
      "Absolute path to route_knowledge.sh. Empty uses KROUTER_ROUTER, then ~/.agents/skills/krouter-obsidian.",
    ),
});

export function apply(ctx, config = {}) {
  registerKrouterTools(ctx, config, defineTool);
}
