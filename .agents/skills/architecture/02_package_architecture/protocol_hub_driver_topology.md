# Protocol-Hub-Driver Topology (三层拓扑与瀑布降级 Package 架构)

## 0. 适用场景
当创建**重型变现矩阵、多驱动第三方 SDK 接入（如广告聚合、云盘驱动、异构数据源动态调度）**的 Package 时加载本技能。

---

## 1. 三段式单向依赖拓扑 (Protocol - Hub - Driver)

每个业务领域必须严格解耦为以下三层结构，依赖**严格单向向下**，包名遵循 `pyro_<domain>_<role>` 标准三段式命名：

```text
┌────────────────────────────────────────────────────────────────────────┐
│               1. 宿主 App / 商业化装配中枢 Connectors                  │
│                  (负责将 Driver 驱动注册挂载至 Hub 的婚礼现场)              │
└───────┬───────────────────┬───────────────────┬────────────────────────┘
        │                   │                   │
        ▼                   ▼                   ▼
2. pyro_<domain>_hub       pyro_<domain>_<driver1> pyro_<domain>_<driver2>
 (单例注册与调度中枢)        (纯底层 Driver 微包 1)     (纯底层 Driver 微包 2)
        │                   │                   │
        └───────────┬───────┴───────────┬───────┘
                    ▼                   ▼
          3. pyro_<domain>_protocol
              (纯抽象契约、数据模型与元数据)
```

### 1.1 标准协议包 (`pyro_<domain>_protocol`)
* **定位**：全网唯一的“共同语言”纯抽象契约包。
* **物理红线**：**仅允许依赖 `flutter` SDK**！绝对禁止引入任何第三方重型 SDK、UI 界面、Hub 或状态管理库。
* **职责**：定义驱动接口（`Adapter` / `Executor`）、领域数据模型（`Entity`）、元数据与枚举。

### 1.2 标准底层 Driver 微包 (`pyro_<domain>_<driver>`)
* **定位**：纯底层能力微包，一个微包仅封装一个具体的三方 SDK 或本地能力。
* **依赖红线**：**底层 Driver 微包仅依赖 `pyro_<domain>_protocol`**！**绝对严禁依赖 Hub (`pyro_<domain>_hub`)**！必须保持底层微包极致纯净。

### 1.3 标准调度中枢包 (`pyro_<domain>_hub`)
* **定位**：运行时 Service Locator 与调度引擎。
* **依赖**：`pyro_<domain>_protocol`。
* **职责**：
  - 维护纯 Dart 单例 `Hub.instance`；
  - 提供 `register(adapter)` 与 `getDriver(providerId)` 注册及查询接口；
  - **动态避让与熔断**：Hub 只管调度内存注册表中已注册的驱动。若某个驱动未注册或未引入，Hub 自动在调度链路中剔除避让，天然熔断。

---

## 2. 构建期 Config 驱动依赖按需拉取 (Build-Time Config-Driven)

为了实现主 App 终极轻量化与零冗余打包，建立构建期配置驱动机制：
1. **构建预处理**：构建工具链在执行 `flutter build` 编译前，读取构建期配置文件。
2. **编译期物理 0 污染**：
   - 如果配置文件中**未启用/未注册**某个特定驱动，构建流程自动将对应 Driver 微包从依赖树剥离；
   - Gradle (Android) 与 CocoaPods (iOS) **在编译期物理上 100% 零拉取、零编译、零字节膨胀**。
3. **免人工改写**：开发者绝对不需要人工反复修改 `pubspec.yaml`。

---

## 3. 瀑布流自动降级回退机制 (Waterfall Fallback)

针对广告变现充填率与多源数据容灾，Hub 必须实现瀑布流自动降级：
1. **初始调用**：Hub 接收业务请求，优先尝试首选驱动（或最高优先级 Tier 驱动）；
2. **平滑降级**：若目标驱动遇到 No Fill、网络 Timeout 或抛出异常，Hub 自动无缝降级触发备用驱动（Backup Driver）；
3. **全过程对上层 UI 屏蔽异常细节**，保障系统高可用性与绝不黑屏。
