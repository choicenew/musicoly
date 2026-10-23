# Page & Widget Deep Decoupling (Page 与 Widget 深度解耦及服务隔离规范)

## 0. 适用场景
所有 Flutter UI 表现层、页面脚手架与组件化开发时通用加载本技能。

---

## 第一章：Page 与 Widget 拆分铁律

### 1. 单文件体量红线
* **单个 Page 页面文件不得超过 250 行**（绝对硬性红线 400 行）。
* 凡超过 250 行的页面，必须按**视觉层级与功能职责**立即拆分为独立 Widget，存放在当前模块的 `widgets/` 目录下。

### 2. 彻底禁止滥用局部私有构建方法（Anti-pattern）
* **绝对禁止**在 Page / Parent Widget 内部编写大量的 `Widget _buildHeader()`, `Widget _buildCard()`, `Widget _buildListTile()` 局部私有构建方法！
* **致命根因**：私有构建函数本质上属于父组件内部逻辑，无法享受 Flutter 框架级 Element 节点的复用与 `const` 优化。当父组件 `setState` 或 `ref.watch` 触发 rebuild 时，会导致整页所有子组件无差别重新渲染。
* **强制要求**：将视觉区块抽离为独立的 `StatelessWidget` 或 `ConsumerWidget` 类，每个类专注于单一渲染职责。

### 3. 标准目录布局契约
```text
lib/modules/<feature_name>/
├── views/
│   └── <feature>_page.dart           # 仅负责页面脚手架 (Scaffold)、AppBar 与顶级布局骨架
├── widgets/
│   ├── <feature>_header_widget.dart  # 独立的头部组件
│   ├── <feature>_content_list.dart   # 独立的列表/内容流组件
│   └── <feature>_action_bar.dart     # 独立的操作栏组件
└── providers/
    └── <feature>_notifier.dart       # 状态中枢 (Riverpod 3.0 Notifier)
```

---

## 第二章：UI 严禁直接耦合 Service 铁律

### 1. 绝对隔离原则
* **Page 和 Widget 内部绝对禁止直接出现任何 Service 实例、单例调用或底层数据库直接访问！**
* **严禁代码**：
  ```dart
  // ❌ 严重违规：UI 直接持有并调用 Service / Database
  final data = await ComicVisionService.instance.process();
  final books = await IsarDatabase.instance.getBooks();
  ```
* **合规代码**：
  ```dart
  // ✅ 规范：UI 仅通过 Notifier 派发意图与监听不可变状态
  ref.read(comicReaderProvider.notifier).startAiTranslation();
  final state = ref.watch(comicReaderProvider);
  ```

### 2. 状态分层职责边界
1. **表现层（Views / Widgets）**：纯声明式渲染。只通过 `ref.watch` 获取不可变 State，通过 `ref.read` 派发用户意图。零计算、零 IO、零业务判定。
2. **状态层（Notifier）**：继承自 Riverpod 3.0 的 `Notifier` 或 `AsyncNotifier`。负责编排业务流程、捕获异常、驱动状态流转。
3. **基础设施与服务层（Service / Task）**：100% 零 UI 代码（严禁出现 `BuildContext`, `Widget`），封装纯业务计算、网络传输与数据库读写。
