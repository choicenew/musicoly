# Micro-Package Cluster Ecosystem Protocol (微包与微包群生态规约)

## 0. 适用场景
当工程采用微包化体系（如一组渲染微包 `pyro_render_*`、一组驱动微包 `pyro_ads_*`、一组算法微包 `pyro_algorithm_*`）时，所有微包必须 100% 遵守本规约。

---

## 第一章：微包群横向零依赖铁律 (Horizontal Zero-Dependency)

### 1. 微包之间“终生不相往来”
* **横向依赖红线**：同属一个微包群的各个微包之间（例如 `pyro_render_comic` 与 `pyro_render_novel`），**绝对禁止互相 `import`**！
* 发现两个微包在 `pubspec.yaml` 里互相依赖 ➔ 直接判定为严重架构腐烂，必须打回重写。

### 2. 纯单向向下依赖协议 (Unidirectional Downward Dependency)
* 每一个微功能包仅允许单向向下依赖对应的抽象协议包（如 `pyro_render_core` 或 `pyro_media_protocol`）；
* 微包绝对禁止反向 `import` 宿主 App（`host_app` 或 `pyro_magma`）。

```text
┌──────────────────────────┐     ┌──────────────────────────┐
│ 功能微包 A (pyro_render)  │     │ 功能微包 B (pyro_render)  │
└────────────┬─────────────┘     └────────────┬─────────────┘
             │ (单向依赖)                      │ (单向依赖)
             ▼                                ▼
┌────────────────────────────────────────────────────────────┐
│          公共抽象协议包 (pyro_media_protocol)                │
└────────────────────────────────────────────────────────────┘
```

---

## 第二章：面向契约与插拔式设计 (Plug-and-Play Contract)

1. **纯 DTO 交互**：
   - 跨微包的数据流转，必须全部收敛为协议包中定义的强类型 DTO（如 `MediaEntity`、`AuthorDTO`）；
   - 严禁在微包内部私自约定未公开的散装 Map 或魔法字符串。

2. **跨微包路由中转**：
   - 当微包 A 需要触发微包 B 的能力时（例如在漫画卡片微包中点击作者头像跳转作者主页微包），**绝对禁止直接 new 作者页面的 Widget**；
   - 必须通过协议包定义的统一中枢路由器（如 `RenderHub.instance.navigate(context, 'author_profile', authorDto)`）派发路由意图，由宿主胶水层完成动态调度。

3. **微功能包纯净无副作用**：
   - 微包只负责提供具体的纯组件视图 (Slot) 或无副作用的 Task 纯函数，不私自创建失控的常驻多线程。
