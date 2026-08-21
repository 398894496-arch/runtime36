# KRouter Obsidian（中文）

GitHub 默认页是英文 [`README.md`](README.md)。本页是中文对照。

作者活库实测（2026-08-21）：检索盲测 **25/25**，权威路由 26/26 主题 · 156/156 别名，连续封账 **72** 天，**30** 条真实任务，执行门禁已通过，本机日更持续运行。

面向 Agent 的 Obsidian 知识路由。准备做事时命中会影响行为的那一页，并留下 SHA 回执。纠错写入权威页后，下次同类任务自动找回。库越用越准，Agent 越用越稳。不引入向量库。

本仓库是可安装协议。详情页：[`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)。不变量：[`PROTOCOL.md`](PROTOCOL.md)。许可 MIT。

GitHub 仓名 `runtime36`。产品名 **KRouter Obsidian**。五区目录名保持中文（`01 项目` 等），那是库内路径，不是 GitHub 文档语言。

## 四层

写入走成熟度，读取必须走检索。空间五区是存放位置，不替代这四层。

| Layer | Rule |
|---|---|
| L1 Full logs | `05` one note per day. Episodic, not a result |
| L2 Distillation | Daily evolution and reviews. Summaries never replace originals |
| L3 Promotion | Five gates into provisional; ask + accepted task → `active` |
| L4 Retrieval | One short noun, SHA-256 receipt. No vector index |

完整梯子见 [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)。
