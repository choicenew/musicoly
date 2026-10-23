# Musicoly 100% Pure Feature-Driven 架构升级与二次开发/插件接入指南

> **文档版本**: 2.1.0  
> **更新时间**: 2026-10-23  
> **适用对象**: 后续接手开发者、AI Agent、第三方动态插件开发者  

---

> [!CAUTION]
> **重大警告：Service 数据服务层重写须知 (CRITICAL WARNING ON SERVICES)**
> 
> 当前 `lib/features/*/services/` 目录下的服务实现（如 `album_service.dart`、`artist_service.dart`、`search_service.dart` 等），部分数据逻辑是从项目历史旧备份 (`参考/old_backup/`) 中紧急搬运与充实的脚手架骨架。
> 
> **请后续接手开发者与 AI Agent 务必注意**：
> 1. **现状定位**：当前的 Service 代码仅保证了方法签名、数据模型（`TrackModel` 等）与 Riverpod 状态流转在编译期和架构物理层面的闭环对齐，**其内部具体的 API 请求与数据解析逻辑属于需要彻底重写的临时骨架**。
> 2. **核心任务**：后续开发者接入时，**必须从头到尾重新整合并全面重写各个 Feature 内部的 Service 逻辑**，将其统一规范对接至 `PluginRuntimeContainer` 沙盒与 `Isar` 数据库底座，严禁直接依赖旧逻辑！

---

## 1. 架构升级概述 (Overview)

Musicoly 现已全面升级为 **100% Pure Feature-Driven Clean Architecture（纯粹功能自治Clean架构）**。
Musicoly 的定位是一个**无业务硬编码的纯粹宿主应用引擎 (Pure Plugin Host Container)**：
1. **宿主内部零业务特定平台硬编码**：所有的第三方音频源（Local、YouTube、Subsonic、Spotify、Bilibili 等）均作为**外部动态插件 (External Plugins)** 在运行时由宿主装载与调度。
2. **彻底销毁虚假 Core 堆积**：彻底清除 `core/base/` 垃圾文件夹与顶层 `core/providers/` 杂物间，建立**极致纯粹、百分之百功能自治的 Feature 架构**。
3. **大一统 Universal Domain 实体**：音乐单曲、播客单集 (Episode)、有声书章节 (Chapter) 统一使用干爽实体 `TrackModel`（内置 `audioSources` 多音源列表与 `lyricSource` 歌词源），**取消一切接口套娃**。

---

## 2. 本次重构完成的核心变更 (Refactoring Log)

### 2.1 物理清除废弃与重复目录
已从磁盘物理销毁以下旧目录：
- `lib/core/base/`（完全清除伪抽象接口与套娃类）
- `lib/core/plugins/`（已重构并归入 `features/plugin/`）
- `lib/core/sources/`（已重构并归入 `features/track_source/` 与 `features/lyric/`）
- `lib/core/storage/`（已重构规范重命名为 `lib/core/database/`）
- `lib/core/providers/`（已拆分归入各个自治 Feature 目录）
- `lib/features/stats/`（已规范化更名为全称 `lib/features/statistics/`）

### 2.2 极简系统内核 (`lib/core/`)
`lib/core/` **仅保留 3 大绝对不可再分的系统基础设施**：
1. **`lib/core/models/`**：大一统 Universal 领域实体（`TrackModel`, `AlbumModel`, `ArtistModel`, `PlaylistModel`, `AudioSourceModel`, `LyricSourceModel`, `HomeSectionModel`, `AdMediaModel`, `CompositeTrackModel`）。
2. **`lib/core/database/`**：Isar 嵌入式数据库底座（`database/isar/`）与统一缓存管理器（`database/cache/`）。
3. **`lib/core/router/`**：全局路由总管 (`router.dart`)。

---

## 3. 工程物理目录全景图 (Directory Structure)

```text
lib/
├── core/                        # 【极简系统内核】仅留系统底层基础设施
│   ├── database/                # Isar DB 底座 & 实体 Schema (isar/ entities & service)
│   ├── models/                  # 大一统 Universal 实体 (Track, Album, Artist, Playlist, AudioSource)
│   ├── router/                  # GoRouter 全局路由总管 (router.dart)
│   ├── services/                # 跨系统总线服务 (ServiceRegistry, Desktop, AudioHandler, Scrobbler)
│   ├── platform/                # 平台能力注册表 (PlatformRegistry)
│   └── init/                    # 系统初始化器 (ServiceInitializer)
│
└── features/                    # 【100% 业务功能自治】所有的功能，全部是 Feature！
    ├── home/                    # 首页 Feature (Feed 状态, 动态 Section 渲染器)
    ├── player/                  # 播放器 Feature (PlayerPage, Controls, Equalizer, SleepTimer, Playback)
    ├── lyric/                   # 歌词 Feature (LyricsPage, SyncedLyrics, LyricSourceContract, LyricManager)
    ├── search/                  # 搜索 Feature (SearchPage, SearchProvider, SearchResults)
    ├── local_music/             # 本地音乐 Feature (LocalMusicPage, LocalScanner, MultiSelect)
    ├── playlist/                # 歌单 Feature (PlaylistPage, PlaylistProvider, LocalPlaylistService)
    ├── album/                   # 专辑 Feature (AlbumPage, AlbumHeader, AlbumService [待完全重写])
    ├── artist/                  # 歌手 Feature (ArtistPage, ArtistHeader, ArtistService [待完全重写])
    ├── settings/                # 设置 Feature (SettingsPage, UserPreferences)
    ├── language/                # 语言 Feature (LanguageSettingsPage, LocaleService)
    ├── statistics/              # 听歌数据分析 Feature (PlayStats, ArtistStats)
    ├── theme/                   # 主题 Feature (DynamicTheme, ColorSchemePicker)
    ├── plugin/                  # 插件 Feature (PluginRuntimeContainer, MediaAggregator, AdSectionPlugin)
    └── track_source/            # 音源 Feature (TrackSourceContract, TrackSourceManager, LocalTrackSource)
```

---

## 4. 后续开发者重构与接入任务指南 (Developer Task Guide)

### 4.1 Service 层重构与重新整合要求
后续接手者在实现具体业务时：
1. **清理临时逻辑**：全面替换 `features/*/services/` 内部继承自旧逻辑的临时数据填充。
2. **接入插件总线**：通过 `PluginRuntimeContainer` 调度已启用的动态插件 `fetchAudioStream` 与 `search` 方法。
3. **结构统一**：保持 `presentation/` -> `providers/` -> `services/` 物理三层不变。

### 4.2 动态插件契约标准 (`PluginSourceContract`)
第三方插件或新音频源实现 `PluginSourceContract` ABI：

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

## 5. 多源融合去重与无感广告渗透引擎 (`MediaAggregator`)

### 5.1 指纹去重算法
- **标准化指纹**：`generateCanonicalFingerprint(artist, title)`
- **复合曲目**：归一生成 `CompositeTrackModel`，按品质排序流列表。

### 5.2 无感广告自然渗透规则
- **广告卡片自然融合**：赞助广告 (`AdMediaModel`) 混入内容流，比例 1:6。
- **首屏绝对保护**：**首页 Index 0/1（顶部前 2 项）绝对禁止展示广告**。

---

## 6. 版本控制与发布流规范 (Git Rules)

- **唯一锁文件**：Dart 3.5+ Pub Workspaces 标准，根目录唯一 `pubspec.lock`。
- **Commit 规范**：Conventional Commits。
