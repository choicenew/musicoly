# Hetu Sandbox Isolation & Hydration (河图沙盒并发隔离、故障抛弃与动态水合规范)

## 0. 核心定位
规范主 App 在并发分发多插件请求、数据持久化存储与沙盒错误捕获时的容灾与隔离机制。

---

## 1. 源码水合与存真铁律 (Source Code Hydration)
* **数据库 100% 存储源码字符串**：
  - 存入 Isar / SQLite 数据库的 `PluginEntity.rawDefinition` **必须是完整的 `.ht` 源码代码文本**，绝对禁止仅存储本地物理磁盘的绝对/相对路径字符串。
* **彻底根除路径断层**：
  - 在移动端真机或沙盒隔离环境下运行时，虚拟机直接从内存中读取源码，无需做 `File(path).exists()`，100% 避免 `FileSystemException` 文件路径不存在崩溃。

---

## 2. 单插件彻底并发隔离与故障局部抛弃机制 (Failure Drop Protocol)
* **完全异步隔离**：
  - 主 App 在 Feed UI / Explorer 流式并发分发请求时，每一个插件必须在独立的 `Future` 闭包中执行（如 `Future.wait(tasks)`），互不阻塞。
* **故障局部抛弃**：
  - 如果某个插件遭遇 Cloudflare 403 阻断、网络 Timeout 或 JSON 解析报错，主 App **仅抛弃这一个有问题的插件/错误 Item**，**绝对不允许一个插件的报错阻断其他正常插件的数据拉取与流式追加上屏**！

---

## 3. 插件独立沙盒诊断终端规范 (Sandbox Diagnostics Terminal)
* 插件管理页必须对每一个插件提供**独立的沙盒单测诊断终端**；
* 必须实时透明地打印出：源码加载状态、请求 URL、耗时 (ms)、HTTP 状态码以及返回的样本 JSON 数据预览。
