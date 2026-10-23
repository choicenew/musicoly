# Hetu Plugin Migration & Pitfalls (河图插件迁移与避坑指南白皮书)

## 一、 核心误区与避坑指南

1. **不得混淆 Dart 源代码与 Hetu 脚本**：
   - 错误做法：直接编写 Dart 原生类并放入包中，以为完成了插件迁移。
   - 正确做法：必须按 `manifest.json` + `source.ht` 标准结构封装为可在沙盒虚拟机中运行的独立插件包。

2. **不得偷懒漏写源，必须 1:1 完整转译**：
   - 面对开源库中的多个数据源时，必须逐一拆解其网络 API、请求头、加密参数及 JSON/HTML 解析逻辑，逐一转译为标准的 `source.ht`。

---

## 二、 Hetu 类型安全绑定防爆铁律 (HTStruct Binding Protocol)

1. **Dart 外部闭包形参必须声明为 `dynamic`**：
   - 在 Dart 与 Hetu 的外部扩展绑定（如 `HttpClientBinding`）中，当 Hetu 脚本向 Dart 方法透传字典/参数时（如 `queryParameters` / `options`），**Dart 闭包形参必须声明为 `dynamic queryParameters`，绝对不能声明为 `Map<String, dynamic>?`**！
   - **致命根因**：若声明为 `Map<String, dynamic>?`，Dart 运行时会在进入闭包前对实参强类型断言，抛出 `type 'HTStruct' is not a subtype of type 'Map<String, dynamic>?'` 运行时崩溃。

2. **禁止使用非 Hetu 原生静态方法**：
   - Hetu 脚本中 `Map` 不支持 `Map.from()` 静态构造函数。浅拷贝字典必须使用标准 Hetu 循环或字典字面量。

---

## 三、 沙盒编译与独立测试验证铁律
* **拒绝虚假成功**：彻底废除“All tests passed”的空洞口号。
* **必须输出明细**：每一个插件编写完成后，必须独立触发运行并**直接输出真实的明细**（标题、ID、封面、作者）。无明细回传直接判定为失败！
