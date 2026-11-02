<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GOD引擎 账号注册与游戏管理中心</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="ambient-glow"></div>

    <div class="container">
        <!-- 头部标题 -->
        <header class="header">
            <h1>GOD 引擎 · 热血通行证</h1>
            <p>传奇跨端网络服务控制中心 & 专用账号管理平台</p>
        </header>

        <!-- 服务器状态监控条 -->
        <section class="status-bar" aria-label="服务器状态">
            <div class="status-item" id="status-web">
                <span class="status-dot" id="dot-web"></span>
                <span>Web 微端 (88): <strong id="dot-web-text">检测中...</strong></span>
            </div>
            <div class="status-item" id="status-mysql">
                <span class="status-dot" id="dot-mysql"></span>
                <span>MySQL (3306): <strong id="dot-mysql-text">检测中...</strong></span>
            </div>
            <div class="status-item" id="status-login">
                <span class="status-dot" id="dot-login"></span>
                <span>选区网关 (8090): <strong id="dot-login-text">检测中...</strong></span>
            </div>
            <div class="status-item" id="status-run">
                <span class="status-dot" id="dot-run"></span>
                <span>游戏网关 (7000): <strong id="dot-run-text">检测中...</strong></span>
            </div>
        </section>

        <!-- 导航选项卡 -->
        <nav class="tabs">
            <button class="tab-btn active" data-tab="tab-register" id="tab-btn-register">创建新账号</button>
            <button class="tab-btn" data-tab="tab-password" id="tab-btn-password">修改密码</button>
            <button class="tab-btn" data-tab="tab-accounts" id="tab-btn-accounts">账号管理与充值</button>
            <button class="tab-btn" data-tab="tab-guide" id="tab-btn-guide">游戏启动指南</button>
        </nav>

        <!-- 卡片 1: 账号注册 -->
        <main>
            <section class="card active" id="tab-register">
                <h2 class="card-title">✦ 快速注册新账号</h2>
                <form id="form-register">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="reg-username">登录账号 (英文/数字 3~20位)</label>
                            <input type="text" id="reg-username" name="username" placeholder="请输入您的游戏账号" required autofocus>
                        </div>
                        <div class="form-group">
                            <label for="reg-password">登录密码 (6~20位)</label>
                            <input type="password" id="reg-password" name="password" placeholder="请输入密码" required>
                        </div>
                        <div class="form-group">
                            <label for="reg-repass">确认密码</label>
                            <input type="password" id="reg-repass" name="repass" placeholder="请再次输入密码" required>
                        </div>
                        <div class="form-group">
                            <label for="reg-seccode">二级安全保护码 (找回密码专用)</label>
                            <input type="text" id="reg-seccode" name="seccode" value="123456" placeholder="如 123456" required>
                        </div>
                        <div class="form-group">
                            <label for="reg-initgold">初始赠送元宝</label>
                            <input type="number" id="reg-initgold" name="initgold" value="50000" min="0" step="1000">
                        </div>
                        <div class="form-group" style="justify-content: flex-end;">
                            <label class="checkbox-group">
                                <input type="checkbox" id="reg-isgm" name="isgm" value="1">
                                <span>设置为 GM 管理员账号 (享有最高调试权限)</span>
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn-primary" id="btn-submit-register">立即注册游戏账号</button>
                    <div class="alert-box" id="alert-register"></div>
                </form>
            </section>

            <!-- 卡片 2: 密码修改 -->
            <section class="card" id="tab-password">
                <h2 class="card-title">✦ 修改账号密码</h2>
                <form id="form-password">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="pwd-username">目标游戏账号</label>
                            <input type="text" id="pwd-username" name="username" placeholder="请输入要改密的账号" required>
                        </div>
                        <div class="form-group">
                            <label for="pwd-oldpass">原密码 (或填写下方二级安全码)</label>
                            <input type="password" id="pwd-oldpass" name="oldpass" placeholder="原密码">
                        </div>
                        <div class="form-group">
                            <label for="pwd-seccode">二级安全码 (若忘记原密码可用此项)</label>
                            <input type="text" id="pwd-seccode" name="seccode" placeholder="注册时设置的安全码">
                        </div>
                        <div class="form-group">
                            <label for="pwd-newpass">设定新密码</label>
                            <input type="password" id="pwd-newpass" name="newpass" placeholder="请输入新密码" required>
                        </div>
                    </div>
                    <button type="submit" class="btn-primary" id="btn-submit-pwd">确认更新密码</button>
                    <div class="alert-box" id="alert-password"></div>
                </form>
            </section>

            <!-- 卡片 3: 账号列表与管理 -->
            <section class="card" id="tab-accounts">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
                    <h2 class="card-title" style="margin-bottom:0;">✦ 账号列表与充值管理</h2>
                    <button class="btn-action" onclick="loadAccountList()" style="padding:6px 14px;">刷新列表</button>
                </div>
                <p style="color:#888; font-size:0.85rem; margin-bottom:14px;">显示最近注册的账号。点击操作可直接为该账号充值元宝或切换封停状态。</p>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>UID</th>
                                <th>游戏账号</th>
                                <th>角色级别</th>
                                <th>元宝余额</th>
                                <th>注册时间</th>
                                <th>状态</th>
                                <th>管理操作</th>
                            </tr>
                        </thead>
                        <tbody id="accounts-tbody">
                            <tr><td colspan="7" style="text-align:center;color:#666;">正在加载账号数据...</td></tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- 卡片 4: 启动指南 -->
            <section class="card" id="tab-guide">
                <h2 class="card-title">✦ 游戏启动与联调指引</h2>
                <div style="line-height:1.8; color:#ccc; font-size:0.95rem;">
                    <p><strong>第一步：启动服务端</strong></p>
                    <p style="color:#aaa; margin-left:16px;">双击根目录下的 <code style="color:#ffd700;">start_server.bat</code>，程序会自动拉起 Web、MySQL 数据库并打开 GameCenter。点击 GameCenter 窗口中的【启动游戏服务器】按钮，等待 5~10 秒。</p>

                    <p style="margin-top:12px;"><strong>第二步：注册账号</strong></p>
                    <p style="color:#aaa; margin-left:16px;">在本页面直接输入您喜欢的账号密码进行注册，注册成功后账号已实时存入本地数据库。</p>

                    <p style="margin-top:12px;"><strong>第三步：启动客户端</strong></p>
                    <p style="color:#aaa; margin-left:16px;">双击根目录下的 <code style="color:#ffd700;">start_client.bat</code>，即可秒开 2025-01-05 最新 PC 客户端，输入刚注册的账号密码即可尽情游玩！</p>
                </div>
            </section>
        </main>

        <footer class="footer">
            <p>GOD ENGINE · MIR2 MMORPG ARCHITECTURE © 2026</p>
        </footer>
    </div>

    <script src="app.js"></script>
</body>
</html>
