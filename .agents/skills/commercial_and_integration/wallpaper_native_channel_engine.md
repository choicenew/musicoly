# Wallpaper Native Channel Engine (Android 桌面壁纸通道驱动技能)

## 0. 适用场景
跨平台 Flutter 应用需要调用 Android Native 原生能力设置桌面/锁屏壁纸时加载本技能。

---

## 1. 核心架构与通道契约
1. **专用壁纸底部弹窗 (`packages/pyro_wallpaper_ui`)**：
   - 点击“设为壁纸”直接唤起 `WallpaperApplySheet.show(context, wallpaperUrl: url)` 底部弹窗，提供主屏、锁屏与双屏设置选项。
2. **原生 Channel 驱动 (`packages/pyro_wallpaper_platform`)**：
   - 调用 `WallpaperPlatformEngine`，通过 `pyro.platform.wallpaper/channel` 真实触发 Android `WallpaperManager`：
     - 主屏：`FLAG_SYSTEM`
     - 锁屏：`FLAG_LOCK`
     - 双屏：`FLAG_SYSTEM or FLAG_LOCK`
   - 支持相册原图安全保存与权限检查。
