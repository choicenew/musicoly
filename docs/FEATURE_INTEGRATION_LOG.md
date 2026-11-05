# 功能抽取与补充开发日志 (Reference Feature Integration Log)

为了方便后续继续扩展与维护，本文档记录了从 `references/` 开源项目抽取并重构补充到主项目 `@lib` 的功能模块列表与后续开发计划。

---

## 📌 已完成补充的核心模块

### 1. 桌面端与系统集成增强 (Desktop & Mini Player)
- **`lib/core/services/desktop_service.dart`**：增加了桌面迷你播放器（Mini Player）切换逻辑 `toggleMiniPlayer()` 与窗口状态恢复。
- **`lib/features/player/presentation/widgets/mini_player_window.dart`**：实现了轻量级悬浮迷你播放器 UI，支持专辑封面、曲目信息、进度条、播放控制、置顶与手势拖拽。

### 2. ListenBrainz 听歌记录与统计 (Scrobbler & Statistics)
- **`lib/features/scrobbler/plugins/listenbrainz_scrobbler.dart`**：集成 ListenBrainz API (`playing_now` 与 `submit-listens`)，接入通用 `ScrobblerManager` 插件架构。
- **`lib/features/stats/presentation/listening_stats_page.dart`**：实现了听歌时长、播放首数统计、最常听歌手 Top 5 榜单及周听歌趋势柱状图页面。

### 3. 桌面与系统悬浮歌词 (Floating Lyrics Overlay)
- **`lib/features/lyric/presentation/widgets/floating_lyric_window.dart`**：桌面透明置顶悬浮歌词条，支持主歌词/翻译双行显示、锁字/解锁与快捷悬浮控制。

### 4. 音频智能预缓存与存储管理 (Cache & Pre-fetching)
- **`lib/core/services/audio_cache_manager.dart`**：扩展了播放队列下一首歌曲的智能后台预加载 `prefetchTrackAudio()`。
- **`lib/features/settings/presentation/cache_settings_page.dart`**：可视化缓存占用进度、最大缓存容量上限 Slider、预加载开关与一键清空缓存。

---

## 🚀 下次继续开发的推荐方向

1. **路由与界面入口接入**：
   - 将 `ListeningStatsPage` 与 `CacheSettingsPage` 注册到路由 `AppRouter` 中，并在设置页面增加对应菜单项。
2. **多平台音效与 EQ 控制**：
   - 参考 `RetroMusicPlayer` / `InnerTune` 进一步扩展重低音增强 (Bass Boost) 和音频增益 (Reverb / Pitch) 效果控制器。
3. **更完善的 ListenBrainz / Last.fm 插件配置 UI**：
   - 在设置中提供 User Token 输入框与认证状态开关。
