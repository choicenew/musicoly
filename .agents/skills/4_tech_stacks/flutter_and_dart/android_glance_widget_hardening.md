# Android Glance Widget Hardening Protocol (Android 桌面小组件避坑与加固法典)

## 0. 适用场景
开发 Kotlin 原生 Android Jetpack Glance 桌面小组件、修复小组件编译与交互错误时加载本技能。

---

## 1. 核心编译避坑铁律
1. **Kotlin 字符串插值隔离**：
   - 变量名后紧跟中文字符时，必须强制加上大括号进行边界隔离：`${sixtyMonth}月`，防止 Kotlin 词法分析器将中文字符误识别为变量标识符。
2. **Top-Level 公共工具函数收敛**：
   - 跨组件共享的函数（如 `formatWeekDay`、`scaledSp`）必须集中放置于基础容器文件中保持包内可见，禁止子文件重复定义同名私有函数导致重载冲突。
3. **Glance Action 参数规范**：
   - 必须使用 `actionStartActivity(MainActivity::class.java, actionParametersOf(...))` 标准签名，不接受裸 `Intent` 对象。

---

## 2. Glance 伪路由 (/CALLBACK) 与 Flutter 路由冲突标准解法
1. **小组件端入口收敛**：
   - 使用 `WidgetSyncUtils.createOpenAppAction(...)` 构建原生 Launcher Intent，路由参数通过 Extra 携带。
2. **宿主 Activity 钩子覆盖 (`MainActivity.kt`)**：
   - 重写 `FlutterActivity` 的 `getInitialRoute()` 方法，将 `glance-action` 私有协议安全映射为应用根路由 `"/"`：
     ```kotlin
     override fun getInitialRoute(): String? {
         val data = intent?.data
         if (data != null && data.scheme == "glance-action") {
             return "/"
         }
         return super.getInitialRoute()
     }
     ```
