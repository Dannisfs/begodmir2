# GOD引擎 专属登录器与PC游戏视窗控制器 (GODlauncher20261031)

本目录归档 GOD 传奇引擎专属登录器与游戏视窗控制器的**完整源码**、**编译后的独立运行端**与**开发指南**。

---

## 一、核心组件架构

```
D:\000GOD\GODlauncher20261031\
├── GOD_Launcher.exe     # [推荐运行] 原生编译 Win32/C# 登录器与视窗控制器 (集成拉伸/最大化/分辨率控制)
├── GODLauncher.hta      # Windows 原生 HTA 轻量免环境登录器
├── launcher_config.ini  # 自动保存的视窗偏好设置 (分辨率、拉伸、全屏、居中等)
├── src\
│   ├── GODLauncher.cs   # [核心源码] C# 视窗控制器与登录器完整源码 (Win32 API Hook)
│   └── launcher.py      # [脚本源码] Python Tkinter GUI 登录器源码
└── README_LAUNCHER.md   # 本说明文档
```

项目根目录快捷入口：
- `D:\000GOD\start_launcher.bat`（一键唤醒原生视窗控制登录器）

---

## 二、PC 客户端视窗与分辨率控制功能（满足自由拖拽拉伸与放大）

原生游戏客户端默认窗口大小固定，无法拖拽边框且无最大化按钮。本项目通过 Win32 API 动态挂钩（Hook）实现了：

1. **自由拖动拉伸边框 (`WS_THICKFRAME = 0x00040000`)**：
   - 鼠标悬停在游戏视窗四周任意边框或四个角，光标变为缩放双向箭头，可任意拖拽放大或缩小画面！
2. **激活右上角【最大化/放大】按钮 (`WS_MAXIMIZEBOX = 0x00010000`)**：
   - 标题栏原有置灰或缺失的最大化按钮被点亮，点击即可一键全屏铺满显示器。
3. **分辨率预设与自由调节**：
   - `800 x 600`（复古原版 4:3）
   - `1024 x 768`（经典标清 4:3）
   - `1280 x 720`（720P 高清宽屏 推荐）
   - `1366 x 768`（笔记本常用宽屏）
   - `1600 x 900`（900P 超清宽屏）
   - `1920 x 1080`（1080P 全高清 最佳效果）
   - `2560 x 1440`（2K 极清大屏）
   - **自定义分辨率**：自由输入任意宽度与高度。
4. **视窗扩展功能**：
   - 启动自动屏幕居中
   - 视窗置顶显示（防止多开切屏被遮挡）
   - 一键全屏 / 窗口化无缝切换
   - 实时应用：游戏已在运行时，可随时在登录器点击【立即应用视窗设置到已打开的游戏】！

---

## 三、服务端状态雷达与极速注册

1. **实时端口健康探测**：
   - Web 微端与版本列表（Port 88）
   - MySQL 账号数据库（Port 3306）
   - 核心游戏引擎服（Port 5000）
   - 游戏入口网关（Port 8090）
2. **极速注册账号**：
   - 登录器内置账号密码注册，直接与本地 Web API（`http://127.0.0.1:88/web/api.php`）通信写入数据库，注册即可登入。
3. **网页管理后台**：
   - 点击【打开网页系统】直接调起浏览器访问 `http://127.0.0.1:88/web/` 进行充值和账号管理。

---

## 四、源码二次编译指南

### 1. 编译 C# 原生登录器 (`src\GODLauncher.cs`)
使用 Windows 自带的 .NET 编译器即可编译，无需安装任何额外 IDE：
```cmd
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe /target:winexe /out:"D:\000GOD\GODlauncher20261031\GOD_Launcher.exe" "D:\000GOD\GODlauncher20261031\src\GODLauncher.cs"
```

### 2. 打包 Python 登录器 (`src\launcher.py`)
```bash
pip install pyinstaller
cd D:\000GOD\GODlauncher20261031\src
pyinstaller -F -w launcher.py -n "GOD极速登录器"
```
