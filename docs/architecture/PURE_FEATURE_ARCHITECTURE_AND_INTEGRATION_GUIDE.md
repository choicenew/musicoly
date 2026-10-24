# Musicoly 100% Pure Feature-Driven 架构极简设计与二次开发/插件接入指南

> **文档版本**: 3.0.0  
> **更新时间**: 2026-10-24  
> **适用对象**: 后续接手开发者、AI Agent、第三方动态插件开发者  

---

## 0. 最高架构红线 (Highest Architectural Red Lines)

> [!IMPORTANT]
> **绝对禁令 1：彻底消灭任何 `BaseService` 与 `base/` 抽象套娃（Zero Base Policy）**
> - **严禁在工程中创建 `BaseService`、`base_service.dart` 或任何 `core/base/` 目录**！
> - 任何强制继承基类（如 `class AlbumService extends BaseService`）均为严重不合格的过度设计。
> - 所有服务均为独立的具体领域类（`class AlbumService`），直接通过强类型或单例管理，**零抽象继承套娃**。

> [!IMPORTANT]
> **绝对禁令 2：严禁人造黑话与假大空前缀（Zero Artificial Prefixes）**
> - **严禁在文件名、类名或方法名中使用 `Pyro`、`Universal`、`Super` 等硬套的前缀黑话**。
> - 命名必须 100% 自然直观：
>   - 正确：`AudioHandler`（严禁叫 `PyroAudioHandler`）
>   - 正确：`TrackModel`（严禁叫 `UniversalTrackModel`）
>   - 正确：`ServiceRegistry`（严禁叫 `PyroServiceRegistry`）

> [!CAUTION]
> **重构须知：Service 层清理与重新整合指南 (Service Layer Handoff)**
> 
> 当前 `lib/features/*/services/` 目录下的服务实现仅用于定义方法签名与状态流转在编译期的对齐。
> **后续接手的开发者或 AI Agent 必须注意**：
> 1. **删除多余冗余**：清理一切不必要的 `base_service.dart` 引用与 `Pyro` 前缀。
> 2. **重新整合底层数据**：各 Feature 的 Service 逻辑需要从头到尾全面重构，统一规范对接至 `PluginRuntimeContainer` 插件沙盒与 `Isar` 数据库底座。

---

## 1. 架构总览 (Architectural Vision)

Musicoly 的定位是一个**无业务硬编码的纯粹宿主应用引擎 (Pure Plugin Host Container)**：
1. **宿主内部零业务特定平台硬编码**：所有的第三方音频源（Local、YouTube、Subsonic、Spotify、Bilibili 等）均作为**外部动态插件 (External Plugins)** 在运行时由宿主装载与调度。
2. **彻底销毁 Core 堆积与 Base 继承**：物理清除 `core/base/` 与 `base_service.dart`，建立**极致纯粹、百分之百功能自治的 Feature 架构**。
3. **大一统 Universal Domain 实体**：音乐单曲、播客单集 (Episode)、有声书章节 (Chapter) 统一使用干爽实体 `TrackModel`（内置 `audioSources` 多音源列表与 `lyricSource` 歌词源），**取消一切接口套娃**。

---

## 2. 工程物理目录与必要/不必要代码界限 (Directory & Code Boundaries)

### 2.1 极简系统内核 (`lib/core/`)
`lib/core/` **仅保留 3 大绝对不可再分的系统基础设施**，绝不包含任何 `base` 目录或 `base_service.dart`：
1. **`lib/core/models/`**：干爽的大一统领域实体（`TrackModel`, `AlbumModel`, `ArtistModel`, `PlaylistModel`, `AudioSourceModel`, `LyricSourceModel`, `HomeSectionModel`, `AdMediaModel`, `CompositeTrackModel`）。
2. **`lib/core/database/`**：Isar 嵌入式数据库底座（`database/isar/`）与统一缓存管理器（`database/cache/`）。
3. **`lib/core/router/`**：全局路由总管 (`router.dart`)。
4. **`lib/core/services/`**：仅保留真正的跨系统底层总线服务（`ServiceRegistry`, `AudioHandler`, `DesktopService`），**绝对不含 `base_service.dart`**。

### 2.2 全局代码有必要 vs 无必要的界限表 (Code Necessity Matrix)

| 模块组件 | 代码形态 | 是否必要 | 规范说明 |
| :--- | :--- | :--- | :--- |
| **`BaseService` / `base/`** | 抽象基类 | ❌ **绝对无必要** | 必须彻底销毁，服务无需强制继承基类 |
| **`Pyro` / `Universal` 前缀** | 人造类名前缀 | ❌ **绝对无必要** | 必须去掉前缀，如 `PyroAudioHandler` -> `AudioHandler` |
| **`TrackModel`** | 统一领域实体 | ✅ **核心必要** | 单曲/播客/有声书统一模型，含 `audioSources` |
| **`Isar` 数据库** | `core/database/isar/` | ✅ **核心必要** | 本地离线持久化与快照索引底座 |
| **`PluginRuntimeContainer`** | `features/plugin/` | ✅ **核心必要** | 运行时动态加载第三方扩展沙盒 |
| **`MediaAggregator`** | `features/plugin/` | ✅ **核心必要** | 媒体多源去重与 1:6 原生卡片流广告自然渗透 |

