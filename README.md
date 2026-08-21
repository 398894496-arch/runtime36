# Runtime36 Agent Knowledge OS

Markdown 知识库治理模板：五区目录、可信度字段、确定性路由（无向量）、可选本机日更。

这不是自主进化 AGI，也不是把别人的第二大脑原文公开。作者自己的活库不在这个仓库里。

## 能声称什么

- 协议用过约两个月：frontmatter `status` / `confidence` / `supersedes`，确定性路由带 SHA 回执。
- 作者活库在 2026-08-21 的机械门禁：YAML 解析错 0、日更连续 72 天、映射文件 26/26 存在。那是作者的库，不是你 clone 之后的成绩。
- 执行门禁（动作前强制触发、违规硬阻断）是 `not-proven`。不要写进功能列表。

## 不能声称什么

- 通用检索准确率、语义 25/25、18/25 或 26/26 是你的成绩。
- 无人值守日更已经长期稳定。
- Claudian / 任何云端 Agent 会替你写库。

## 安装

```bash
export OBSIDIAN_VAULT="$PWD/template"
./skill/obsidian-knowledge-router/scripts/route_knowledge.sh status
./scripts/validate_vault.py --from-date 2026-01-01 --through-date 2026-01-01
```

把 `template/` 复制成你的 Obsidian vault。把 `canonical_sources.psv` 改成你自己的主题和别名，不要用作者的短视频题。

日更脚本在 `extras/host-daily-evolution/`，要本机 CLI 和定时任务，标成 extra。

## 许可

MIT。
