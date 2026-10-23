# Thumbnail & Cache Strategy (缩略图极速缓存与原图延迟拉取策略)

## 0. 适用场景
媒体流、壁纸瀑布流、图片卡片渲染与多媒体网格展示时加载本技能。

---

## 1. 核心规约
1. **列表卡片只拉缩略图**：
   - 瀑布流/列表卡片一律优先提取 `thumbUrl` / `thumbnail` / `coverUrl` 压缩小图（几十 KB），配合网络图片缓存极速渲染；
   - 禁止在列表网格中直接加载几 MB 的超大原图，防止瞬间撑爆 GPU 显存。
2. **详情与全屏预览拉原图**：
   - 全屏高清大图 (`url`) 仅在用户点击进入全屏预览/二级详情页时按需拉取。
3. **内存尺寸约束 (`cacheWidth` / `cacheHeight`)**：
   - 使用 `ResizeImage` 或 `CachedNetworkImage` 的 `memCacheWidth` 属性对大图进行尺寸约束，避免解码原图占满内存。
