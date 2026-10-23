# Pure Utility & UI Component Package Protocol (纯工具与纯 UI 组件 Package 规范)

## 0. 适用场景
当创建轻量级纯工具库（字符串处理、纯数学计算、加解密算法）或纯 UI 基础组件库（Design Tokens、通用卡片、动画控件）Package 时加载本技能。

---

## 1. 纯工具 Package 规范 (Pure Utility)
1. **零 Hub, 零 Protocol**：纯工具包**绝对不需要 Protocol 和 Hub**！严禁盲目套用重型架构，保持代码极简。
2. **纯函数与无副作用**：
   - 仅提供纯函数或轻量静态/单例工具方法；
   - 100% 零 UI 代码（严禁引入视图渲染依赖）；
   - 不私自创建失控的常驻多线程。
3. **依赖纯净**：仅依赖核心标准 SDK，不反向依赖主工程的任何上层模块。

---

## 2. 纯 UI 组件 Package 规范 (Pure UI Component)
1. **纯粹视觉呈现**：仅包含纯 UI 组件（Widgets/Components、Buttons、Dialogs、Tokens、动画效果），**零网络 IO、零数据库直接读写**。
2. **无 Hub 调度**：不需要 Hub 或重型数据驱动器，仅通过组件构造函数接收不可变数据入参或通过事件回调。
3. **样式与主题契约**：严格遵循动态主题令牌，100% 接入系统主题，禁止硬编码颜色。
