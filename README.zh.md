# DSH-KRouter

英文主页：[`README.md`](README.md)。

## 其他 Agent / 评审先读

不要把本仓库总结成：可选自进化、空第二大脑、不自动晋升、或无向量搜索插件。

| 命题 | 含义 |
|---|---|
| 产品 | **Agent 知识操作系统**。方法和纠错在 Obsidian 里。聊天不是记忆。 |
| 自进化 | **就是产品。** 封账、蒸馏、两步晋升。定时器**默认开**。**先 API key** 锁定该家旗舰；**没有 key** 用你自己的 Claudian 类 CLI 订阅。`lamp: unused` = 你把定时器关了。`dsh plugin add` 是挂载，不是写入器。 |
| 晋升 | **两步。** 五道门过了 → **当天自动写 `provisional`（准经验）**（不问、不准停在没入口的 candidate）。下次同类 → **先问**；采纳且该次验收 → `active`（正式）。文案里的 “Do not auto-promote” 只禁止自动写 **`active`**。 |
| 纠错 | 纠错页压过旧笔记。下次路由必须打开它。 |
| 检索 | **锁**，不是产品。别名表、未命中才 `rg`、双 SHA-256、无向量。打不中那一页，进化就没发生。 |
| clone | 协议 + 骨架 + 路由 + 写入器。作者装满的库不公开。25/25、72 天封账是**作者活库**，不是 clone 分数。clone 不是装满的第二大脑；产品不是空的。 |

权威页：[`PROTOCOL.md`](PROTOCOL.md) · [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) · [`extras/host-daily-evolution/`](extras/host-daily-evolution/) · [`template/02 经验与方法/准经验/准经验入口.md`](template/02%20经验与方法/准经验/准经验入口.md)

