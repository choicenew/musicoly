# 07. 技能路由与精准分发总则 (Skill Routing & Dispatch Rule)

## 0. 核心宗旨
本文件为 AI 在 `developer/` 体系下的技能调度与分发规约。
**严禁将特定场景的 Skill（如空架子架构、风控算法、Legado阅读引擎）盲目强加给所有项目**！AI 必须严格根据《产品开发手册》在分析项目需求后所选定的架构与业务场景，**精准匹配并动态加载**对应的 Specialized Skills。

---

## 1. 技能分发矩阵与触发场景 (Skill Dispatching Matrix)

### 一、 跨语言通用自驱动与排障中枢 (`skills/1_universal_engine/`)

| 业务/工程领域 | 对应的 Specialized Skill 路径 | 核心职责 | 何时加载与触发场景 (Trigger Scenarios) |
| :--- | :--- | :--- | :--- |
| **自主目标推进引擎** | `skills/1_universal_engine/autonomous_goal_driven_orchestrator.md` | 对标 SWE-agent/Roo Code 的 DAG 任务分解、阶段状态机、自推演三问循环 | **大任务排期、功能组推进与多阶段自闭环落地时通用加载**。 |
| **故障分诊与根因定位** | `skills/1_universal_engine/incident_triage_and_root_cause_analysis.md` | 堆栈第一案发现场锁定、案发现场前后30行审讯、严禁无头苍蝇翻Git | **接收任何报错日志、崩溃堆栈、异常截图与缺陷反馈时第一优先加载**。 |
| **经验沉淀与固化协议** | `skills/1_universal_engine/continuous_learning_and_distillation.md` | 用户反馈模式识别、反面模式与正面法则萃取、固化为永久Skill | **用户进行多次批评、引导与方案纠偏时自动在后台激活沉淀**。 |
| **泛化自主工程与自审** | `skills/1_universal_engine/self_critique_and_strict_execution.md` | 自驱动推演、全管线审计、领域概念隔离、全语言包覆盖、测试门禁 | **接收任何复杂功能需求与自驱动推演时通用加载**。 |
| **字符串重构与上下文审计** | `skills/1_universal_engine/strict_string_context_verification.md` | 上下游双向管道必查、禁止打包伪常量、五大存储网络边界红线 | **进行任何字符串重构、常量提取与数据清洗时加载**。 |
| **严格指令服从与自驱动** | `skills/1_universal_engine/strict_user_instructions_compliance.md` | 动手前想透6维管线、保护核心工具类、回答优先、实测全绿 | **任何核心代码修改、架构重构与面对质问时通用加载**。 |

---

### 二、 跨语言通用架构范式 (`skills/2_universal_architecture/`)

| 架构形态 | 对应的 Specialized Skill 路径 | 核心职责 | 何时加载与触发场景 (Trigger Scenarios) |
| :--- | :--- | :--- | :--- |
| **纯空架子宿主+胶水层** | `skills/2_universal_architecture/decoupled_host_and_glue_layer.md` | 宿主零业务、内部门面胶水层装配中台、零手写Map、全流程MediaEntity强类型 | 当规划为**重插件化/多数据源聚合/微包集群装配/异构媒体流**系统时加载。 |
| **标准单体清洁架构** | `skills/2_universal_architecture/standard_clean_architecture.md` | Presentation ➔ Domain ➔ Data 三层单向解耦 | 当规划为**中大型独立单体/高稳定性业务 App** 时加载。 |
| **Feature 模块化架构** | `skills/2_universal_architecture/feature_modular_architecture.md` | 业务 Feature 物理隔离、四大解耦推导法则、无损平移 | 当规划为**多团队协作/业务模块正交隔离**系统时加载。 |
| **微包群生态规约** | `skills/2_universal_architecture/micro_package_cluster_protocol.md` | 微包之间终生不往来、横向零依赖、插拔式设计、纯DTO交互 | 当系统涉及**微包集群（如渲染微包群、驱动微包群、算法微包群）**时加载。 |
| **纯工具与纯 UI 包** | `skills/2_universal_architecture/pure_utility_and_ui_package.md` | 零 Hub/零 Protocol 极简规范、纯函数/Design Tokens | 当开发**轻量工具库或纯视觉 UI 组件库**时加载。 |

---

### 三、 跨语言通用工程与代码规范 (`skills/3_engineering_standards/`)

