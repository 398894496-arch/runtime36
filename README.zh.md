# KRouter Obsidian（中文）

英文主页：[`README.md`](README.md)。

给已经在用 Obsidian 的 AI Agent 做确定性知识路由。不是笔记应用，不是通用记忆 SDK，不是向量 MCP。一个短名词打到会影响这次行动的那一页，并留下 SHA-256 回执。

**十五分钟**可在仓库自带 `template/` 上跑通。不需要 GPU、Docker、嵌入进程。作者活库跑在 **8GB M2** 上，运行时就是 `python3` + `rg`。

```bash
git clone https://github.com/398894496-arch/runtime36.git
cd runtime36
python3 -m pip install -r requirements.txt
./scripts/first_run.sh
```

通过标准：`search home` 得到 `canonical_id: Q01`、首页路径、双 SHA。CI 每次 push 都会跑 `pytest` 和 `first_run.sh`。未命中时 `suggest homz` 只给别名提示，不是命中，也没有向量回退。

维护成本低，是因为没有向量库要重建索引。你要维护的是 Markdown 和一张别名表，不是记忆服务器。不是零成本：别名和晋升还是要写，那就是这套协议本身。

作者活库（2026-08-21）有盲测 25/25、26/26 主题、156/156 别名、72 天封账、30 条真实任务。那是作者库的成绩。clone 空模板请先跑 `first_run.sh`。

详情：[`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)。
