<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GOD寮曟搸 璐﹀彿娉ㄥ唽涓庢父鎴忕鐞嗕腑蹇?/title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="ambient-glow"></div>

    <div class="container">
        <!-- 澶撮儴鏍囬 -->
        <header class="header">
            <h1>GOD 寮曟搸 路 鐑閫氳璇?/h1>
            <p>浼犲璺ㄧ缃戠粶鏈嶅姟鎺у埗涓績 & 涓撶敤璐﹀彿绠＄悊骞冲彴</p>
        </header>

        <!-- 鏈嶅姟鍣ㄧ姸鎬佺洃鎺ф潯 -->
        <section class="status-bar" aria-label="鏈嶅姟鍣ㄧ姸鎬?>
            <div class="status-item" id="status-web">
                <span class="status-dot" id="dot-web"></span>
                <span>Web 寰 (88): <strong id="dot-web-text">妫€娴嬩腑...</strong></span>
            </div>
            <div class="status-item" id="status-mysql">
                <span class="status-dot" id="dot-mysql"></span>
                <span>MySQL (3306): <strong id="dot-mysql-text">妫€娴嬩腑...</strong></span>
            </div>
            <div class="status-item" id="status-login">
                <span class="status-dot" id="dot-login"></span>
                <span>閫夊尯缃戝叧 (8090): <strong id="dot-login-text">妫€娴嬩腑...</strong></span>
            </div>
            <div class="status-item" id="status-run">
                <span class="status-dot" id="dot-run"></span>
                <span>娓告垙缃戝叧 (7200): <strong id="dot-run-text">妫€娴嬩腑...</strong></span>
            </div>
        </section>

        <!-- 瀵艰埅閫夐」鍗?-->
        <nav class="tabs">
            <button class="tab-btn active" data-tab="tab-register" id="tab-btn-register">鍒涘缓鏂拌处鍙?/button>
            <button class="tab-btn" data-tab="tab-password" id="tab-btn-password">淇敼瀵嗙爜</button>
            <button class="tab-btn" data-tab="tab-accounts" id="tab-btn-accounts">璐﹀彿绠＄悊涓庡厖鍊?/button>
            <button class="tab-btn" data-tab="tab-guide" id="tab-btn-guide">娓告垙鍚姩鎸囧崡</button>
        </nav>

        <!-- 鍗＄墖 1: 璐﹀彿娉ㄥ唽 -->
        <main>
            <section class="card active" id="tab-register">
                <h2 class="card-title">鉁?蹇€熸敞鍐屾柊璐﹀彿</h2>
                <form id="form-register">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="reg-username">鐧诲綍璐﹀彿 (鑻辨枃/鏁板瓧 3~20浣?</label>
                            <input type="text" id="reg-username" name="username" placeholder="璇疯緭鍏ユ偍鐨勬父鎴忚处鍙? required autofocus>
                        </div>
                        <div class="form-group">
                            <label for="reg-password">鐧诲綍瀵嗙爜 (6~20浣?</label>
                            <input type="password" id="reg-password" name="password" placeholder="璇疯緭鍏ュ瘑鐮? required>
                        </div>
                        <div class="form-group">
                            <label for="reg-repass">纭瀵嗙爜</label>
                            <input type="password" id="reg-repass" name="repass" placeholder="璇峰啀娆¤緭鍏ュ瘑鐮? required>
                        </div>
                        <div class="form-group">
                            <label for="reg-seccode">浜岀骇瀹夊叏淇濇姢鐮?(鎵惧洖瀵嗙爜涓撶敤)</label>
                            <input type="text" id="reg-seccode" name="seccode" value="123456" placeholder="濡?123456" required>
                        </div>
                        <div class="form-group">
                            <label for="reg-initgold">鍒濆璧犻€佸厓瀹?/label>
                            <input type="number" id="reg-initgold" name="initgold" value="50000" min="0" step="1000">
                        </div>
                        <div class="form-group" style="justify-content: flex-end;">
                            <label class="checkbox-group">
                                <input type="checkbox" id="reg-isgm" name="isgm" value="1">
                                <span>璁剧疆涓?GM 绠＄悊鍛樿处鍙?(浜湁鏈€楂樿皟璇曟潈闄?</span>
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn-primary" id="btn-submit-register">绔嬪嵆娉ㄥ唽娓告垙璐﹀彿</button>
                    <div class="alert-box" id="alert-register"></div>
                </form>
            </section>

            <!-- 鍗＄墖 2: 瀵嗙爜淇敼 -->
            <section class="card" id="tab-password">
                <h2 class="card-title">鉁?淇敼璐﹀彿瀵嗙爜</h2>
                <form id="form-password">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="pwd-username">鐩爣娓告垙璐﹀彿</label>
                            <input type="text" id="pwd-username" name="username" placeholder="璇疯緭鍏ヨ鏀瑰瘑鐨勮处鍙? required>
                        </div>
                        <div class="form-group">
                            <label for="pwd-oldpass">鍘熷瘑鐮?(鎴栧～鍐欎笅鏂逛簩绾у畨鍏ㄧ爜)</label>
                            <input type="password" id="pwd-oldpass" name="oldpass" placeholder="鍘熷瘑鐮?>
                        </div>
                        <div class="form-group">
                            <label for="pwd-seccode">浜岀骇瀹夊叏鐮?(鑻ュ繕璁板師瀵嗙爜鍙敤姝ら」)</label>
                            <input type="text" id="pwd-seccode" name="seccode" placeholder="娉ㄥ唽鏃惰缃殑瀹夊叏鐮?>
                        </div>
                        <div class="form-group">
                            <label for="pwd-newpass">璁惧畾鏂板瘑鐮?/label>
                            <input type="password" id="pwd-newpass" name="newpass" placeholder="璇疯緭鍏ユ柊瀵嗙爜" required>
                        </div>
                    </div>
                    <button type="submit" class="btn-primary" id="btn-submit-pwd">纭鏇存柊瀵嗙爜</button>
                    <div class="alert-box" id="alert-password"></div>
                </form>
            </section>

            <!-- 鍗＄墖 3: 璐﹀彿鍒楄〃涓庣鐞?-->
            <section class="card" id="tab-accounts">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
                    <h2 class="card-title" style="margin-bottom:0;">鉁?璐﹀彿鍒楄〃涓庡厖鍊肩鐞?/h2>
                    <button class="btn-action" onclick="loadAccountList()" style="padding:6px 14px;">鍒锋柊鍒楄〃</button>
                </div>
                <p style="color:#888; font-size:0.85rem; margin-bottom:14px;">鏄剧ず鏈€杩戞敞鍐岀殑璐﹀彿銆傜偣鍑绘搷浣滃彲鐩存帴涓鸿璐﹀彿鍏呭€煎厓瀹濇垨鍒囨崲灏佸仠鐘舵€併€?/p>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>UID</th>
                                <th>娓告垙璐﹀彿</th>
                                <th>瑙掕壊绾у埆</th>
                                <th>鍏冨疂浣欓</th>
                                <th>娉ㄥ唽鏃堕棿</th>
                                <th>鐘舵€?/th>
                                <th>绠＄悊鎿嶄綔</th>
                            </tr>
                        </thead>
                        <tbody id="accounts-tbody">
                            <tr><td colspan="7" style="text-align:center;color:#666;">姝ｅ湪鍔犺浇璐﹀彿鏁版嵁...</td></tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- 鍗＄墖 4: 鍚姩鎸囧崡 -->
            <section class="card" id="tab-guide">
                <h2 class="card-title">鉁?娓告垙鍚姩涓庤仈璋冩寚寮?/h2>
                <div style="line-height:1.8; color:#ccc; font-size:0.95rem;">
                    <p><strong>绗竴姝ワ細鍚姩鏈嶅姟绔?/strong></p>
                    <p style="color:#aaa; margin-left:16px;">鍙屽嚮鏍圭洰褰曚笅鐨?<code style="color:#ffd700;">start_server.bat</code>锛岀▼搴忎細鑷姩鎷夎捣 Web銆丮ySQL 鏁版嵁搴撳苟鎵撳紑 GameCenter銆傜偣鍑?GameCenter 绐楀彛涓殑銆愬惎鍔ㄦ父鎴忔湇鍔″櫒銆戞寜閽紝绛夊緟 5~10 绉掋€?/p>

                    <p style="margin-top:12px;"><strong>绗簩姝ワ細娉ㄥ唽璐﹀彿</strong></p>
                    <p style="color:#aaa; margin-left:16px;">鍦ㄦ湰椤甸潰鐩存帴杈撳叆鎮ㄥ枩娆㈢殑璐﹀彿瀵嗙爜杩涜娉ㄥ唽锛屾敞鍐屾垚鍔熷悗璐﹀彿宸插疄鏃跺瓨鍏ユ湰鍦版暟鎹簱銆?/p>

                    <p style="margin-top:12px;"><strong>绗笁姝ワ細鍚姩瀹㈡埛绔?/strong></p>
                    <p style="color:#aaa; margin-left:16px;">鍙屽嚮鏍圭洰褰曚笅鐨?<code style="color:#ffd700;">start_client.bat</code>锛屽嵆鍙寮€ 2025-01-05 鏈€鏂?PC 瀹㈡埛绔紝杈撳叆鍒氭敞鍐岀殑璐﹀彿瀵嗙爜鍗冲彲灏芥儏娓哥帺锛?/p>
                </div>
            </section>
        </main>

        <footer class="footer">
            <p>GOD ENGINE 路 MIR2 MMORPG ARCHITECTURE 漏 2026</p>
        </footer>
    </div>

    <script src="app.js"></script>
</body>
</html>