| 规约领域 | 对应的 Specialized Skill 路径 | 核心职责 | 何时加载与触发场景 (Trigger Scenarios) |
| :--- | :--- | :--- | :--- |
| **工程命名禁忌规范** | `skills/3_engineering_standards/naming_convention_protocol.md` | 绝对禁止 my_ 与 app_ 前缀、具象业务角色语义命名 | **创建目录、文件、类、常量与路由标识时通用加载**。 |
| **强类型与零魔数** | `skills/3_engineering_standards/prohibit_string_literals_protocol.md` | 0魔数/0字符串Map Key/Type Token自我注册/路由Token/渠道Token化 | **编写模型、算法调度、排版与广告驱动时通用加载**。 |
| **零造轮子与开源复用** | `skills/3_engineering_standards/zero_wheel_upstream_reuse_protocol.md` | 上游 1:1 原封不动套用、全自动跟进更新、扩展桥接解耦 | **集成外部脚本、第三方库与自动化工具时通用加载**。 |
| **静默 Git 提交** | `skills/3_engineering_standards/silent_git_commit_pipeline.md` | PTY 连贯管道、零弹窗打扰 | 任何代码提交与 Git 操作时通用加载。 |

---

### 四、 专业技术栈生态库 (`skills/4_tech_stacks/`)

#### 1. Flutter & Dart (`skills/4_tech_stacks/flutter_and_dart/`)
| 技能名称 | 路径 | 触发场景 |
| :--- | :--- | :--- |
| **Riverpod 3.0 规范** | `riverpod_3_full_convention.md` | **使用 Riverpod 3.0 状态管理时通用加载**。 |
| **120FPS 性能加固** | `app_performance_audit_and_guard.md` | 处理手势滑动、高密计算、长列表优化时通用加载。 |
| **2 阶秒开加载协议** | `two_stage_snappy_loading_protocol.md` | 内容 Feed 流、数据看板、壁纸瀑布流加载时使用。 |
| **缩略图缓存策略** | `thumbnail_and_cache_strategy.md` | 图片卡片、壁纸列表、多媒体网格加载时使用。 |
| **副线程 Isolate 并发** | `isolate_concurrency_and_offloading.md` | 密集计算下沉、大体积 JSON 反序列化时使用。 |
| **Page/Widget 解耦** | `page_and_widget_decoupling.md` | **所有 Flutter UI 表现层开发时通用加载**。 |
| **国际化命名规范** | `l10n_naming_convention_protocol.md` | 处理多语言 ARB 词条时通用加载。 |
| **系统主题优先规范** | `system_theme_first_protocol.md` | 编写 UI 样式与主题配色时通用加载。 |
| **Glance 桌面小组件** | `android_glance_widget_hardening.md` | 开发 Android Jetpack Glance 桌面小组件时使用。 |
| **桌面壁纸原生通道** | `wallpaper_native_channel_engine.md` | 调用移动端设壁纸核心 Native 功能时使用。 |
| **全量代码自动生成** | `lossless_code_generation_protocol.md` | Freezed/Isar 自动生成、禁止 Barrel exports 时使用。 |

#### 2. 解析器与沙盒脚本 (`skills/4_tech_stacks/parsers_and_sandboxes/`)
| 技能名称 | 路径 | 触发场景 |
| :--- | :--- | :--- |
| **河图插件标准模板** | `hetu_script_plugin_standard_template.md` | 开发或生成新的河图 (`.ht`) 脚本数据源时使用。 |
| **河图沙盒核心与迁移**| `hetu_plugin_core_and_migration.md` | 数据源/脚本沙盒化及测试规范。 |
| **河图迁移与类型防爆** | `hetu_plugin_migration_and_pitfalls.md` | Dart 闭包 dynamic 形参绑定、防类型断言崩溃时使用。 |
| **河图沙盒隔离与水合** | `hetu_sandbox_isolation_and_hydration.md` | 多插件流式并发与 Isar 源码存储时使用。 |
| **Legado 阅读引擎** | `legado_reader_engine_parity.md` | 开发或迁移网络阅读源/复杂选择器解析器时使用。 |
| **GitHub 权威开源对齐**| `github_open_source_alignment.md` | API 逆向、签名反爬、Cookie 维持逻辑时使用。 |

#### 3. 商业变现与生态打通 (`skills/4_tech_stacks/commercial_and_ads/`)
| 技能名称 | 路径 | 触发场景 |
| :--- | :--- | :--- |
| **三层拓扑变现包** | `protocol_hub_driver_topology.md` | 开发重型变现矩阵、多驱动第三方 SDK 接入时使用。 |
| **商业变现与内购** | `commercial_ads_and_purchase_matrix.md` | App 包含广告展示或应用内购买订阅时使用。 |
| **用户风控画像** | `user_risk_control_profiler.md` | App 包含严格商业变现合规与风控熔断时使用。 |
| **Author DTO 三级流转** | `author_dto_and_three_tier_hierarchy.md` | App 包含作者/创作者多模态数据展示时使用。 |
| **多平台数据打通** | `scrobbler_and_outbound_push_matrix.md` | App 包含外部第三方平台打卡与反推时使用。 |

---

## 2. 调度执行铁律
1. **零假设与必须读取**：绝不凭主观猜测特定 Skill 的内容，在执行对应模块任务时，必须先读取对应的 Skill 文件；
2. **完全解耦与独立**：各专业领域技能完全独立存在于各自物理目录中，绝不在代码中强行绑定无关领域的概念。
