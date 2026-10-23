# 全局绝对禁止硬编码字符串与魔数协议 (Prohibit String Literals Protocol)

## 0. 适用场景与核心宗旨
在编写数据模型、跨模块通信、算法推断、UI 排版描述符、商业化变现驱动与宿主胶水层装配时**必须 100% 遵守本规约**。
彻底根除由于字符串拼写错位、缺少编译期类型检查、以及滥用集中式 Enum/Switch/Case 所导致的架构腐烂与隐蔽运行时崩溃。

---

## 第一章：核心教训与错误根源 (Lessons Learned & Root Cause)

### 1. 字符串魔数的危害
* 在代码中散落手写 `'immersive'`、`'vertical_immersive'`、`'ad'`、`'tier1_admob'` 等带引号的文本字面量，缺乏编译期检查，极易因拼写或大小写错位导致逻辑静默失效。
* 使用松散的字典通过字符串 key（如 `features['fatigueScore']` / `item.metadata['isUnsafe']`）提取字段，极易引发拼错、空指针异常与语义模糊。

### 2. 滥用硬编码 Enum / Switch 的腐烂
* 企图通过在 Protocol 或 Hub 硬编码集中式 `enum` 来解决字符串问题，会导致新微包新增排版/驱动时必须反向修改中央 Enum，严重破坏开闭原则（OCP）。

---

## 第二章：核心铁律 (Core Iron Rules)

### 1. 业务逻辑与模型零带引号文本 (Zero String Literals)
* **绝对禁止**在业务逻辑、数据模型、算法推断、排版控制与商业化调度中硬编码任何带引号的字符串字面量（如 `'ad'`、`'vertical_immersive'`、`'audio'`、`'tier1_admob'`）。
* **非国际化 UI 文本红线**：所有面向用户的 UI 提示文本必须 100% 通过国际化字典读取，绝不允许在 UI 中手写硬编码字符串。

### 2. 0 字符串 Map Key & 0 魔法数字 (Zero String Map Keys & Magic Defaults)
* **拒绝字符串 Map 查找**：所有跨模块流转的数据项必须定义为**编译期强类型属性**（如 `userFeatures.fatigueScore`、`item.isUnsafe`），严禁使用字符串动态取值。
* **拒绝函数默认魔法数字**：算法与底层函数签名中**绝对禁止硬编码兜底魔法数字**（如 `baseProbability = 0.15, minInterval = 3`）。所有参数必须设为必需标量，数值 100% 来自外部配置或注册描述符。

### 3. 微包自治自我注册 (Micro-Package Self-Registration)
* **微包下沉声明**：排版微包与广告 Driver 微包在内部下沉定义自己的描述符对象与能力属性，启动时自我注册给注册表。
* **类 Type Token 替代字符串 Key**：使用强类型 Class/Type 对象作为身份标识，彻底替换手写字符串。

### 4. 0 `switch/case` 与动态查表 (Zero Hand-Written Switch/Case)
* **算法 0 `switch/case`**：风控与算法通过枚举/对象自带的标量属性一行读取，零 `switch/case`，零条件分支。
* **商业化 0 `switch/case`**：中枢使用动态 Map 查表，各 Driver 自注册等级，0 冗余手写分支。
* **UI 0 `if/else` 分支**：主 App 胶水层直接执行多态渲染，不写任何排版名称判断逻辑。

### 5. 页面导航与路由零裸字符串红线 (Zero String Route Literals)
* **严禁裸路由字面量**：全工程 **100% 绝对禁止** 在路由注册、跳转、或组件事件中手写 `'/inbox'` 等裸字符串！
* **统一收口于 RouteTokens（杜绝 app_ 前缀）**：必须统一在路由常量中定义强类型静态常量类（如 `RouteTokens.dashboard`、`RouteTokens.inbox`）。全工程页面跳转必须只能引用该 Token 常量。禁止使用任何 `app_` 或 `my_` 前缀！

### 6. 系统渠道与环境 Token 强类型化及国际化铁律 (Environment & Flavor Tokenization)
* **严禁硬编码渠道英文字符串**：代码中绝对禁止手写裸英文字符串。
* **枚举 Token + 国际化字典双轨**：
  - 领域与状态层：必须定义为强类型枚举；
  - 表现与展示层：必须 100% 通过国际化字典读取，支持多语言动态切换。

---

## 第三章：模块领域职责划分

| 领域 | 物理红线与标准规范 |
| :--- | :--- |
| **算法领域 (`algorithms`)** | • 纯标量数学计算引擎，0 UI 概念，0 商业 VIP 概念。<br>• 0 字符串判断，不依赖任何排版协议包。<br>• 接收强类型特征对象与标量参数，输出带标量梯队的实体。 |
| **表现 UI 领域 (`views/feed`)** | • 各排版微包下沉定义描述符与标量参数，启动时注册。<br>• 0 字符串，0 硬编码 enum，0 依赖算法包。 |
| **商业广告领域 (`commercial`)** | • 拥有流量梯队主权，提供标量到梯队的映射。<br>• 中枢使用动态查表，Driver 微包自我注册等级。 |
| **主 App 胶水层 (`core/glue`)** | • 全工程唯一的婚礼装配现场，0 分支判断。<br>• 掌控商业 VIP 状态（VIP 则跳过算法）。<br>• 将 UI 描述符的标量参数透传给算法，并执行多态渲染。 |
