# SKILL-06: God 引擎双端源码二次编译全流程说明

## 技能定位
指引开发者完成 Delphi 服务端核心与 Cocos2d-x C++ 客户端的编译、重构与发布。

---

## 一、服务端源码架构与编译环境

1. **开发语言与编译器**：
   - Delphi XE10 / 10.4 Sydney（或 11 Alexandria）。
   - 依赖的运行时库：VCL, Indyi, FastMM4, PascalScript, MySQL Direct Access Component (DAC) / UniDAC。
2. **核心项目工程**：
   - `GameServer.dpr`：游戏核心主程。
   - `RunGate.dpr`：运行网关主程。
   - `DBServer.dpr`：角色数据引擎。
   - `GameCenter.dpr`：总控启动台。
3. **编译参数建议**：
   - Release 模式，启用 Optimization（优化）。
   - 开启 RSM 调试符号生成（生成 `.rsm` 文件，便于生产环境崩溃追踪）。
   - 输出路径指定为 `D:\000GOD\GODbuild20261031\server\`。

---

## 二、PC 客户端源码架构与编译环境

1. **开发语言与编译器**：
   - Visual Studio 2022（本机 `D:\softs\vs2022` 已具备 MSVC v143 编译器）。
   - Cocos2d-x 3.x 核心（C++11/C++14 标准）。
   - 第三方依赖库：FMOD 音频引擎、YouMe 语音引擎、CEF（Chromium Embedded Framework 内嵌微端网页组件）、libcurl、OpenSSL、iconv。
2. **核心代码树**：
   - `Classes\AppDelegate.cpp`：客户端生命周期入口、分辨率适配、全局初始化。
   - `Classes\actor\Actor.cpp`：角色/怪物实体渲染、动作序列、物理朝向与状态机。
   - `Classes\scenes\GameScene.cpp`：游戏主场景渲染循环与视口跟随。
   - `Classes\map\TMap.cpp`：传奇经典 `.map` 地图瓦片解析与动态遮挡剔除。
   - `Classes\net\`：与 RunGate / LoginGate 通信的 TCP 客户端包解密与封包。
3. **输出目标**：
   - `cocos2dMir2R.bin` 或 `cocos2dMir2R20250105.exe`，输出到 `D:\000GOD\GODbuild20261031\client_pc\`。

---

## 三、安卓端 NDK 编译要点

- 工程入口：`D:\000GOD\GODcode20261031\client_jni\Android.mk`
- 架构支持：`armeabi-v7a`, `arm64-v8a`（64位支持）。
- 执行命令：`ndk-build -j8`，产出 `libcocos2dcpp.so`。
