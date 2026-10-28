# Musicoly 动态插件化宿主架构与开放协议设计 (Dynamic Plugin Host Architecture)

## 1. 架构总揽 (Architectural Vision)

Musicoly 的定位是一个**无业务硬编码的纯粹宿主应用引擎（Pure Plugin Host Container）**。
宿主 App 内部**零内置插件逻辑、零特定平台硬编码**。所有未来的音乐/播客/音频源（如 YouTube, Spotube, Subsonic, Bilibili, Local, RSS 等）均作为**外部安装的独立扩展（External Dynamic Plugins）**在运行时加载。

```
+-----------------------------------------------------------------------------------+
|                                 MUSICOLY CORE APP                                 |
|                                                                                   |
|  +-----------------------------------------------------------------------------+  |
|  |                         PRESENTATION LAYER (UI)                             |  |
|  |   Generic HomePage (Dynamic Section Renderer) | Universal Media Player      |  |
|  +-----------------------------------------------------------------------------+  |
|                                         |                                         |
|  +-----------------------------------------------------------------------------+  |
|  |                            DOMAIN LAYER                                     |  |
|  |   Standard DTOs (TrackModel, AlbumModel) | Plugin Contract Interface        |  |
|  |   MediaAggregator | Canonical Deduplication Matching Engine                 |  |
|  +-----------------------------------------------------------------------------+  |
|                                         |                                         |
|  +-----------------------------------------------------------------------------+  |
|  |                      HOST RUNTIME ENGINE (SANDBOX)                          |  |
|  |   Plugin Engine Manager | JS/Wasm Container | IPC Bridge | Event Bus         |  |
|  +-----------------------------------------------------------------------------+  |
+----------------------------------------+------------------------------------------+
                                         |
                       OPEN PLUGIN ABI / JSON CONTRACT
                                         |
+----------------------------------------v------------------------------------------+
|                        EXTERNAL PLUGINS (LOADED AT RUNTIME)                       |
|   +------------------+   +-------------------+   +----------------------------+   |
|   | External Plugin A|   | External Plugin B |   | External Self-Hosted Server|   |
|   +------------------+   +-------------------+   +----------------------------+   |
+-----------------------------------------------------------------------------------+
```

---

## 2. 核心解耦设计原则 (Decoupling Principles)

### 2.1 UI 与数据源彻底分离
- **HomePage** 只声明式渲染通用组件块（`HomeSection`），不预设任何平台栏目。
- 页面数据源由 `HomeFeedUseCase` 触发并收集当前所有已加载外部插件返回的通用 `HomeSection` 数组。
- 插件可随时安装、卸载、禁用，UI 布局根据已启用插件数据进行数据驱动渲染。

### 2.2 开放标准契约 (Open Standard ABI / DTOs)
宿主定义统一公开的 JSON Schema 契约，外部插件在运行时只需按标准数据格式响应：

#### 媒体数据模型 (Standard Media Models)
- `TrackModel`：支持 `musicTrack`, `podcastEpisode`, `audiobookChapter`, `custom` 等类型，包含基础音轨元数据与流获取句柄。
- `AlbumModel`：支持 `album`, `podcastShow`, `audiobook`, `series` 等集合类型。
- `ArtistModel`：支持 `artist`, `podcastHost`, `creator` 等创作者类型。

#### 插件标准契约接口 (Plugin Contract)
```dart
abstract class PluginSourceContract {
  String get pluginId;
  String get pluginName;
  String get version;

  /// 获取首页动态推荐板块
  Future<List<HomeSection>> fetchHomeSections();

  /// 获取搜索结果
  Future<SearchResult> search(String query, {List<String>? types});

  /// 获取可播放的音频流（URL/Headers/Token）
  Future<AudioStreamInfo> fetchAudioStream(String trackId);
}
```

---

## 3. 多源去重与融合机制 (Deduplication & Fusion)

当用户安装了多个外部插件且不同插件返回相同作品时，宿主内置的 `MediaAggregator` 执行去重融合：

1. **标准化匹配指纹 (Canonical Fingerprint)**：
   - 算法：`normalize(Artist) + "::" + normalize(Title)`
2. **复合实体融合 (Composite Media Entity)**：
   - 将匹配相同指纹的不同插件条目合并为一个复合 `CompositeTrackModel`。
   - 内部维护 `availableSources` 列表（标记可用插件 ID 与流品质）。
3. **无感切换与优先播放 (Seamless Stream Fallback)**：
   - 播放器按用户配置的优先级选择最佳插件音源，单源失败自动切至备用源。

---

## 4. 下阶段 HomePage 改造目标 (Home Page Refactoring Steps)

1. **改造 `HomePage` 成为通用动态渲染器**：
   - 将 `HomePage` 修改为基于 `HomeFeedState` 驱动的列表渲染。
2. **抽象 `HomeFeedUseCase` 与 `MediaRepository`**：
   - 将写死卡片替换为通过 `MediaRepository` 接入的通用接口。
3. **隔离宿主运行时容器（Plugin Runtime Container）**：
   - 建立外部插件的动态加载沙盒框架与管理入口。