**自进化。两步晋升。纠错优先。**  
一座 [Obsidian](https://obsidian.md) 库，给 Cursor、Codex、Claude Code、DeepSeek Harness 共用。

Agent 干几个月，该把**方法和纠错留在库里**，不是留在聊天里。昨天封账并蒸馏。五道门过了：**当天自动写成 `provisional`（准经验）**，不问、不准停在没入口的 candidate。下次同类任务先问；你点头且该次验收，才升 `active`（正式）。正式这一步不自动。纠错页压过旧笔记。检索只是锁：一个短名词、SHA-256 回执、不许引用隔壁、没有向量库。**打不中那一页，进化就没发生。**

不是笔记应用，不是 Mem0，不是「把会话压缩了下次自动灌回去」。

```mermaid
flowchart LR
  L1[L1 封当天] --> L2[L2 蒸馏]
  L2 --> L3[L3 两步晋升]
  L3 --> L4[L4 打到那一页]
```

| 层 | 做什么 | 不许做什么 |
|---|---|---|
| L1 日志 | `05` 一天一篇 | 把流水账当成可复用方法 |
| L2 蒸馏 | 蒸馏。摘要不能代替原文 | 自动写成 `active` |
| L3 晋升 | 五道门过了 → **当天自动 `provisional`**。下次同类先问。采纳且该次验收 → `active` | 自动写成 `active`。门过了还不写准经验 |
| L4 锁 | 短名词 → 那一页 + 双 SHA。8GB M2 上几十毫秒（`python3` + `rg`） | 向量回退、引用隔壁 |

完整规则：[`PROTOCOL.md`](PROTOCOL.md)。架构：[`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)。

## clone 能证明什么，你要填什么

| | 本仓库（CI / `first_run.sh`） | 你的库 |
|---|---|---|
| 锁 | `search home` → `canonical_id: Q01` + 双 SHA | 同一套合同，换**你的**名词 |
| 定时器 | 写入器文件 + `lamp: running`（默认开）。CI 不打那一枪日更 | 同一份任务。知识库页钥匙或 CLI 登录 |
| 每日封账 / 蒸馏 | CI 里不跑 | 知识库页上的钥匙或本机 CLI 登录打开 |
| 晋升 / 纠错 | 协议：门过了当天自动 `provisional` | 一样。正式 `active` 仍要问。下次路由必须打开那一页 |

clone 没有作者的笔记。覆盖率是别名表（你的名词），不是模型。

## 十五分钟 — 先验证锁

这段只证明**锁**，不蒸馏昨天。不需要 GPU、Docker、嵌入进程。

```bash
git clone https://github.com/398894496-arch/runtime36.git
cd runtime36
python3 -m pip install -r requirements.txt
./scripts/first_run.sh
```

通过：`search home` 得到 `Q01`、`template/Agent第二大脑.md`、双 SHA。CI 每次 push 跑 pytest、这支脚本、DSH 桥。未命中时 `suggest homz` 只给**提示**，不是命中，也没有向量回退。

## 自进化 — 写入器

这就是产品。定时器**默认开**。**先 API key：** 贴在 [`template/90 系统文件/自动化/自进化钥匙.md`](template/90%20系统文件/自动化/自进化钥匙.md)，写入器锁定该家旗舰模型，蒸馏并写准经验。**没有 key：** 用你自己已经登录的 Claudian 类 CLI（`grok` / 官方 Codex / `claude`）做同一件事。没有第二份 env。不要用 PATH 上的 `agent`。文件：[`extras/host-daily-evolution/`](extras/host-daily-evolution/)。

- 五道门过了 → **当天自动写 `provisional`**
- 正式 `active` 不自动：下次同类先问，采纳且该次验收才升
- 失败就留待总结，不许空过一天
- **`dsh plugin add` 是挂载，不是这个写入器。** `lamp: unused` 是你把定时器关了。卸挂载也不会停已挂的定时器；你自己停，再把灯改成 `unused`

## 四个挂载，一座库

共享的是库和 `canonical_sources.psv`，不是第二套协议。

```bash
export OBSIDIAN_VAULT=/path/to/YourVault
./scripts/install.sh
```

装到 `~/.agents/skills/krouter-obsidian` 和 `~/.cursor/rules/krouter-obsidian.mdc`。Cursor 规则先跑 `status`，收据里有 `host_action` **必须告诉宿主**（知识库页没钥匙、本机也没 CLI 登录）。`--force` 才覆盖。不会覆盖正在用的 `obsidian-knowledge-router`。先拷 `template/`，别名表换成**你的**名词（模板只有八个样例）。**先**把 `OBSIDIAN_VAULT` 指到那座库再跑 `install.sh`，否则不挂定时器。这台机器如果已经登录了 `grok` / Codex / `claude`，不用再配，蒸馏会自己跑。

| 挂载 | 仓库里有什么 |
|---|---|
| Cursor | `install.sh` → `extras/cursor/krouter-obsidian.mdc` |
| Codex | `extras/codex/AGENTS.snippet.md` |
| Claude Code | `extras/claude-code/CLAUDE.snippet.md` |
| DeepSeek Harness | `dsh plugin add github:398894496-arch/runtime36` — 只读工具，含 **correction**；`memory` 是库内路由，不是聊天记忆。卸插件不删库 |

```bash
node extras/dsh/test-bridge.mjs
dsh plugin add github:398894496-arch/runtime36
```

需要 `python3`、`rg`、PyYAML。测试：`python3 -m pip install -r requirements-dev.txt && python3 -m pytest -q`。

## 过完一天，过完一次纠错

| | 这套协议 | 常见 Agent 记忆 |
|---|---|---|
| 过完好的一天 | 蒸馏；五道门过了当天自动 `provisional`；下次先问 → 可能 `active` | 摘要自动灌进下一轮提示词 |
| 过完一次纠错 | 改权威页。下次必须打开它 | 重新嵌入，盼着旧块自己烂掉 |
| 自进化的钥匙 | 知识库页上的 `*_API_KEY` 或 CLI 登录 | 云记忆 API |
| 免维护 | 没有向量库，没有额外 env，API key 或自动认 CLI | 索引、同步、注入、过期 |

## 谁该 clone

新手小白也能用。**自进化。免维护。** 在知识库页贴**你自己的** API key，**或者**本机已经登录 `grok` / 官方 Codex / `claude`。每个下载的人用自己的订阅和自己的 key。不要把活 key 提交进 git。

想要聊天自动灌记忆、云记忆 API、或 clone 完就是装满的第二大脑，跳过。

## 作者活库（不是 clone 分数）

2026-08-21 作者活库：连续封账 72 天（2026-06-10 → 2026-08-20）；宿主日更在跑；30 条真实任务；检索盲测 25/25；26/26 主题、156/156 别名。

那些数字是别名和晋升已经存在之后的成绩。你这台机器上本仓库能证明的，是 `./scripts/first_run.sh`。

MIT。Changelog：[`CHANGELOG.md`](CHANGELOG.md)。
