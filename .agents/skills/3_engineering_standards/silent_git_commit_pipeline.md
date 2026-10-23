# Silent Git Commit Pipeline Protocol (静默 Git 管道提交规范)

## 0. 适用场景
当需要静默提交代码到 Git 仓库而不打扰用户、不触发 IDE 弹窗确认时加载本技能。

---

## 1. 连贯管道执行规范
1. **单行 PTY 连贯管道**：
   - 使用单行连贯管道命令执行 `git add .` -> `git commit -m "..."` -> `git push`；
   - 绝不中途停顿发问，一次性自动推流完成。
2. **Commit 信息规范 (Conventional Commits)**：
   - 必须使用标准 Conventional Commits 前缀（如 `feat: ...`, `fix: ...`, `docs: ...`, `refactor: ...`）。
3. **提交前自检**：
   - 提交前必须确认所有的改动已经过测试或静态分析验证（0 errors）。
