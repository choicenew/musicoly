# Standard Clean Architecture (标准单体清洁架构)

## 0. 适用场景
当项目为**中大型独立单体业务应用、逻辑复杂度高、需要高稳定性与长期可维护性**（如电商、办公协同、工具箱）时选用的主 App 架构。

---

## 1. 架构三层解耦规范 (Presentation ➔ Domain ➔ Data)

```mermaid
graph TD
    subgraph Presentation Layer [UI / 表现层]
        Views[Pages & Widgets] --> Notifier[Riverpod Notifier / ViewState]
    end

    subgraph Domain Layer [Domain / 领域层 (纯 Dart，零外部依赖)]
        Notifier --> UseCases[Use Cases / Interactors]
        UseCases --> Entities[Domain Entities (不可变业务对象)]
        UseCases --> RepoInterface[Repository Interfaces (抽象仓储接口)]
    end

    subgraph Data Layer [Data / 数据层]
        RepoImpl[Repository Implementations] -.-> RepoInterface
        RepoImpl --> DataSources[Data Sources (Local DB / Remote API)]
    end
```

---

## 2. 核心架构红线
1. **依赖单向性**：Presentation 依赖 Domain，Data 依赖 Domain。**Domain 层绝对禁止反向依赖 Presentation 或 Data 层**。
2. **Domain Entity 纯洁性**：Domain Entity 是核心业务领域模型，严禁直接使用 JSON 反序列化库注解或第三方数据库注解浸染领域实体。
3. **Repository 接口隔离**：Domain 层仅定义 Repository 抽象接口，具体的数据缓存与网络交互由 Data 层实现。
