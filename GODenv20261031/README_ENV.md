# GOD引擎 开发与编译运行环境总览 (GODenv20261031)

本文档归档项目运行、编译与调试所需的环境栈、工具配置与路径指引。

---

## 一、项目技术栈总览

| 模块 | 开发语言 / 引擎框架 | 编译工具 / 运行环境 | 主要产物 / 文件 |
| :--- | :--- | :--- | :--- |
| **服务端核心 (M2/GS)** | Delphi / Object Pascal / C++ | Embarcadero RAD Studio (Delphi XE/10) | `GameServer.exe`, `RunGate.exe`, `DBServer.exe`, `GameCenter.exe` |
| **服务端脚本** | PascalScript / Custom Script | 文本编辑器 / Notepad++ / VS Code | `Mir200\script\*.pas`, `Mir200\Envir\*.txt` |
| **微端与更新列表** | HTTP Web Server + XML + TXT | phpStudy (Apache 端口88 + MySQL 5.7/8.0) | `edition.xml`, `ServerList.txt`, `res.txt`, `client\` |
| **PC客户端核心** | C++ (Cocos2d-x 3.x), Lua, CEF | Visual Studio 2022 (`D:\softs\vs2022`) | `cocos2dMir2R20250105.exe`, `cocos2dMir2R.bin`, `*.dll` |
| **客户端UI** | Cocos Studio 3.10 | Cocos Studio (`cocos2dMir2.ccs`) | `assets\res\ui\*.csb` (二进制UI资源) |
| **安卓客户端** | C++ (NDK), Java (Android SDK) | Eclipse CDT / Android Studio + NDK r10e/r16 | `cocos2dMir2-20250105.apk`, `libcocos2dcpp.so` |
| **多媒体分析工具** | FFmpeg 9.0.2, 7-Zip | 系统已部署 Gyan.FFmpeg + 7-Zip | 视频教程关键帧提取、音频解说转文字 |

---

## 二、当前本机已就绪的环境组件

1. **Visual Studio 2022**：
   - 安装路径：`D:\softs\vs2022`
   - 支持 C++ 桌面开发、MSVC v143 编译器、Windows 10/11 SDK (`10.0.26100.0`)。
2. **FFmpeg 9.0.2**：
   - 已安装并加入系统环境变量，可在终端直接执行 `ffmpeg`, `ffprobe`。
3. **7-Zip 26.05**：
   - 路径：`C:\Program Files\7-Zip\7z.exe`，支持 ZIP, RAR, 7Z, TAR 高速解压与打包。
4. **Git 版本控制**：
   - 路径：`D:\softs\Git\cmd\git.exe`。
5. **phpStudy 集成环境**：
   - 路径：`D:\000GOD\GODserver20261031\phpstudy_pro`
   - 提供 Apache HTTP Web 伺服服务（用于微端资源下载与 `edition.xml` 列表）和 MySQL 数据库。

---

## 三、网络端口与服务规划

在启动前请确保以下端口未被其他服务占用：

| 端口号 | 服务名称 | 进程/协议 | 作用说明 |
| :--- | :--- | :--- | :--- |
| **88** | Web更新服务 | Apache / Nginx (HTTP) | 提供 `edition.xml`, `ServerList.txt` 和微端补丁下载 |
| **3306** | 游戏数据库 | MySQL / MariaDB | 存储账号、角色 (`character`)、物品及排行榜数据 |
| **5000** | M2网关通讯 | M2Server (TCP) | GameServer 内部通讯接口 |
| **5100** | DB网关通讯 | DBServer (TCP) | 角色数据存取内部通讯接口 |
| **6000** | DB服务端端口 | DBServer (TCP) | 账号登录认证通讯 |
| **7000** | 游戏运行网关端口 | RunGate (TCP) | 客户端连接游戏的主要游戏网关端口 (ServerList 指定) |
| **7200** | 内部游戏数据通道 | GameServer <-> RunGate | 网关与游戏引擎之间的内部数据通信端口 |
| **8090** | 登录/选择角色端口 | LoginGate / SelGate (TCP) | 客户端连接登录、选区选角网关端口 (ServerList 指定) |

---

## 四、一键环境诊断工具

位于当前目录下的 `check_env.bat`，双击可自动检测：
- 端口占用情况（88, 3306, 7000, 8090 等）
- 关键编译与解压工具就绪状态
- 配置文件中的 IP 是否匹配本机地址
