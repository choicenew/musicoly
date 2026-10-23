# Feature Modular Architecture (Feature 业务模块化架构)

## 0. 适用场景
当项目为**多团队协作开发、各业务模块（如用户中心、支付结算、社交动态、壁纸广场、数据同步）相对独立且需要并行高速迭代**时选用的主 App 架构。

---

## 1. 结构与目录规范
各个 Feature 模块存放在 `features/<feature_name>/` 或独立的 Feature Package 中：

```text
features/<feature_name>/
├── domain/                         # 纯业务逻辑与实体
│   ├── entities/                   # 业务实体 (强类型)
│   └── repositories/               # 抽象契约接口 (Abstract Repository / Provider)
├── data/                           # 数据持久化与网络交互
│   ├── datasources/                # 独立数据源驱动 (如 WebDAV 客户端、本地数据库)
│   └── repositories/               # 仓储具体实现
└── presentation/                   # 视图与状态
    ├── controllers/                # 自动生成的状态中枢
    ├── views/                      # 页面脚手架 (行数 < 250 行)
    └── widgets/                    # 细粒度拆分的子组件与配置弹窗
```

---

## 2. 核心隔离红线与解耦铁律

### 2.1 禁止横向循环与私有实现依赖
1. **禁止横向私有依赖**：Feature A 绝对不允许直接导入或调用 Feature B 的内部私有实现（如直接调用私有 Client 或底层 Schema）。
2. **跨模块通信途径**：
   - 通过公共抽象接口（Domain 抽象契约）解耦；
   - 通过主 App 的顶层全局强类型路由（`RouteTokens`）进行页面跳转与中转；
   - 通过全局状态总线监听状态。

### 2.2 可插拔技术驱动型 Feature 独立隔离铁律 (Pluggable Capability as Independent Feature)
* **绝对禁止大锅饭混淆**：任何具备**独立技术选型生命周期**、未来可能被替换或拓展的技术能力（如数据同步 `sync_engine`、对象存储 `storage_engine`、分析上报 `analytics`），**100% 必须独立成独立的顶级 Feature**，绝对严禁被宿主页面或通用设置页（`settings`）寄生吞并！
* **面向抽象接口设计**：该技术 Feature 必须在 `domain/repositories/` 中向全工程暴露抽象契约接口（如 `abstract class SyncRepository`）。具体的技术协议（如 WebDAV、Cloudflare R2、Google Drive）仅作为其内部的驱动实现。
* **设置页仅作为调用方**：`settings` 等外围模块仅允许通过该 Feature 暴露的标准 Controller/Widget 弹窗进行调度交互，随时可拔插替换底层技术驱动而不影响主工程任何业务。

### 2.3 未穷举场景默认彻底解耦推导法则 (Default High-Decoupling Deduction Rule)
* **禁止等待用户穷举**：凡是用户未逐一明确指出、但在系统演化中涉及的任何功能，**必须主动推导应用彻底解耦原则**。
* **强制自立门户的四大推导判定条件**（命中任意一项即必须作为独立 Feature 建制，严禁偷懒就近并入既有模块）：
  1. **独立外部协议或网络通道**：涉及第三方协议通信（如 WebDAV、FTP、S3、OAuth 登录流、LAN 微服务、WebSocket 推送等）；
  2. **独立持久化设施与生命周期**：具备自己独立的数据表 Schema、缓存策略或生命周期的能力；
  3. **独立可插拔性/可替代性**：该能力未来可能切换为另一套技术栈（如 WebDAV 切坚果云或私有云、Shelf 切 Ktor、Firebase 切自建认证）；
  4. **独立业务闭环**：该能力具备自身的输入、输出、状态机流转与完整交互（如战报凭证生成与交付、发布者应用大盘、悬赏订单等）。
* **组合容器原则 (Composition Root)**：宿主模块（如 `settings`、`dashboard`）仅可充当容器装配者，通过 State Provider 观察接口状态，或挂载子 Feature 暴露的自闭环 Widget。严禁在宿主内部直接编写子能力的业务逻辑与底层实现。
