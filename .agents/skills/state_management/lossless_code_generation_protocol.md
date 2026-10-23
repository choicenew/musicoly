# Lossless Code Generation & Repository Isolation Protocol (全量代码自动生成与仓储隔离铁律)

## 0. 核心定位
凡是能由工具链自动生成的代码（Providers、State、Isar 数据库模型、JSON 序列化），必须 100% 采用代码生成器生成，减少手写胶水代码。

---

## 1. 全量代码生成规范
* **Provider / Notifier 自动生成**：优先使用 `riverpod_annotation` + `@riverpod` + `riverpod_generator`；
* **数据模型与不可变 State**：强制使用 `@freezed` / `json_serializable`；
* **本地数据库集合**：强制使用 `isar` (`@collection`) 自动生成查询与索引方法。

---

## 2. 绝对禁止使用 Barrel Export 集中导出 (No Barrel Files / Ban `export`)
* **严禁**：在任何层级创建如 `models.dart`、`entities.dart` 等仅包含 `export` 语句用于代理集中子文件的空壳中转文件；
* **致命根因**：集中 export 属于欺骗性代理中转，极易引发隐蔽的循环依赖 (Circular Dependencies)、拖慢增量编译速度，并破坏 IDE 的精准跳转；
* **合规要求**：所有消费方代码必须显式直接 `import` 具体的物理类文件路径。

---

## 3. 100% 仓储隔离 (Repository Isolation)
* 表现层绝对不直接感知数据来自网络还是本地数据库，必须通过 Domain 层 Repository 接口隔离。
