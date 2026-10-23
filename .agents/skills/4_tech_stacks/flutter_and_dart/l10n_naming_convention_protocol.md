# L10n Naming Convention Protocol (国际化资源命名与去重规范)

## 0. 适用场景
处理多语言文件 (ARB / XML / Strings) 的开发与维护时加载本技能。

---

## 1. 命名硬性铁律 (CamelCase Rule)
1. **唯一命名格式**：
   - 所有的 ARB / 资源词条 Key 必须统一使用 **`lowerCamelCase` (小驼峰式)**，例如 `homeTitle`、`settingsThemeMode`。
2. **绝对禁止下划线蛇形命名**：
   - **绝对禁止使用下划线蛇形命名 (`snake_case`)**（如 `home_title`），防止在 Android/iOS 原生资源合并与编译工具转换时产生资源冲突与转换混乱。
3. **通用词条全局去重**：
   - 通用词条（如 `cancel`、`confirm`、`retry`、`save`、`loading`）必须收敛至公共 L10n 域，严禁在不同业务模块中重复定义同名不同风格的 Key。
4. **ARB 字典同步**：
   - 任何新增词条必须同步补齐 `app_en.arb` 与 `app_zh.arb`，确保多语言覆盖完整。
