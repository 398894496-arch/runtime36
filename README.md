# KRouter Obsidian

作者活库实测（2026-08-21）：检索盲测 **25/25**，权威路由 26/26 主题 · 156/156 别名，连续封账 **72** 天，**30** 条真实任务，执行门禁已通过，本机日更持续运行。

面向 Agent 的 Obsidian 知识路由。准备做事时命中会影响行为的那一页，并留下 SHA 回执。纠错写入权威页后，下次同类任务自动找回。库越用越准，Agent 越用越稳。不引入向量库。

本仓库是可安装协议。详情页：[`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)。不变量：[`PROTOCOL.md`](PROTOCOL.md)。许可 MIT。

GitHub 仓名 `runtime36`。产品名 **KRouter Obsidian**。

## 四层

写入走成熟度，读取必须走检索。空间五区（项目 / 方法 / 证据 / 复盘 / 日志）是存放位置，不替代这四层。

```mermaid
flowchart LR
  L1[L1 全量日志] --> L2[L2 日志总结] --> L3[L3 经验晋升] --> L4[L4 检索]
```




| 层       | 规定                          |
| ------- | --------------------------- |
| L1 全量日志 | `05` 一天一篇。事件记忆，不自动等于结果      |
| L2 日志总结 | 日更蒸馏与复盘。原文不可被总结替代           |
| L3 经验晋升 | 五条进准经验；下次问采纳且任务验收才 `active` |
| L4 检索   | 短名词命中唯一页，回执含 SHA-256。无向量库   |


完整梯子、可信度、回执与写回边界见详情页。作者活库实测见详情页「协议已经跑过」。

## 不变量

- `OBSIDIAN_VAULT` 由宿主设置。仓库不写死任何人家目录。
- 查询必须是连续短名词，禁止把整句问题当作 AND 检索。
- 回执含 `canonical_match: true` 时，Agent **必须**引用 `canonical_source`，不得改引近邻笔记。
- Clippings 原件只复制，不移动、不修改、不删除。
- `status` 读取首页 `Agent第二大脑.md`。
- 日更与执行钩子在 `extras/`，默认关闭。

别名匹配顺序：完全相等 > 别名是查询的子串 > 查询是别名的子串（长度 ≥ 2）。同分且指向同一文件时取最小 id；否则视为未命中。

## 安装

依赖：`python3`、`rg`。

```bash
git clone https://github.com/398894496-arch/runtime36.git
cd runtime36
chmod +x scripts/*.sh skill/krouter-obsidian/scripts/*.sh
./scripts/first_run.sh
```

`first_run.sh` 只验收仓库内 `template/`，不读取宿主已有的 `OBSIDIAN_VAULT`。对准其他库时设置 `KROUTER_FIRST_RUN_VAULT`。

通过标准：`search 入口` 回执为 `canonical_id: Q01`，`source` 为 `template/Agent第二大脑.md`，并含 `source_sha256` 与 `canonical_map_sha256`。

```bash
cp -R template /path/to/YourVault
export OBSIDIAN_VAULT=/path/to/YourVault
./scripts/install.sh
```

安装位置：


| 目标        | 路径                                     |
| --------- | -------------------------------------- |
| Skill     | `~/.agents/skills/krouter-obsidian`    |
| Cursor 规则 | `~/.cursor/rules/krouter-obsidian.mdc` |
| Codex 片段  | `extras/codex/AGENTS.snippet.md`       |


已存在同名 skill 时须 `--force`。本 skill 目录与 `obsidian-knowledge-router` 分离，互不覆盖。随后改 `canonical_sources.psv` 为宿主自己的主题与短名词，再搜一次确认回执。

## 布局


| 路径                             | 规定                                             |
| ------------------------------ | ---------------------------------------------- |
| `docs/ARCHITECTURE.md`         | 四层架构与晋升机制详情                                    |
| `template/`                    | 空五区；首页 `Agent第二大脑.md`；准经验入口                    |
| `skill/krouter-obsidian/`      | `route_knowledge.sh`、`canonical_lookup.py`、别名表 |
| `scripts/install.sh`           | 装入 Agent 运行时                                   |
| `scripts/first_run.sh`         | 机械验收                                           |
| `scripts/validate_vault.py`    | YAML、Clippings 账、日志连续日                         |
| `extras/cursor/`               | Cursor Always 规则                               |
| `extras/codex/`                | Codex 手册片段                                     |
| `extras/hooks/`                | 可选：拦截剪藏原件与重启 Obsidian                          |
| `extras/host-daily-evolution/` | 可选宿主日更                                         |




## 协议已经跑过

作者活库（2026-08-21）：检索盲测 25/25；权威路由 26/26 主题、156/156 别名；连续封账 72 天；30 条真实任务；执行门禁已通过；本机日更持续运行。

检索以 SHA 回执命中权威页。纠错写入后，下次同类任务自动找回。

English: [`README.en.md`](README.en.md)。