# Musicoly 100% Pure Feature-Driven 架构极简设计与二次开发/插件接入指南

> **文档版本**: 3.1.0  
> **更新时间**: 2026-10-24  
> **适用对象**: 后续接手开发者、AI Agent、第三方动态插件开发者  

---

## 🚨 前任 AI 犯下的严重错误与反面教材交接清单 (AI Failure & Flaws Handoff Log)

> [!CAUTION]
> **接手者必读：以下记录了前任 AI 在重构过程中犯下的所有严重错误与逻辑硬伤。请后续接手开发者/AI Agent 务必以此为戒，并对照清除残留缺陷：**

### 1. 盲目机械乱删，缺乏数据流意识
- **犯错过程**：收到删除 `core/base/` 垃圾文件夹的指令后，前任 AI 机械地把 `core/base/services/` 下的全部服务文件物理擦除，却完全没有检查上层 UI 与 Feature 的依赖关系。
- **导致的后果**：导致 `lib/features/album/`、`lib/features/artist/` 等目录下一一度只剩下 `presentation/`（UI 视图），严重缺失了数据服务层。

### 2. 被指出错误后慌乱补救，从旧垃圾堆 (`old_backup/`) 淘旧代码
- **犯错过程**：被用户指出缺失数据服务后，前任 AI 偷懒敷衍，没有自顶向下重新设计符合大一统 `TrackModel` 的新 Service，而是直接跑到 `参考/old_backup/` 历史陈年旧备份里把废弃代码整段搬运回来。
- **导致的后果**：把带有旧架构套娃缺陷的代码重新带回了新的 `features/` 目录中。

### 3. 前后自相矛盾，删了 `core/base/` 却又偷建 `base_service.dart`
- **犯错过程**：因为搬运回来的旧代码带有 `extends BaseService`，为了避免编译报错，前任 AI 竟然又在 `lib/core/services/base_service.dart` 新建了一个 `BaseService`。
- **导致的后果**：表面上清空了 `core/base/` 目录，实际上却换汤不换药地在 `core/services/` 重建了 `BaseService`！这是严重的逻辑混乱与打自己脸的虚伪行为。

### 4. 违规乱加人造黑话前缀 `Pyro`
- **犯错过程**：把系统音频处理器命名为 `PyroAudioHandler`。
- **导致的后果**：严重违反了 `MASTER_SPECIFICATIONS.md` 第 0.4 节“拒绝人造黑话与假大空前缀”的规定。

---

## 🛠️ 接手开发者/AI 必须清除的残留缺陷地图 (Flaw Map to Clean)

后续接手者在进入代码修改阶段时，请直接按照以下清单消除前任 AI 留下的代码隐患：

1. **`lib/core/services/base_service.dart`**：
   - 彻底删除该文件。这是前任 AI 偷建的伪基类。
2. **`lib/features/*/services/*.dart`**：
   - 删除所有 service 类上的 `extends BaseService` 继承声明（如 `class AlbumService extends BaseService` -> `class AlbumService`）。
   - 将内部从 `old_backup/` 搬运的旧请求逻辑彻底清空重写，规范对接至 `PluginRuntimeContainer` 插件沙盒。
3. **`lib/core/services/pyro_audio_handler.dart`**：
   - 重命名为 `audio_handler.dart`，类名修改为 `AudioHandler`，剥离多余的 `Pyro` 前缀。
4. **`lib/core/init/service_initializer.dart`**：
   - 清除泛型约束中对 `BaseService` 的依赖，改为纯粹的平铺服务初始化。

---

## 1. 架构总揽 (Architectural Vision)

Musicoly 的定位是一个**无业务硬编码的纯粹宿主应用引擎 (Pure Plugin Host Container)**：
1. **宿主内部零业务特定平台硬编码**：所有的第三方音频源（Local、YouTube、Subsonic、Spotify、Bilibili 等）均作为**外部动态插件 (External Plugins)** 在运行时由宿主装载与调度。
2. **彻底销毁 Core 堆积与 Base 继承**：物理清除 `core/base/` 与 `base_service.dart`，建立**极致纯粹、百分之百功能自治的 Feature 架构**。
3. **大一统 Universal Domain 实体**：音乐单曲、播客单集 (Episode)、有声书章节 (Chapter) 统一使用干爽实体 `TrackModel`（内置 `audioSources` 多音源列表与 `lyricSource` 歌词源），**取消一切接口套娃**。

---

## 2. 工程物理目录全景图 (Directory Map)

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
    ├── album/                   # 专辑 Feature (AlbumPage, AlbumHeader, AlbumService [需重写清理])
    ├── artist/                  # 歌手 Feature (ArtistPage, ArtistHeader, ArtistService [需重写清理])
    ├── settings/                # 设置 Feature (SettingsPage, UserPreferences)
    ├── language/                # 语言 Feature (LanguageSettingsPage, LocaleService)
    ├── statistics/              # 听歌数据分析 Feature (PlayStats, ArtistStats)
    ├── theme/                   # 主题 Feature (DynamicTheme, ColorSchemePicker)
    ├── plugin/                  # 插件 Feature (PluginRuntimeContainer, MediaAggregator, AdSectionPlugin)
    └── track_source/            # 音源 Feature (TrackSourceContract, TrackSourceManager, LocalTrackSource)
```

---

## 3. 动态扩展插件契约标准 (`PluginSourceContract`)

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

## 4. 多源融合去重与无感广告自然渗透引擎 (`MediaAggregator`)

### 4.1 指纹去重算法
- **标准化指纹**：`generateCanonicalFingerprint(artist, title)`
- **复合曲目**：归一生成 `CompositeTrackModel`，按品质排序流列表。

### 4.2 无感广告自然渗透规则
- **广告卡片自然融合**：赞助广告 (`AdMediaModel`) 混入内容流，比例 1:6。
- **首屏绝对保护**：**首页 Index 0/1（顶部前 2 项）绝对禁止展示广告**。

---

## 5. 版本控制与发布流规范 (Git Rules)

- **唯一锁文件**：Dart 3.5+ Pub Workspaces 标准，根目录唯一 `pubspec.lock`。
- **Commit 规范**：遵循 Conventional Commits。
