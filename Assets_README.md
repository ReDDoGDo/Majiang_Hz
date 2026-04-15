# Unity项目目录结构说明

## 目录结构

本项目采用标准的Unity项目目录结构，具体如下：

```
Assets/
├── Scripts/                    # 脚本代码
│   ├── Core/                  # 核心系统
│   │   ├── Manager/          # 管理器类
│   │   ├── Base/             # 基类
│   │   └── Utils/            # 工具类
│   ├── Game/                  # 游戏逻辑
│   │   ├── Tile/             # 麻将牌系统
│   │   ├── Player/           # 玩家系统
│   │   ├── Rule/             # 规则系统
│   │   ├── Turn/             # 回合系统
│   │   └── AI/               # AI系统
│   ├── UI/                    # UI界面
│   │   ├── Menu/             # 主菜单
│   │   ├── Game/             # 游戏界面
│   │   ├── Settings/         # 设置界面
│   │   └── Result/           # 结算界面
│   ├── Network/               # 网络模块（可选）
│   └── Data/                  # 数据结构
│
├── Prefabs/                   # 预制体
│   ├── Tiles/                # 麻将牌预制体
│   ├── Players/              # 玩家预制体
│   └── UI/                   # UI预制体
│
├── Scenes/                    # 场景文件
│   ├── MainMenu.unity        # 主菜单场景
│   └── Game.unity            # 游戏场景
│
├── Resources/                 # 动态加载资源
│   ├── Tiles/                # 麻将牌资源
│   ├── UI/                   # UI资源
│   ├── Audio/                # 音频资源
│   └── Config/               # 配置文件
│
├── Art/                       # 美术资源
│   ├── Textures/             # 贴图
│   │   ├── Tiles/           # 麻将牌贴图
│   │   ├── Table/           # 牌桌贴图
│   │   └── UI/              # UI贴图
│   └── Materials/            # 材质
│
├── Audio/                     # 音频文件
│   ├── BGM/                  # 背景音乐
│   └── SFX/                  # 音效
│       ├── Tile/            # 麻将牌音效
│       └── UI/              # UI音效
│
└── Plugins/                   # 第三方插件
    ├── DOTween/
    ├── Photon/
    └── Steamworks/
```

## 使用说明

### 创建Unity项目后
1. 将此文件夹重命名为 `Assets`
2. Unity会自动识别并创建必要的元数据文件

### 目录用途说明

#### Scripts（脚本）
- 存放所有C#脚本文件
- 按功能模块分类组织
- 每个模块有独立的命名空间

#### Prefabs（预制体）
- 存放可复用的游戏对象预制体
- 按类型分类存放

#### Scenes（场景）
- 存放Unity场景文件
- 主菜单场景和游戏场景分离

#### Resources（资源）
- 存放需要动态加载的资源
- 使用Resources.Load加载
- 注意内存管理

#### Art（美术）
- 存放美术资源
- 包括贴图、材质等
- 按类型分类组织

#### Audio（音频）
- 存放音频文件
- 背景音乐和音效分离
- 支持多种音频格式

#### Plugins（插件）
- 存放第三方插件
- 包括DOTween、Photon、Steamworks等

## 注意事项

1. **命名规范**
   - 文件夹名使用PascalCase
   - 资源文件使用下划线分隔（如：Tile_Wan_1）

2. **版本控制**
   - 忽略Library、Temp、Logs等临时文件夹
   - 提交Assets、ProjectSettings、Packages等核心文件夹

3. **资源管理**
   - 合理使用Resources文件夹
   - 大资源考虑使用Addressables
   - 及时释放不用的资源

4. **性能优化**
   - 使用Sprite Atlas合并图集
   - 合理使用对象池
   - 避免频繁的Resources.Load

---

**注意**: 此目录结构将在创建Unity项目后正式使用。
