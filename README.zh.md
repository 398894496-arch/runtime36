# DSH-KRouter

英文主页：[`README.md`](README.md)。

**自进化。经验晋升。纠错优先。**  
一座 [Obsidian](https://obsidian.md) 库，给 Cursor、Codex、Claude Code、DeepSeek Harness 共用。

Agent 干几个月，该把**方法和纠错留在库里**，不是留在聊天里。昨天封账并蒸馏。可复用做法先是 `provisional`；下次同类任务先问要不要用；你点头且该次验收，才升 `active`。纠错页压过旧笔记。检索只是锁：一个短名词、SHA-256 回执、不许引用隔壁、没有向量库。**打不中那一页，进化就没发生。**

不是笔记应用，不是 Mem0，不是「把会话压缩了下次自动灌回去」。

```mermaid
flowchart LR
  L1[L1 封当天] --> L2[L2 蒸馏]
  L2 --> L3[L3 gated 晋升]
  L3 --> L4[L4 打到那一页]
```

| 层 | 做什么 | 不许做什么 |
|---|---|---|
| L1 日志 | `05` 一天一篇 | 把流水账当成可复用方法 |
| L2 蒸馏 | 自进化：封账 + 蒸馏。摘要不能代替原文 | 自动写成 `active` |
| L3 晋升 | 五道门进 `provisional`。下次同类先问。采纳且该次验收 → `active` | 静默晋升 |
| L4 锁 | 短名词 → 那一页 + 双 SHA。8GB M2 上几十毫秒（`python3` + `rg`） | 向量回退、引用隔壁 |

完整规则：[`PROTOCOL.md`](PROTOCOL.md)。架构：[`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)。

## clone 能证明什么，你自己打开什么

| | 本仓库（CI / `first_run.sh`） | 你的库 |
|---|---|---|
| 锁 | `search home` → `canonical_id: Q01` + 双 SHA | 同一套合同，换**你的**名词 |
| extra 在不在 | `check.sh` 能过，灯可以是 `unused` | 你钉死写入器 + 系统定时器，再把灯改成 `running` |
| 每日封账 / 蒸馏 | 不会自动开。装插件不挂 cron | 宿主 extra：[`extras/host-daily-evolution/`](extras/host-daily-evolution/) |
| 晋升 / 纠错 | 协议 + 模板页 | 你写。下次路由必须打开那一页 |

clone 是空库加协议。覆盖率是你维护的别名表，不是模型。

## 十五分钟 — 先验证锁

不需要 GPU、Docker、嵌入进程。

```bash
git clone https://github.com/398894496-arch/runtime36.git
cd runtime36
python3 -m pip install -r requirements.txt
./scripts/first_run.sh
```

通过：`search home` 得到 `Q01`、`template/Agent第二大脑.md`、双 SHA。CI 每次 push 跑 pytest、这支脚本、DSH 桥。未命中时 `suggest homz` 只给**提示**，不是命中，也没有向量回退。

## 自进化 — 写入器

这是产品主循环。文件在仓库里，**定时器不在。** 钉死本地 Agent CLI（绝对路径，不要用 PATH 上的 `agent`），用 launchd / cron 挂上。示例：[`extras/host-daily-evolution/`](extras/host-daily-evolution/)。

- 当天可复用做法只能是 `provisional`
- 失败就留待总结，不许空过一天
- **`dsh plugin add` 不会挂这个任务。** 卸挂载也不会停；你自己停系统定时器，再把灯改成 `unused`

## 四个挂载，一座库

共享的是库和 `canonical_sources.psv`，不是第二套协议。

```bash
export OBSIDIAN_VAULT=/path/to/YourVault
./scripts/install.sh
```

装到 `~/.agents/skills/krouter-obsidian` 和 `~/.cursor/rules/krouter-obsidian.mdc`。`--force` 才覆盖。不会覆盖正在用的 `obsidian-knowledge-router`。先拷 `template/`，用**你的**名词重写别名表（模板只有八个样例）。

| 挂载 | 仓库里有什么 |
|---|---|
| Cursor | `install.sh` → `extras/cursor/krouter-obsidian.mdc` |
| Codex | `extras/codex/AGENTS.snippet.md` |
| Claude Code | `extras/claude-code/CLAUDE.snippet.md` |
| DeepSeek Harness | `dsh plugin add github:398894496-arch/runtime36` — 只读工具，含 **correction**。卸插件不删库 |

```bash
node extras/dsh/test-bridge.mjs
dsh plugin add github:398894496-arch/runtime36
```

需要 `python3`、`rg`、PyYAML。测试：`python3 -m pip install -r requirements-dev.txt && python3 -m pytest -q`。

## 过完一天，过完一次纠错

| | 这套协议 | 常见 Agent 记忆 |
|---|---|---|
| 过完好的一天 | 蒸馏 → `provisional` → 下次先问 → 可能 `active` | 摘要自动灌进下一轮提示词 |
| 过完一次纠错 | 改权威页。下次必须打开它 | 重新嵌入，盼着旧块自己烂掉 |
| 常驻进程 | 无 | 向量库、嵌入器、常常还有 API |
| 你要维护的 | Markdown + 一张别名表 + 晋升 | 索引、同步、注入、过期 |

维护本身就是产品：别名和门。没有索引要重建。

## 谁该 clone

你已经在用 Obsidian 和本地 Agent，想要**跨会话、跨壳少踩同一口坑**。

想要自动灌记忆、云记忆 API、或 clone 完就是装满的知识库，跳过。

## 作者活库（不是 clone 分数）

2026-08-21 作者活库：连续封账 72 天（2026-06-10 → 2026-08-20）；宿主日更在跑；30 条真实任务；检索盲测 25/25；26/26 主题、156/156 别名。

那些数字是别名和晋升已经存在之后的成绩。你这台机器上本仓库能证明的，是 `./scripts/first_run.sh`。

MIT。Changelog：[`CHANGELOG.md`](CHANGELOG.md)。
