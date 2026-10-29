# PyroMusic 超级通用插件端口与多态实体架构规范白皮书 (V2.0)

本规范白皮书旨在为 `pyro_music` 平台提供**高度解耦、完全可扩展**的插件端口（Plugin Port/Contract）、大一统多态数据实体（Polymorphic MediaEntity DTO）与智能中枢调度器（PluginDispatcher）的设计标准。

通过本规范，宿主 App 无需修改任何核心 UI 与业务逻辑，即可在运行时随时接入任何形式的第三方插件（包括但不限于 Hetu `*.ht` 动态脚本、Subsonic/Navidrome 私有云、MusicFree 风格音源解析器、LX Music 服务等）。

---

## 一、 核心设计理念

1. **能力按需组合 (Capability-Based Modularity)**：
   插件无需面面俱到。插件通过声明自身支持的能力（Capabilities），只需实现对应的专长 Port 接口。
2. **多态媒体实体 (Polymorphic MediaEntity)**：
   统一的数据契约，单曲/音频、歌单/专辑/合集、首页推荐板块、纯音频流以及歌词采用统一的 DTO 表达。
3. **零信任与安全沙盒 (Zero-Trust Sandbox)**：
   动态脚本插件运行于独立沙盒中，通过受限的宿主模块（`module:http`、`module:storage`、`module:host_webview`）通信。
4. **透明中枢调度与备用源降级 (Smart Router & Fallback)**：
   宿主调度器按能力分发请求；当首选音源流失效时，自动路由至备用音源解析插件。

---

## 二、 插件能力与专业端口契约 (Capabilities & Ports)

### 1. 插件能力枚举 (`PluginCapability`)
```dart
enum PluginCapability {
  /// 探索/首页板块/推荐/分类榜单
  explore,

  /// 关键词多类型检索
  search,

  /// 音频流地址与高音质解析
  stream,

  /// 歌单/专辑/频道三级详情与曲目列表拉取
  details,

  /// 歌词解析 (LRC / 逐字 / 纯文本)
  lyrics,

  /// 播放进度监听与静默打卡/同步 (Last.fm, Trakt, Bangumi 等)
  scrobble,

  /// 主动推送存入 (Zotero 等)
  push,
}
```

### 2. 核心元数据与清单 (`PluginManifest`)
```dart
class PluginManifest {
  final String id;                  // 插件唯一标识符 (例如: 'org.pyromusic.subsonic')
  final String name;                // 插件名称
  final String version;             // 语义化版本号
  final String? description;        // 描述信息
  final String baseUrl;             // 主站或 API 基准 URL
  final Set<PluginCapability> capabilities; // 支持的能力集合
  final bool isNsfw;                // 是否包含敏感/高风险内容
  final String riskLevel;           // 'safe' | 'neutral' | 'unsafe'

  const PluginManifest({
    required this.id,
    required this.name,
    required this.version,
    this.description,
    required this.baseUrl,
    required this.capabilities,
    this.isNsfw = false,
    this.riskLevel = 'safe',
  });
}
```

---

### 3. 模块化专业端口接口 (Specialized Port Interfaces)

#### A. 探索与推荐端口 (`ExplorePluginPort`)
```dart
abstract class ExplorePluginPort {
  /// 获取首页动态推荐板块列表 (轮播图、推荐歌单、热榜、快捷操作等)
  Future<List<HomeSectionEntity>> fetchExploreSections();

  /// 按分类/标签分页拉取媒体条目
  Future<List<MediaEntity>> exploreCategory(String categoryId, {int page = 1, int limit = 20});
}
```

#### B. 多类型检索端口 (`SearchPluginPort`)
```dart
abstract class SearchPluginPort {
  /// 跨类型关键词检索
  Future<List<MediaEntity>> search(
    String query, {
    int page = 1,
    int limit = 20,
    List<MediaType>? types,
  });
}
```

#### C. 音频流解析端口 (`StreamResolverPort`)
```dart
abstract class StreamResolverPort {
  /// 解析可播放的直接音频流及 Header 配置
  Future<AudioStreamInfo> resolveAudioStream(
    String trackId, {
    String? preferredQuality,
    String? preferredCodec,
  });
}
```

#### D. 详情与歌单加载端口 (`DetailsPluginPort`)
```dart
abstract class DetailsPluginPort {
  /// 获取专辑/歌单/频道的完整细粒度元数据与内部曲目列表
  Future<MediaEntity> getDetail(String contentId);
}
```

#### E. 歌词解析端口 (`LyricsPluginPort`)
```dart
abstract class LyricsPluginPort {
  /// 获取动态 LRC 或文本歌词
  Future<String?> fetchLyrics(String trackId, {String? title, String? artist});
}
```

#### F. 静默打卡与推送端口 (`ScrobblePluginPort` & `PushPluginPort`)
```dart
abstract class ScrobblePluginPort {
  /// 静默上报听歌/观影进度
  Future<bool> scrobble(String contentId, Map<String, dynamic> payload);
}

abstract class PushPluginPort {
  /// 主动推送存入第三方库
  Future<bool> push(String contentId, Map<String, dynamic> payload);
}
```

