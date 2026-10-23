# Naming Convention Protocol (工程命名禁忌与语义强规范)

## 0. 规范宗旨
代码命名是工程专业度与领域建模清晰度的第一门面。严禁使用任何模糊、幼稚、废话式的命名，杜绝将临时或随意的命名引入代码库。

---

## 1. 绝对禁止的前缀红线 (Prohibited Prefixes)

### 1.1 绝对禁止以 `my_` / `my-` / `My` 开头
* **禁止原因**：`my_*`（如 `my_apps`、`my_profile`、`my_contracts`）属于极其学生气、表意模糊、不专业的主观命名，在生产级工程和领域驱动设计（DDD）中毫无领域价值。
* **替换原则**：必须使用**具象的业务实体、角色语义或领域模型名词**进行替换：
  - ❌ `my_apps` / `MyAppsPage`
  - ✅ `publisher_roster` / `PublisherRosterPage` 或 `published_portfolio`
  - ❌ `my_contracts`
  - ✅ `borrowed_contracts` / `pledged_contracts`
  - ❌ `my_profile`
  - ✅ `user_dossier` / `developer_profile`

### 1.2 绝对禁止以 `app_` / `app-` / `App` 开头
* **禁止原因**：在单一应用代码库内部，整个项目本身就是该 App，对自身模块加上 `app_*`（如 `app_router`、`app_theme`、`app_route_tokens`）属于典型的**冗余废话前缀**，且遮蔽了组件真正的职责身份。
* **替换原则**：直击本质，以其在系统中的**核心架构职责角色**命名：
  - ❌ `app_router.dart` / `appRouter`
  - ✅ `root_router.dart` / `rootRouter` 或 `navigation_hub.dart`
  - ❌ `app_route_tokens.dart` / `AppRouteTokens`
  - ✅ `route_tokens.dart` / `RouteTokens`
  - ❌ `app_theme.dart` / `AppTheme`
  - ✅ `theme_registry.dart` / `ThemeRegistry` 或 `palette_theme.dart`
  - ❌ `app_config.dart`
  - ✅ `system_config.dart` / `environment_config.dart`

---

## 2. 覆盖范围与执行准则
* **全要素覆盖**：本规范强制约束全工程的：
  1. 目录名（Directory names）
  2. 文件名（File names）
  3. 类名与接口名（Class & Interface names）
  4. 枚举与类型别名（Enum & Typedef names）
  5. 变量名、常量名、属性名（Variable, Constant, Field names）
  6. 路由标识符（Route tokens）
* **例外边界**：第三方 SDK 强制生成的特定约定文件除外，但所有自主开发、封装的代码与模块 100% 必须遵守此禁忌红线。
