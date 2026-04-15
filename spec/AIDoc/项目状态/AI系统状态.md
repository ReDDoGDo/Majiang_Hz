# AI系统状态

## 模块概述

AI系统负责游戏中AI玩家的决策逻辑，包括出牌策略、碰杠决策、胡牌判断等，提供有挑战性的单机游戏体验。

## 当前状态

**状态**: 未开始  
**完成度**: 0%  
**优先级**: P0  
**负责人**: 待定  
**开始日期**: -  
**预计完成**: 2026-06-26  

## 子模块状态

### 1. AI基础框架
- **状态**: 未开始
- **完成度**: 0%
- **优先级**: P0
- **任务列表**:
  - [ ] 创建AIPlayer类
  - [ ] 实现AI状态机
  - [ ] 实现AI决策系统架构
  - [ ] 创建AI配置文件
  - [ ] 实现难度分级

**技术要点**:
- AI继承自Player基类
- 状态机管理AI行为
- 决策系统基于权重评估
- 配置文件控制AI参数

### 2. AI出牌策略
- **状态**: 未开始
- **完成度**: 0%
- **优先级**: P0
- **任务列表**:
  - [ ] 实现基础出牌策略（随机）
  - [ ] 实现进阶出牌策略（牌价值评估）
  - [ ] 实现高级出牌策略（考虑对手手牌）
  - [ ] 实现听牌判断
  - [ ] 实现难度分级策略

**策略分级**:
- **简单**: 随机出牌
- **普通**: 评估牌价值，保留有用牌
- **困难**: 综合考虑手牌、对手、听牌等

### 3. AI碰杠决策
- **状态**: 未开始
- **完成度**: 0%
- **优先级**: P0
- **任务列表**:
  - [ ] 实现碰牌决策逻辑
  - [ ] 实现杠牌决策逻辑
  - [ ] 实现杠牌时机判断
  - [ ] 优化决策权重

**决策因素**:
- 手牌组合情况
- 碰杠后对牌型的影响
- 是否影响听牌
- 风险评估

### 4. AI胡牌判断
- **状态**: 未开始
- **完成度**: 0%
- **优先级**: P0
- **任务列表**:
  - [ ] 实现AI听牌判断
  - [ ] 实现AI胡牌决策
  - [ ] 实现AI点炮避免策略
  - [ ] 测试AI合理性

**判断逻辑**:
- 实时检测是否听牌
- 判断是否应该胡牌
- 避免点炮策略

## AI策略设计

### 牌价值评估系统

#### 评估维度
1. **单牌价值**
   - 孤张牌：低价值
   - 对子：中等价值
   - 刻子：高价值

2. **组合价值**
   - 顺子潜力：评估是否能组成顺子
   - 刻子潜力：评估是否能组成刻子
   - 对子潜力：评估是否能组成对子

3. **听牌价值**
   - 是否听牌
   - 听牌数量
   - 听牌番数

4. **风险价值**
   - 点炮风险
   - 被碰杠风险

#### 权重计算
```csharp
public float CalculateTileValue(Tile tile, List<Tile> handTiles)
{
    float value = 0;
    
    // 基础价值
    value += GetBaseValue(tile);
    
    // 组合价值
    value += GetCombinationValue(tile, handTiles);
    
    // 听牌价值
    value += GetListeningValue(tile, handTiles);
    
    // 风险价值
    value -= GetRiskValue(tile, handTiles);
    
    return value;
}
```

### 决策系统

#### 出牌决策
1. 评估每张牌的价值
2. 选择价值最低的牌打出
3. 考虑听牌优先
4. 考虑避免点炮

#### 碰杠决策
1. 评估碰杠后的牌型变化
2. 计算番数变化
3. 评估风险
4. 做出决策

#### 胡牌决策
1. 检测是否可以胡牌
2. 评估胡牌番数
3. 考虑自摸还是点炮
4. 做出决策

## 难度分级

### 简单AI
- **出牌策略**: 随机出牌
- **碰杠决策**: 简单规则（有碰就碰）
- **胡牌判断**: 基础判断
- **思考时间**: 0.5-1秒

### 普通AI
- **出牌策略**: 牌价值评估
- **碰杠决策**: 考虑牌型影响
- **胡牌判断**: 听牌判断
- **思考时间**: 1-1.5秒

### 困难AI
- **出牌策略**: 综合策略（考虑对手）
- **碰杠决策**: 风险评估
- **胡牌判断**: 点炮避免
- **思考时间**: 1.5-2秒

## 数据结构

### AIConfig（AI配置）
```csharp
[CreateAssetMenu(fileName = "AIConfig", menuName = "Config/AI")]
public class AIConfig : ScriptableObject
{
    public AIDifficulty Difficulty;
    public float ThinkTime;
    public float BaseValueWeight;
    public float CombinationValueWeight;
    public float ListeningValueWeight;
    public float RiskValueWeight;
}
```

### AIDecision（AI决策）
```csharp
public class AIDecision
{
    public AIDecisionType Type { get; set; }
    public Tile TargetTile { get; set; }
    public float Confidence { get; set; }
}

public enum AIDecisionType
{
    Pass,
    Draw,
    Discard,
    Peng,
    Gang,
    Hu
}
```

## 依赖关系

```
AIPlayer (依赖)
    ├── PlayerSystem
    ├── RuleSystem
    ├── TurnSystem
    └── AIConfig

AIDecision (依赖)
    ├── TileSystem
    └── RuleSystem

AIStrategy (依赖)
    ├── AIPlayer
    ├── AIDecision
    └── AIConfig
```

## 测试要点

### 单元测试
- [ ] 牌价值评估测试
- [ ] 出牌策略测试
- [ ] 碰杠决策测试
- [ ] 胡牌判断测试
- [ ] 难度分级测试

### 集成测试
- [ ] AI完整游戏流程测试
- [ ] AI与玩家对战测试
- [ ] AI合理性测试

### 性能测试
- [ ] AI思考时间测试
- [ ] AI决策正确率测试

## 性能指标

- AI思考时间: < 2秒
- AI决策正确率: > 80%
- AI胜率平衡: 20%-30%（困难难度）

## 已知问题

- 暂无

## 待优化项

- [ ] AI策略优化
- [ ] AI学习机制（可选）
- [ ] AI个性化（可选）
- [ ] AI统计数据分析

## 开发日志

### 2026-04-03
- 创建AI系统状态文档
- 规划AI模块划分
- 确定AI策略设计

## 备注

- AI系统是单机游戏的核心，需提供有挑战性的体验
- AI策略要合理，不能太强也不能太弱
- 难度分级要明显，满足不同玩家需求
- AI思考时间要合理，不能太长影响体验
