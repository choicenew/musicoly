# User Risk Control & Compliance Profiler (用户风控画像与合规避让技能)

## 0. 适用场景
App 需要接入高合规要求的商业变现（如防 AdMob 封号）、多级内容合规审计与风控熔断时加载本技能。普通工具类 App 绝对不加载。

---

## 1. 风控画像与等级定义
* **`pyro_risk_profiler`**：实时采集用户交互特征与行为链路，计算出用户敏感度风控等级（`UserSensitivityLevel`: 0 ~ 5 级）；
* **内容源合规审查 (`SourceRiskAlgorithm`)**：对特定内容源或插件数据进行安全评级（`safe` / `unsafe`）。

---

## 2. 算法联动与广告熔断铁律
* **`pyro_algorithm_recommend`**：结合 UserLevel 与内容合规审计，输出目标的 `AdTrafficTier`；
* **高危避让铁律**：若是敏感内容源或高风险用户，**直接强制降级或避开 Tier 1 (AdMob)**，防止 AdMob 触发政策封号风险！
* **优先级**：账号安全与政策合规的优先级，永远高于追求单一模块的广告填充率。
