# Pyro Monorepo Micro-Packages Ecosystem Guide

本目录包含 Pyro Music 工业级拆分管理的各领域微包集群 (Micro-Package Clusters)。所有微包遵循 **Pub Workspaces** 规约与五层结构物理隔离法则：

```text
packages/
├── music_source/             # 音乐数据源微包集群
│   ├── music_source_protocol # 抽象契约与领域实体 (Track, Album, Artist, Playlist, Lyrics)
│   ├── music_source_driver   # 驱动实现 (Subsonic, Spotify, YouTube, Local, TagEditor, SponsorBlock)
│   ├── music_source_hub      # 调度中枢与多源流降级引擎
│   ├── music_source_connector# ServiceInitializer 胶水装配线
│   └── music_source_ui       # 平台设置、插件管理与 ID3 标签编辑器 UI
│
├── audio_player/             # 音频播放器微包集群
│   ├── audio_player_protocol # 播放器状态与 DSP 特效契约
│   ├── audio_player_driver   # 音频驱动 (JustAudio, AmbientMixer, QualityManager)
│   ├── audio_player_hub      # 播放中枢与队列调度
│   ├── audio_player_connector# 播放器胶水连接器
│   └── audio_player_ui       # 全屏播放器、迷你悬浮窗口与波形进度条 UI
│
├── scrobbler/                # 听歌打卡与统计微包集群
│   ├── scrobbler_protocol    # 打卡契约与播放历史实体
│   ├── scrobbler_driver      # 驱动 (ListenBrainz, Last.fm, HourlyHeatmap)
│   ├── scrobbler_hub         # 打卡中枢
│   ├── scrobbler_connector   # 打卡连接器
│   └── scrobbler_ui          # 统计图表与打卡设置 UI
│
├── lyric/                    # 歌词子系统微包集群
│   ├── lyric_protocol        # 逐字/逐句歌词实体与契约
│   ├── lyric_driver          # LRC/TTML 解析驱动
│   ├── lyric_hub             # OuterTune LRU Cache 歌词中枢
│   ├── lyric_connector       # 歌词胶水装配线
│   └── lyric_ui              # WordByWord 逐字动画与置顶悬浮小窗 UI
│
├── storage_backup/           # 存储与备份微包集群
│   ├── storage_backup_protocol
│   ├── storage_backup_driver # 本地 JSON 备份与 WebDAV 私有云同步
│   ├── storage_backup_hub
│   ├── storage_backup_connector
│   └── storage_backup_ui     # 缓存管理与备份还原 UI
│
└── player_effects/           # 音效与 DSP 特效微包集群
    ├── player_effects_protocol
    ├── player_effects_driver # 10段均衡器、Bass Boost、AI人声消除、3D空间音频
    ├── player_effects_hub
    ├── player_effects_connector
    └── player_effects_ui     # 音效控制面板、Canvas 粒子画布动效 UI
```

## 🛠️ 依赖治理准则
1. 全局单向依赖：`ui` / `connector` -> `hub` / `driver` -> `protocol`（严禁反向依赖）。
2. 根目录 `/pubspec.yaml` 统一通过 `workspace:` 进行依赖治理，全局共享唯一 `pubspec.lock`。
