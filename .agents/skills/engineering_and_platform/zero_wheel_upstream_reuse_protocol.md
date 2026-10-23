# Zero Wheel & Upstream Open Source Reuse Protocol (零造轮子与上游开源复用规约)

## 0. 核心定位与设计宗旨
本规约是 `developer/skills/` 体系下的铁律指南。
核心宗旨：**严禁任何形式的“重新发明轮子”！凡是公网/开源社区已存在成熟、经受过检验的脚本、库或组件，必须 1:1 直接套用复用；自定义功能必须采用“上游核心 1:1 原封不动 + 独立扩展桥接 (Decoupled Extension Bridge)”的正交解耦模式，实现上游全自动静默跟进更新，彻底免去二次维护成本**。

---

## 1. 四大落地铁律

### 1.1 社区/Pub.dev 现成方案优先原则 (Upstream Reuse Supremacy)
* 在动手编写任何功能（如 DOM 选择器、正则提取、网络协议、原生 Bridge）前，必须优先检索公网（GitHub / GreasyFork / Pub.dev）。
* 只要存在已验证的顶级开源项目或脚本，**绝对禁止自行重新撰写复杂逻辑**，直接 1:1 引用或集成。

### 1.2 上游核心零篡改原则 (Zero Upstream Modification)
* 上游开源脚本或核心模块（如 DOM 代点脚本 `upstream_tester_core.js`）必须保持 **1:1 原封不动**。
* 严禁直接改动上游代码的任何行，确保上游升级时可以一键静默覆盖替换，0 破坏性风险。

### 1.3 独立扩展桥接正交解耦 (Decoupled Extension Bridge)
* 项目专属的功能（如局域网 8964 端口推送、Choice UI 选项框）必须编写在独立的扩展文件（如 `devpocket_extension_bridge.js`）中。
* 扩展层与上游核心层通过顶层装配器（Adapter）正交挂载，互不侵入。

### 1.4 全自动静默跟进更新机制 (Automatic Upstream Update)
* 在 Userscript / 外部脚本中，强制利用油猴引擎原生的 `@require <upstream-url>` 与 `@updateURL` / `@downloadURL` 管道。
* 当上游社区更新 DOM 选择器或修复 Bug 时，客户端在后台**全自动检测并升级上游代码**，彻底消除人工维护成本。

---

## 2. 适用场景与触发条件
* 编写、重构或集成任何第三方 Web DOM 自动化脚本（Tampermonkey / Violentmonkey Userscript）；
* 选择与集成 Pub.dev 顶级开源依赖库（如 `receive_sharing_intent`, `flutter_custom_tabs`, `app_usage`, `device_apps`, `shelf`）；
* 设计跨平台数据抓取与 API 交互中枢时。
