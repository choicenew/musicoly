# 06. 终端命令禁令与文件自动化操作铁律 (Shell & PowerShell Prohibition Rule)

## 0. 核心目的
规范 AI 在工程中的工具调用行为，彻底杜绝滥用命令行改写文件引发的乱码、弹窗打扰与执行阻断。

---

## 1. 命令行文件操作禁令 (Prohibition of Shell File Ops)
1. **能不用 Shell 绝对不用**：
   - 严禁使用 PowerShell 或 Bash 命令行对工程文件进行创建、重命名、正则替换或批量删除！
   - 所有的代码编写、文档生成、配置修改，**必须 100% 使用 IDE 内置专用文件工具（如 `write_to_file`、`replace_file_content`）完成**。
2. **根源剖析**：
   - 命令行在跨平台编码（UTF-8 与 Windows 本地编码）转换时极易产生乱码、丢失特殊字符；
   - 命令行工具执行敏感文件操作时会触发 IDE 的权限确认弹窗，彻底阻断全自动静默落地的管线。

---

## 2. 唯一允许的命令行场景
仅在以下**非文件改写类**的标准工程链路上允许运行命令：
1. **自动化测试执行**：如运行 `flutter test`；
2. **代码静态分析**：如运行 `dart analyze` 或 `flutter analyze`；
3. **静默 Git 管道提交**：使用 PTY 管道执行 `git add .`、`git commit` 与 `git push`。
