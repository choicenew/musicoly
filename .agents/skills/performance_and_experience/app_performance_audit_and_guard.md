# App Performance Audit & Guard (120 FPS 性能防爆与卡顿调研加固规范)

## 0. 核心定位
Flutter 跨端应用性能、UI 掉帧、卡顿不跟手、内存防爆与设备高发热诊断加固标准技能。

---

## 一、 六大典型卡顿隐患与加固铁律

### 1. 高频手势与画布重绘隔离
* **硬件变换替换重绘**：拖拽/缩放控件时，使用 `Transform.rotate` / `Transform.scale` 替代将手势参数直接传入 `CustomPainter` 重算，利用 Matrix3D 合成图层硬件加速；
* **图层隔离 (`RepaintBoundary`)**：将重型 Canvas 绘制封装在 `RepaintBoundary` 内，复用 GPU Texture 缓存。

### 2. 主 UI 线程同步高密计算解耦
* **内存缓存机制 (LRU / Map Cache)**：对于输入有限且结果幂等的密集计算，引入内存缓存，命中时 0ms 瞬间返回；
* **后台 Isolate 解耦 (`compute`)**：大型推算或数据清洗强制使用 `compute()` 移交后台 Isolate。

### 3. Controller 生命周期物理绑定
* 包含控制器的组件必须继承自 `StatefulWidget` / `ConsumerStatefulWidget`，在 `initState` 初始化，在 `dispose` 显式销毁；
* **绝对禁止在 `build` 方法中 `new` 控制器实例**！

### 4. 彻底禁用 `FutureBuilder`，全面拥抱 `AsyncValue`
* 禁止在 `build` 方法中直接 `new Future` 传入 `FutureBuilder` 导致反复 Re-trigger；
* 统一使用 Riverpod 的 `AsyncValue` 与 `asyncValue.when(...)`。

### 5. 编解码 Memoization 优化
* 在条形码/二维码生成或图片解码入口处建立 LRU Cache，避免视口滚动时重复运算。

### 6. Slivers 列表懒加载与 Item 状态复用清空
* 禁用 `shrinkWrap: true` 的嵌套 `ListView`，统一采用 `CustomScrollView` + `SliverList.builder`；
* 列表 Item 复用时，`didUpdateWidget` 监听到关键 ID 改变必须重置旧数据字节缓存，防止串图。

---

## 二、 后台写日志与 IO 禁令
* **禁止后台静默写日志**：严禁在后台持续同步写入物理 `.log` 文件；
* 日志使用内存即时缓存机制，当用户主动请求导出时，才通过 `file_picker` 要求保存。
