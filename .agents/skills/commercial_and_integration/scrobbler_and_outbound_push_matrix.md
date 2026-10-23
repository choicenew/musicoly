# Scrobbler & Outbound Push Matrix (全领域多平台反推打通矩阵技能)

## 0. 核心定位
任何要求将用户的媒体消费历史、阅读进度、学术标记推送到外部第三方服务的业务环节加载本技能。

---

## 1. 真实连通落地铁律
凡是声明了 Push / Scrobble 意图的功能，**绝对不允许留空或写假代码，必须有真实的数据连通落地**：
1. **Zotero 学术文献反推 (`pyro_render_paper`)**：
   - 连通 Zotero API (`https://api.zotero.org/users/{userId}/items`) 将 DOI、标题、作者、摘要推送存入 Zotero 知识库。
2. **Last.fm 音频/听歌打卡反推 (`lastfm_scrobble_plugin`)**：
   - 音频播放达到阈值时，向 Last.fm API 提交 `track.scrobble` 打卡。
3. **Trakt.tv 影视/视频打卡反推 (`trakt_scrobble_plugin`)**：
   - 视频观看达到阈值时，调用 Trakt.tv API (`/scrobble/stop`) 自动打卡。
4. **Bangumi / AniList 追漫进度打卡反推 (`bangumi_scrobble_plugin`)**：
   - 漫画阅读翻页时，自动推送章节进度。
