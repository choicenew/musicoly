# Author DTO & Three-Tier Hierarchy (作者 DTO 契约与三级消费流转技能)

## 0. 核心定位
规范作者/创作者多模态数据的清洗、防泄露呈现与跨页面三级流转。

---

## 1. 作者 DTO 洗净与防泄露铁律
* **插件 100% 负责数据清洗**：插件负责输出标准结构的 `author` 字典：
  ```json
  "author": {
    "id": "author_unique_id",
    "name": "作者标准姓名",
    "avatar": "https://头像地址",
    "bio": "作者简介/机构",
    "homeUrl": "https://外部主页",
    "stats": {
      "worksCount": 42,
      "viewsCount": 50000
    }
  }
  ```
* **禁止 `author.toString()` 强转渲染**：底层渲染微包严禁直接在 UI 打印 Map 对象，必须统一调用 `AuthorFormatter.formatAuthorName` / `formatAuthorAvatar` 安全提取。

---

## 2. 三级消费流转层级 (3-Tier Hierarchy)

| 层级 | 对应组件 | 交互与渲染职责 |
| :--- | :--- | :--- |
| **一级 (Level 1)** | 各领域 Card (`WallpaperCard`, `PaperCard` 等) | 包含 Avatar + `@authorName`。点击唤起 `RenderHub.instance.navigate(context, 'author_profile', authorMap)`。 |
| **二级 (Level 2)** | `pyro_render_author` 的 `AuthorProfileScreen` | **APP 内作者主页**。头部展示 Banner、大 Avatar、Bio，中间渲染 `stats` 徽章，下方全量作品瀑布流。 |
| **三级 (Level 3)** | 外部官网 Webview 页面 | 在二级主页点击 `Homepage` 按钮，通过 App 内嵌 Webview 打开作者真实外部官方页面 (`homeUrl`)。 |
