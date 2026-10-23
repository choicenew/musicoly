# Riverpod 3.0 Full Convention (Riverpod 3.0 全量规范与迁移速查表)

## 0. 适用场景
在使用 Riverpod 3.0 进行状态管理、ViewModel 开发或代码重构时通用加载。

---

## 1. 核心规约与速查表

### 1.1 自动重试机制 (Automatic Retry)
* Riverpod 3.0 默认自动重试失败的 Provider。
* **全局禁用**：
  ```dart
  ProviderScope(retry: (retryCount, error) => null, child: MyApp())
  ```
* **单 Provider 禁用**：
  ```dart
  NotifierProvider<TodoList, List<Todo>>(TodoList.new, retry: (retryCount, error) => null)
  ```

### 1.2 局部非视口暂停 (Out of view providers are paused)
* 不在屏幕视口显示的 Provider 默认自动暂停工作。在 Consumer 层使用 `TickerMode(enabled: true, child: Consumer(...))` 可禁止暂停。

### 1.3 Legacy 组件新引入路径
* `StateProvider`、`StateNotifierProvider`、`ChangeNotifierProvider` 已移入 `legacy.dart`：
  ```dart
  import 'package:flutter_riverpod/legacy.dart';
  ```

### 1.4 统一使用 `==` 过滤更新
* 所有 Provider 一律默认使用 `==` 过滤重复更新。若需自定义，覆写 `Notifier.updateShouldNotify`：
  ```dart
  @override
  bool updateShouldNotify(AsyncValue<Todo> previous, AsyncValue<Todo> next) => true;
  ```

### 1.5 Ref 简化与 Subclass 移除
* 去除了所有 Ref 子类（如 `ProviderRef` 等，统一使用 `Ref`）。
* 属性转移至 Notifier：
  - `ProviderRef.state` ➔ `Notifier.state`
  - `FutureProviderRef.future` ➔ `AsyncNotifier.future`

### 1.6 AutoDispose 接口合并
* 不再需要 `AutoDispose` 前缀，直接使用 `Notifier` / `Provider`。

### 1.7 Family 变体移除
* 去除了 `FamilyNotifier` 系列，合并入标准类，构造函数直接透传参数：
  ```dart
  class CounterNotifier extends Notifier<int> {
    CounterNotifier(this.arg);
    final String arg;
    @override
    int build() => 0;
  }
  ```

### 1.8 异常抛出包装为 `ProviderException`
* 所有 Provider 内部抛出的异常统一包装为 `ProviderException`：
  ```dart
  try {
    await ref.read(myProvider.future);
  } on ProviderException catch (e) {
    if (e.exception is NotFoundException) { ... }
  }
  ```
