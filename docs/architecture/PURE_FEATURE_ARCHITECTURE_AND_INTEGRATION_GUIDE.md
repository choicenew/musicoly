# Musicoly 100% Pure Feature-Driven 架构升级与二次开发/插件接入指南

> **文档版本**: 2.0.0  
> **更新时间**: 2026-10-23  
> **适用对象**: 后续接手开发者、AI Agent、第三方动态插件开发者  

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
    ├── album/                   # 专辑 Feature (AlbumPage, AlbumHeader)
    ├── artist/                  # 歌手 Feature (ArtistPage, ArtistHeader)
    ├── settings/                # 设置 Feature (SettingsPage, UserPreferences)
    ├── language/                # 语言 Feature (LanguageSettingsPage, LocaleService)
    ├── statistics/              # 听歌数据分析 Feature (PlayStats, ArtistStats)
    ├── theme/                   # 主题 Feature (DynamicTheme, ColorSchemePicker)
    ├── plugin/                  # 插件 Feature (PluginRuntimeContainer, MediaAggregator, AdSectionPlugin)
    └── track_source/            # 音源 Feature (TrackSourceContract, TrackSourceManager, LocalTrackSource)
```

---

## 4. 后续开发者二次开发指南 (Developer Integration Guide)

### 4.1 新增一个 UI 业务 Feature 规范
当需要开发一个新的业务功能（例如`podcast`或`live`）：
1. 在 `lib/features/` 下创建子目录：`lib/features/podcast/`。
2. 保持模块内连与自包含，严禁将 Provider 写在 `core/`：
   ```text
   lib/features/podcast/
   ├── presentation/           # UI 页面与小组件
   ├── providers/              # Riverpod Notifier 状态提供者
   └── services/               # 专属服务实现
   ```
3. 状态管理统一遵守 **Riverpod 3.0** 规范（使用 `@riverpod` 生成 Notifier / AsyncNotifier）。

### 4.2 使用大一统通用领域实体
- **单曲 / 节目 / 章节**：统一使用 `TrackModel`，无需创建自定义类。
- **专辑 / 播客 Show / 系列**：统一使用 `AlbumModel`。
- **创作者 / 播客 Host**：统一使用 `ArtistModel`。
- **歌单 / 播放队列**：统一使用 `PlaylistModel`。

---

## 5. 动态扩展插件开发与接入指南 (Plugin Integration Guide)

### 5.1 动态插件契约标准 (`PluginSourceContract`)
任何第三方插件或新音频源，只需实现 `PluginSourceContract` ABI：

```dart
import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/models/media_model.dart';

abstract class PluginSourceContract {
  /// 插件唯一标识符 (例如 'org.pyromusic.yt', 'org.pyromusic.subsonic')
  String get pluginId;

  /// 插件人类可读显示名称
  String get pluginName;

  /// 语义化版本号
  String get version;

  /// 插件描述信息
  String? get description;

  /// 获取插件提供的首页动态板块列表
  Future<List<HomeSectionModel>> fetchHomeSections();

  /// 搜索媒体内容
  Future<List<MediaModel>> search(String query, {List<String>? types});

  /// 获取播放音频流句柄 (URL, Headers, Quality)
  Future<AudioStreamInfo> fetchAudioStream(String trackId);
}
```

### 5.2 首页动态推荐板块渲染红线 (`fetchHomeSections`)
- 插件返回包含组件类型的 `HomeSectionModel`（支持 `carousel` 轮播、`grid` 网格、`trackList` 列表、`quickActions` 快捷操作）。
- 宿主的 `HomePage` 渲染器根据已启用的插件数据驱动动态排版渲染，无需改动宿主 UI 代码。

### 5.3 插件注册与沙盒容器 (`PluginRuntimeContainer`)
在插件启动或动态加载时，通过沙盒管理器注入注册：

```dart
final container = PluginRuntimeContainer();
container.registerPlugin(MyCustomAudioPlugin());
```

---

## 6. 多源融合去重与无感广告渗透引擎 (`MediaAggregator`)

### 6.1 指纹去重算法
当多个插件返回相同的作品时，`MediaAggregator` 执行去重计算：
- **标准化指纹**：`generateCanonicalFingerprint(artist, title)`
- **降级降频**：将多源归一生成 `CompositeTrackModel`，按音质品质（Lossless > High > Medium）降序排序可用流列表，主源失败无感切备用源。

### 6.2 无感广告自然渗透规则
- **广告卡片自然融合**：赞助广告 (`AdMediaModel`) 伪装为原生方形卡片、圆形卡片或列表行混入内容流。
- **1:6 渗透比例**：平均每 6~8 个常规内容项混入 1 个赞助推荐项。
- **首屏绝对保护**：**首页 Index 0/1（顶部前 2 项）绝对禁止展示广告**。
- **禁止硬编码文字遮罩**：绝对禁止在广告卡片上强加 `"AD / 赞助"` 等悬浮盖层。

---

## 7. 版本控制与发布流规范 (Git & Delivery Rules)

- **唯一的锁文件**：全 Monorepo 工程统一遵照 Dart 3.5+ **Pub Workspaces** 治理体系，仅保留根目录唯一的 `pubspec.lock`。
- **Commit 规范**：遵循 Conventional Commits（如 `refactor(arch): complete 100% pure feature-driven clean architecture migration`）。
