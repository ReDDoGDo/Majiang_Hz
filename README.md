# 杭州麻将项目

## 项目简介

这是一个基于Unity引擎开发的杭州麻将游戏，目标平台为Steam（Windows）。

## 技术栈

- **游戏引擎**: Unity 2022.3 LTS
- **开发语言**: C# (.NET Standard 2.1)
- **目标平台**: Steam (Windows)

## 项目状态

当前项目处于**初始化阶段**，正在进行基础架构搭建。

详细状态请查看：
- [项目状态总览](spec/AIDoc/项目状态/项目状态.md)
- [最近需求](spec/AIDoc/项目状态/最近需求.md)

## 文档结构

### ManualDoc（手动维护文档）
- [架构要求](spec/ManualDoc/架构要求.md) - 技术架构和开发规范
- [需求描述](spec/ManualDoc/需求描述.md) - 功能需求和规则描述
- [任务拆分](spec/ManualDoc/任务拆分.md) - 开发任务规划

### AIDoc（AI维护文档）
- [前端架构](spec/AIDoc/前端架构.md) - 前端目录结构和模块说明
- [项目状态](spec/AIDoc/项目状态/) - 项目开发状态跟踪
  - [项目状态总览](spec/AIDoc/项目状态/项目状态.md)
  - [最近需求](spec/AIDoc/项目状态/最近需求.md)
  - [核心系统状态](spec/AIDoc/项目状态/核心系统状态.md)
  - [游戏逻辑状态](spec/AIDoc/项目状态/游戏逻辑状态.md)
  - [UI系统状态](spec/AIDoc/项目状态/UI系统状态.md)
  - [AI系统状态](spec/AIDoc/项目状态/AI系统状态.md)

## 快速开始

### 环境要求
- Unity 2022.3 LTS
- Visual Studio 2022 或 VS Code
- Git

### 开发步骤
1. 安装Unity 2022.3 LTS
2. 克隆项目仓库
3. 用Unity Hub打开项目
4. 开始开发

## 开发规范

详细的开发规范请查看 [架构要求](spec/ManualDoc/架构要求.md)

### 代码规范
- 命名空间：MajiangHZ.[模块名].[子模块]
- 类名：PascalCase
- 方法名：PascalCase
- 变量名：camelCase
- 私有变量：_camelCase
- 常量：UPPER_CASE

### Git提交规范
- feat: 新功能
- fix: 修复bug
- refactor: 重构代码
- docs: 文档更新
- style: 代码格式调整
- test: 测试相关
- chore: 构建/工具链相关

提交信息格式: `[类型] 简短描述`

## 项目规划

### 开发周期
- **总开发周期**: 3-4个月（兼职开发）
- **核心功能**: 2个月
- **完善优化**: 1个月
- **测试发布**: 0.5-1个月

### 里程碑
1. **M1: 核心玩法可玩** (第6周)
2. **M2: UI完成** (第9周)
3. **M3: AI完成** (第12周)
4. **M4: 发布就绪** (第16周)

## 联系方式

- 项目地址：待定
- 开发者：个人开发者

## 许可证

待定

---

**注意**: 本项目为个人练手项目，仅供学习和娱乐使用。