#### G. 全能组合接口 (`UniversalPluginPort`)
```dart
abstract class UniversalPluginPort implements
    ExplorePluginPort,
    SearchPluginPort,
    StreamResolverPort,
    DetailsPluginPort,
    LyricsPluginPort,
    ScrobblePluginPort,
    PushPluginPort {
  PluginManifest get manifest;
  Future<void> init(Map<String, dynamic> context);
  List<Map<String, dynamic>> getConfigSchema();
}
```

---

## 三、 大一统多态媒体实体契约 (`MediaEntity`)

`MediaEntity` 1:1 锚定 `MediaEntity` 统一标准，作为插件与宿主通信的标准数据载体：

```dart
enum MediaType { music, audio, playlist, album, artist, video, homeSection }

class CreatorsMatrix {
  final String? singer;
  final String? author;
  final String? voice;
  final String? composer;
  final String? painter;

  const CreatorsMatrix({
    this.singer,
    this.author,
    this.voice,
    this.composer,
    this.painter,
  });
}

class MediaEntity {
  final String id;
  final String title;
  final MediaType type;

  // 1. 创作者矩阵
  final CreatorsMatrix creators;

  // 2. 图像资源规范
  final String thumbUrl;      // 低分辨率卡片/列表缩略图 (< 30KB)
  final String coverUrl;      // 高清/全量封面图

  // 3. 核心链接与流
  final String contentUrl;    // 源网页或物理标识符
  final String? mediaUrl;     // 音频/视频直链地址 (若插件直接提供)
  final Map<String, String>? httpHeaders; // HTTP 防盗链标头

  // 4. 音频/媒体领域特征
  final String? album;
  final int? trackNumber;
  final int? durationSeconds;
  final String? lyrics;       // LRC 格式歌词
  final String? quality;      // 'low' | 'medium' | 'high' | 'lossless'
  final String? codec;        // 'mp3' | 'flac' | 'm4a' | 'aac' | 'opus'

  // 5. 集合与合集特征 (歌单/专辑/频道)
  final bool isCollection;
  final String? parentId;
  final int? childrenCount;
  final List<MediaEntity>? children;

  // 6. 其它元数据
  final String? description;
  final List<String> tags;
  final String? publishDate;
  final Map<String, dynamic> extra;

  const MediaEntity({
    required this.id,
    required this.title,
    required this.type,
    this.creators = const CreatorsMatrix(),
    this.thumbUrl = '',
    this.coverUrl = '',
    this.contentUrl = '',
    this.mediaUrl,
    this.httpHeaders,
    this.album,
    this.trackNumber,
    this.durationSeconds,
    this.lyrics,
    this.quality,
    this.codec,
    this.isCollection = false,
    this.parentId,
    this.childrenCount,
    this.children,
    this.description,
    this.tags = const [],
    this.publishDate,
    this.extra = const {},
  });
}
```

---

## 四、 首页探索板块实体 (`HomeSectionEntity`)

```dart
enum HomeSectionType {
  quickActions,
  trackList,
  carousel,
  grid,
  adBanner,
  adCard,
}

class HomeSectionEntity {
  final String id;
  final String title;
  final String? subtitle;
  final HomeSectionType type;
  final List<MediaEntity> items;
  final Map<String, dynamic> extra;

  const HomeSectionEntity({
    required this.id,
    required this.title,
    this.subtitle,
    required this.type,
    required this.items,
    this.extra = const {},
  });
}
```

---

## 五、 音频流传输实体 (`AudioStreamInfo`)

```dart
class AudioStreamInfo {
  final String url;                     // 音频播放直链
  final Map<String, String>? headers;  // HTTP 请求头 (Cookie, Referer, User-Agent)
  final String? mimeType;               // 例如 'audio/mp4', 'audio/flac'
  final int? bitrate;                   // 比特率 (例如 320000)
  final String? quality;                // 'low' | 'medium' | 'high' | 'lossless'
  final List<String> fallbackUrls;     // 备用播放直链镜像列表

  const AudioStreamInfo({
    required this.url,
    this.headers,
    this.mimeType,
    this.bitrate,
    this.quality,
    this.fallbackUrls = const [],
  });
}
```

---

## 六、 智能插件调度与降级引擎 (`PluginDispatcher`)

1. **按能力分发路由 (Capability Routing)**：
   - 宿主加载首页推荐 -> 查找并聚合所有具备 `explore` 能力的插件；
   - 用户进行搜索 -> 查找并聚合所有具备 `search` 能力的插件；
   - 用户点击播放 -> 调用关联的 `stream` 插件解析 `AudioStreamInfo`。

2. **多音源自动降级与容灾 (Stream Fallback Chain)**：
   - 当选定的 primary 音源解析失败（404/超时/403）时，调度器会依据指纹（`generateCanonicalFingerprint(artist, title)`）自动寻找并调用下一个具备 `stream` 能力的插件重新解析流地址，保障无感切换。

---

## 七、 总结

本白皮书规范确立了 `pyro_music` 宿主与任意第三方插件之间的**标准化通信协议**。无论后期新增何种类型的插件，只需遵循本白皮书中的 Ports 契约与 DTO 格式，即可实现**即插即用、动态升级、无感容灾**！
