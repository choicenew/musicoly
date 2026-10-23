# Pyro Workspace 原生 Pub Workspaces 依赖治理指南 (Industrial-Grade Pub Workspace Guide)

## 📌 背景与演进 (Background & Evolution)

随着 PyroMagma 架构的持续演进，底层微包数量扩展至 **110+** 个。早期采用手写 Python 正则替换脚本 (`pyro_safe_governance.py`) 和 `shared_versions.yaml` 的强行替换方案，在面对 **Google Play Billing Library v8 强升**、**Firebase 升级** 以及复杂传递依赖闭包时，暴露出了致命瓶颈：
1. **字符串正则局限**：正则无法理解 Dart 依赖树的传递闭包，修改多处文件引发版本冲突解算死锁 (`Version solving failed`)。
2. **云端自动 Commit 混乱**：CI 在云端自动修改文件并 commit 回推，引发开发者本地与云端 Git 冲突。

**现已全面废除手写脚本与 shared_versions.yaml，升级至 Dart 3.5+ 官方原生的 Pub Workspaces 工业级治理体系。**

---

## 🏗️ 架构标准 (Architectural Specification)

### 1. 唯一顶层工作区声明 (`/pubspec.yaml`)

整个 Monorepo 由根目录下的 `pubspec.yaml` 统一通过 `workspace:` 字段注册所有微包与主 App：

```yaml
name: pyro_workspace
description: Root Pub Workspace for Pyro Platform Monorepo.
publish_to: 'none'

environment:
  sdk: '>=3.5.0 <4.0.0'
  flutter: '>=3.10.0'

workspace:
  - pyro_magma
  - packages/commercial/pyro_ads_admob
  - packages/commercial/pyro_purchase_core
  - packages/telemetry/pyro_analytics_firebase
  # 统一注册全部 110+ 子包...
```

### 2. 子微包标准治理 (`packages/*/*/pubspec.yaml` & `pyro_magma/pubspec.yaml`)

被纳管的 110+ 子包配置极致精简，只需标记 `resolution: workspace`：

```yaml
name: pyro_purchase_core
description: Core In-App Purchase engine for Pyro Workspace.
version: 0.0.1
publish_to: 'none'

environment:
  sdk: '>=3.5.0 <4.0.0'
  flutter: '>=3.10.0'

resolution: workspace

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.0.3
  in_app_purchase: ^3.3.1
  in_app_purchase_android: ^0.5.3 # Play Billing v8 支持
  pyro_purchase_protocol:
    path: ../pyro_purchase_protocol
```

---

## 🛠️ 开发者日常操作 SOP (Developer Operation SOP)

### 1. 新增微包 (Adding a New Package)
1. 在 `packages/` 目录下创建新微包。
2. 在根目录 `/pubspec.yaml` 的 `workspace:` 列表中加入新微包相对路径。
3. 在新微包的 `pubspec.yaml` 中加入 `resolution: workspace`。
4. 在根目录运行 `flutter pub get` 完成全局依赖图谱挂载。

### 2. 升级公共依赖 (Upgrading Dependencies)
当需要升级像 Google Play Billing、Firebase、Dio 等公共依赖时：
```bash
# 在根目录统一升级全工作区依赖
flutter pub upgrade in_app_purchase_android --workspace
```
Dart 官方引擎会在 1 秒内自动全局解算 110+ 微包并更新顶层唯一的 `pubspec.lock`。

### 3. 本地编译与 CI 校验 (CI Verification)
* **本地验证**：在本地 IDE 运行 `flutter build apk --debug`，确认无原生 API 破契。
* **CI 机制**：CI 仅作为纯只读校验门禁（执行 `flutter pub get --offline`），**绝不自动修改文件或自动 commit 回推**。若本地提交的锁文件未对齐，CI 自动拦停。

---

## 🚫 治理禁令 (Governance Red Lines)

1. **禁**：严禁再次编写或运行任何正则搜索替换版本的 Python/Shell 脚本。
2. **禁**：严禁提交任何子包目录下的独立 `pubspec.lock`（全工程只保留根目录唯一的 `pubspec.lock`）。
3. **禁**：严禁在 CI 流水线中启用自动写文件并 `git commit & push` 的逻辑。
