# System Theme First Protocol (系统主题优先与硬编码颜色禁用规范)

## 0. 适用场景
开发、修改或重构任何 UI 页面、组件、卡片、弹窗对话框及配色时通用加载本技能。

---

## 1. 核心铁律 (System Theme Mandate)
1. **能接入系统主题，绝不使用硬编码颜色**：
   - 通用 UI 组件（页面背景、导航栏、AppBar、卡片、对话框、输入框、文本）**绝对禁止使用硬编码颜色**。
   - 严禁在通用组件中手写 `0xFF...` 固定色值、硬编码 `Colors.white`/`Colors.black`，或通过 `isDark ? darkColor : lightColor` 进行二元硬编码分配。
2. **统一使用 Material 3 / System `colorScheme` 动态令牌**：
   - 页面背景：`Theme.of(context).colorScheme.surface`
   - 卡片背景：`Theme.of(context).colorScheme.surfaceContainer`
   - 主要文字：`Theme.of(context).colorScheme.onSurface`
   - 次要文字：`Theme.of(context).colorScheme.onSurfaceVariant`
   - 强调色：`Theme.of(context).colorScheme.primary`

---

## 2. 唯一允许硬编码的例外范围 (Exclusive Exemptions)
仅在涉及**传统民俗学术与文化固有色彩**（如八字、五行色彩、传统风水罗盘、传统黄历宜忌专用红/黄色）时，允许保留其特定的固定色彩。除此之外，其余通用 UI 一律 100% 接入系统动态主题！
