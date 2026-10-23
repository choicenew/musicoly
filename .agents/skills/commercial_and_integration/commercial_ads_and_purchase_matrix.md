# Commercial Ads & Purchase Matrix (商业广告变现矩阵与内购规范)

## 0. 适用场景
当项目接入多广告网络（AdMob / AppLovin / Unity Ads / StartApp / 自有房广告）或包含应用内购买订阅时加载本技能。

---

## 1. 架构单向解耦规范

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   1. 宿主 App / pyro_commercial_hub                    │
│                  (商业变现中台，负责将驱动挂载注册给 Hub)                      │
└───────┬───────────────────┬───────────────────┬────────────────────────┘
        │                   │                   │
        ▼                   ▼                   ▼
2. pyro_ads_hub    3. pyro_ads_admob / applovin 4. pyro_purchase_core / ui
 (单例注册与调度中枢)   / unity / startapp / house  (内购引擎与特权面板)
        │                   │                   │
        └───────────┬───────┴───────────┬───────┘
                    ▼                   ▼
          5. pyro_ads_protocol              6. pyro_purchase_protocol
        (纯抽象契约与数据模型)                 (内购纯抽象契约)
```

1. **`pyro_ads_protocol` (广告契约包)**：纯接口契约，仅依赖 Flutter SDK，绝对禁止依赖 Hub、UI 或重型 SDK；
2. **底层 Driver 微包 (`pyro_ads_admob` 等)**：仅依赖 Protocol，**绝对禁止依赖 Hub**；
3. **`pyro_ads_hub` (中枢包)**：维护 `AdsHub.instance` 单例注册表，实现 Waterfall 瀑布流降级；
4. **`pyro_commercial_hub` (装配中台)**：负责在启动时将各驱动注册挂载至 Hub。

---

## 2. 广告体验与合规红线
* **严禁强弹拦截**：严禁在 App 首页刚启动或加载完成时强行弹出插屏广告；
* **优雅占位**：广告未就绪 (Ready) 前，必须提供透明视图占位或静默排队，禁止界面跳变抖动。
