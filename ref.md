# GOD引擎 项目资源与技术检索目录 (ref.md)

本文档是项目的**全景式速查字典**。无论你想找某个配置文件、查端口号、找图片图集、查脚本位置，还是查数据库表结构，随时在这份目录中秒查！

---

## 1. 核心目录与路径总揽速查

| 路径 | 模块名称 | 核心职责与内容 |
| :--- | :--- | :--- |
| `D:\000GOD\GODserver20261031\` | **服务端生产运行端** | 包含 `Mirserver`（游戏引擎）与 `phpstudy_pro`（微端与数据库） |
| `D:\000GOD\GODclient20261031\` | **PC客户端运行端** | 包含最新可执行程序、CEF组件与游戏全部资源 `assets\` |
| `D:\000GOD\GODcode20261031\` | **最新源码与脚本中心** | 管理纯净服务端脚本、Cocos Studio UI 工程、安卓 JNI 配置、SQL 脚本 |
| `D:\000GOD\GODenv20261031\` | **环境与诊断中心** | 一键端口/配置诊断脚本 `check_env.bat`、编译环境搭建指引 |
| `D:\000GOD\GODbuild20261031\` | **编译产物仓库** | 存放最新编译的 Server、PC Client、Android APK 产物 |
| `D:\000GOD\GODskills20261031\` | **开发技能卡片库** | 归档架设、IP配置、网关防卡死、数据库扩展、Cocos UI 等技能 SOP |
| `D:\000GOD\GODweb20261031\` | **网页系统专区** | 包含热血暗金风格账号注册、密码修改、元宝充值与状态监控 Web 系统 (`index.php`, `api.php`) |
| `D:\000GOD\GODlauncher20261031\` | **登录器专区** | 包含 Windows 原生桌面极速登录器 (`GODLauncher.hta`) 与 Python 源码工程 (`src\`) |
| `D:\000GOD\000GODupdates\` | **版本更新包归档** | 每次按日期建立文件夹（如 `20261031\`），存放差量升级文件与更新日志 |
| `D:\000GOD\教程和资源\` | **视频教程库** | 16 个实战录屏教程（编译、微端、数据表、逆向、UI定做） |

---

## 2. 核心配置文件定位字典

| 目标名称 | 物理路径 | 关键作用与改动频率 |
| :--- | :--- | :--- |
| **客户端网络总入口** | `GODclient20261031\assets\res\config\accountpassword.xml` | 指定微端 `edition.xml` 的 HTTP URL 地址（高频修改） |
| **客户端按键配置** | `GODclient20261031\assets\res\config\buttonConfig.xml` | 快捷键绑定、攻击/走位/施法按键映射 |
| **客户端显示配置** | `GODclient20261031\assets\res\config\uiDisplayConfig.xml` | 字体大小、血条长宽、阴影与平滑移动开关 |
| **微端主索引** | `GODserver20261031\phpstudy_pro\WWW\edition.xml` | 指向版本资源目录与 `ServerList.txt` URL（高频修改） |
| **区服列表文件** | `GODserver20261031\phpstudy_pro\WWW\VER1\ServerList.txt` | 定义各区服的显示名称、网关 IP、8090 端口、7000 端口（高频修改） |
| **微端补丁清单** | `GODserver20261031\phpstudy_pro\WWW\VER1\res.txt` | 记录最新资源哈希与更新包下载列表 |
| **服务端主配置文件** | `GODserver20261031\Mirserver\Config.ini` | 定义服务端根目录、外网 IP、各网关监听端口（高频修改） |
| **服务启停参数** | `GODserver20261031\Mirserver\Setup.ini` | 控制各子网关的默认加载开关与调试窗口坐标 |

---

## 3. 服务端 Envir 与 Script 目录字典

所有游戏逻辑、任务、怪物掉落、NPC 交互均位于 `Mirserver\Mir200\`：

- `Envir\Market_Def\`：**城市商店交易 NPC 脚本**（买卖、修理、特殊锻造）。
- `Envir\Npc_def\`：**功能型与任务型 NPC 脚本**（传送员、转生使者、行会管理员）。
- `Envir\MonItems\`：**怪物爆率文件目录**（每个怪物一个 txt，定义掉落物品与几率）。
- `Envir\QuestDiary\`：**自定义脚本模块库**（活动、副本、排行榜、通区捐献）。
- `Envir\Robot_def\`：**机器人定时触发脚本**（定时攻沙、整点活动广播）。
- `Envir\MapQuest_def\`：**进入/离开地图触发脚本**。
- `script\mon\`：怪物受击、死亡、施法底层 PascalScript。
- `script\skill\`：技能触发与伤害加成底层 PascalScript。

---

## 4. 客户端 WIL / WIX 素材资源字典

客户端素材位于 `GODclient20261031\assets\data\` 与微端目录中：

| 文件前缀 | 素材内容说明 |
| :--- | :--- |
| `DnItems.wil` | 掉落地面的物品掉落模型与拾取发光特效 |
| `Dragon.wil` | 登录界面巨龙背景与开门动画 |
| `Effect.wil` | 技能施法特效（雷电、烈火、火墙、冰咆哮等） |
| `Hair.wil` | 人物发型素材与调色板 |
| `Hum.wil / Hum2.wil` | 人物衣服外观（男、女各职业各套装身体模型） |
| `Mon1.wil ~ Mon112.wil` | 全怪物外观序列帧（站立、行走、攻击、施法、死亡） |
| `Npc.wil / Npc2.wil` | 场景 NPC 模型与待机动作 |
| `Objects.wil ~ Objects16.wil` | 地图静态建筑、树木、房屋、城墙障碍物 |
| `SmTiles.wil / Tiles.wil` | 地表基础瓦片地砖（草地、沙石、地宫石板） |
| `Weapon.wil ~ Weapon3.wil` | 武器外观动画（各职业手持神兵光效） |

---

## 5. 视频教程检索与学习导引表

位于 `D:\000GOD\教程和资源\`：

| 视频文件名 | 核心内容与学习价值 |
| :--- | :--- |
| `GOD引擎视频搭建教程.mp4` | 完整的初次架设、phpStudy 环境部署与双端联调演示 |
| `god服务端源码编译教学.MP4` | Delphi 编译 GameServer、RunGate、DBServer 完整流水线 |
| `god客户端源码分析第一课.mp4` | Cocos2d-x C++ 客户端架构分析与模块讲解 |
| `DecCSB逆向视频.mp4` | 如何将已编译的 `.csb` 逆向回工程结构进行修改 |
| `UI修改教程.avi` / `自定义UI1/2` | Cocos Studio 界面控件拖拽、布局适配与导出实操 |
| `GOD引擎数据表简介.mp4` | 数据库表结构、物品表 `StdItems.DB`、怪物表 `Monster.DB` |
| `技能表简介.mp4` | 技能参数配置、伤害公式、冷却时间调整 |
| `GOD引擎微端教程.mp4` | 微端分包、`res.txt` 生成与 CDN 加速更新配置 |