---

## 3. 工程物理目录全景图 (Directory Map)

```text
lib/
├── core/                        # 【极简系统内核】仅留底层基础设施 (零 base / 零黑话前缀)
│   ├── database/                # Isar DB 底座 & 实体 Schema (isar/ entities & isar_service)
│   ├── models/                  # 大一统实体 (TrackModel, AlbumModel, ArtistModel, PlaylistModel)
│   ├── router/                  # GoRouter 全局路由总管 (router.dart)
│   ├── services/                # 系统级总线服务 (ServiceRegistry, AudioHandler, DesktopService)
│   ├── platform/                # 平台能力注册表 (PlatformRegistry)
│   └── init/                    # 系统初始化器 (ServiceInitializer)
│
└── features/                    # 【100% 业务功能自治】所有的功能，全部是 Feature！
    ├── home/                    # 首页 Feature (Feed 状态, 动态 Section 渲染器, HomeService)
    ├── player/                  # 播放器 Feature (PlayerPage, Controls, Equalizer, SleepTimer, PlaybackService)
    ├── lyric/                   # 歌词 Feature (LyricsPage, SyncedLyrics, LyricSourceContract, LyricManager)
    ├── search/                  # 搜索 Feature (SearchPage, SearchProvider, SearchResults, SearchService)
    ├── local_music/             # 本地音乐 Feature (LocalMusicPage, LocalScanner, MultiSelect)
    ├── playlist/                # 歌单 Feature (PlaylistPage, PlaylistProvider, LocalPlaylistService)
    ├── album/                   # 专辑 Feature (AlbumPage, AlbumHeader, AlbumService)
    ├── artist/                  # 歌手 Feature (ArtistPage, ArtistHeader, ArtistService)
    ├── settings/                # 设置 Feature (SettingsPage, UserPreferences)
    ├── language/                # 语言 Feature (LanguageSettingsPage, LocaleService)
    ├── statistics/              # 听歌数据分析 Feature (PlayStats, ArtistStats)
    ├── theme/                   # 主题 Feature (DynamicTheme, ColorSchemePicker)
    ├── plugin/                  # 插件 Feature (PluginRuntimeContainer, MediaAggregator, AdSectionPlugin)
    └── track_source/            # 音源 Feature (TrackSourceContract, TrackSourceManager, LocalTrackSource)
```

---

## 4. 后续开发者 / AI Agent 接手重构 SOP

### 4.1 核心步骤 1：物理删除 `base_service.dart` 与清理继承
1. 从 `lib/core/services/base_service.dart` 物理删除该文件。
2. 移除所有 Feature 内服务类对 `BaseService` 的继承（`extends BaseService`），将其变为独立具体的 Service 类。
3. 将类名中包含的 `Pyro` 前缀完全剥离（例如 `PyroAudioHandler` -> `AudioHandler`）。

### 4.2 核心步骤 2：重写 Feature 数据服务（`features/*/services/`）
1. 每个 Feature（如 `album`、`artist`、`search`）的 Service 逻辑必须独立重写，直接通过 `PluginRuntimeContainer` 调度动态插件获取音源流或从 Isar 数据库检索。
2. 保持 `presentation/` -> `providers/` -> `services/` 物理 3 层清爽分层。

---

## 5. 动态扩展插件契约标准 (`PluginSourceContract`)

第三方插件或新音频源只需实现公开规范的 `PluginSourceContract` ABI：

```dart
import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/models/media_model.dart';

abstract class PluginSourceContract {
  String get pluginId;
  String get pluginName;
  String get version;
  String? get description;

  Future<List<HomeSectionModel>> fetchHomeSections();
  Future<List<MediaModel>> search(String query, {List<String>? types});
  Future<AudioStreamInfo> fetchAudioStream(String trackId);
}
```

---

## 6. 多源融合去重与无感广告自然渗透引擎 (`MediaAggregator`)

### 6.1 指纹去重算法
- **标准化指纹**：`generateCanonicalFingerprint(artist, title)`
- **复合曲目**：归一生成 `CompositeTrackModel`，按品质排序流列表。

### 6.2 无感广告自然渗透规则
- **广告卡片自然融合**：赞助广告 (`AdMediaModel`) 混入内容流，比例 1:6。
- **首屏绝对保护**：**首页 Index 0/1（顶部前 2 项）绝对禁止展示广告**。

---

## 7. 版本控制与发布流规范 (Git Rules)

- **唯一锁文件**：Dart 3.5+ Pub Workspaces 标准，根目录唯一 `pubspec.lock`。
- **Commit 规范**：遵循 Conventional Commits（如 `docs(arch): finalize 100% pure feature-driven architecture & integration guide`）。
