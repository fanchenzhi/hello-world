# 健身记录应用

一个使用 SwiftUI 开发的健身记录应用，帮助用户追踪和管理他们的运动记录。

## 功能特点

### 1. 运动记录
- 记录不同类型的运动（跑步、骑行、游泳等）
- 记录运动时长和消耗的卡路里
- 支持添加备注信息
- 按时间顺序展示运动记录
- 查看详细的运动记录信息

### 2. 数据统计
- 显示本周运动统计图表
- 运动类型分布饼图
- 运动频率和时长分析

### 3. 目标设置
- 设置每周运动目标
- 设置运动频率和时长
- 根据WHO建议（每周150分钟）显示达标状态

### 4. 数据持久化
- 使用 UserDefaults 存储运动记录和目标
- 自动保存和加载数据

## 技术架构

### 数据模型
- `WorkoutRecord`: 运动记录模型
- `WorkoutGoal`: 运动目标模型
- `WorkoutType`: 运动类型枚举

### 主要视图
- `ContentView`: 主视图，包含标签栏导航
- `RecordsView`: 运动记录列表视图
- `StatisticsView`: 数据统计视图
- `GoalsView`: 目标管理视图
- `AddWorkoutView`: 添加运动记录视图
- `AddGoalView`: 添加运动目标视图
- `WorkoutDetailView`: 运动记录详情视图

### 数据管理
- `WorkoutStore`: 负责数据的存储和管理
- 使用 `@Published` 实现数据响应式更新
- 使用 `Codable` 协议实现数据序列化

## 使用的框架
- SwiftUI
- Charts (用于数据可视化)
- Foundation

## 项目结构 