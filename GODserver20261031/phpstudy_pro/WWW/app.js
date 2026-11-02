/**
 * GOD引擎 网页管理中心交互脚本
 */

document.addEventListener('DOMContentLoaded', () => {
    initTabs();
    initServerStatus();
    initForms();
    loadAccountList();

    // 每 6 秒轮询一次服务器端口状态
    setInterval(initServerStatus, 6000);
});

// 1. Tab 切换
function initTabs() {
    const tabBtns = document.querySelectorAll('.tab-btn');
    const cards = document.querySelectorAll('.card');

    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const targetId = btn.getAttribute('data-tab');
            tabBtns.forEach(b => b.classList.remove('active'));
            cards.forEach(c => c.classList.remove('active'));

            btn.classList.add('active');
            const targetCard = document.getElementById(targetId);
            if (targetCard) {
                targetCard.classList.add('active');
            }

            if (targetId === 'tab-accounts') {
                loadAccountList();
            }
        });
    });
}

// 2. 获取服务器健康状态
function initServerStatus() {
    fetch('api.php?action=server_status')
        .then(res => res.json())
        .then(res => {
            if (res.code === 200 && res.data) {
                updateDot('dot-web', res.data.web.status);
                updateDot('dot-mysql', res.data.mysql.status);
                updateDot('dot-login', res.data.logingate.status);
                updateDot('dot-run', res.data.rungate.status);
            }
        })
        .catch(() => {
            updateDot('dot-web', false);
            updateDot('dot-mysql', false);
            updateDot('dot-login', false);
            updateDot('dot-run', false);
        });
}

function updateDot(id, isOnline) {
    const el = document.getElementById(id);
    if (!el) return;
    el.className = 'status-dot ' + (isOnline ? 'online' : 'offline');
    const textEl = document.getElementById(id + '-text');
    if (textEl) {
        textEl.textContent = isOnline ? '在线正常' : '未启动';
        textEl.style.color = isOnline ? '#2ecc71' : '#e74c3c';
    }
}

// 3. 表单事件处理
function initForms() {
    // 注册表单
    const regForm = document.getElementById('form-register');
    if (regForm) {
        regForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const formData = new FormData(regForm);
            showAlert('alert-register', '正在处理注册请求...', 'info');

            fetch('api.php?action=register', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(res => {
                if (res.code === 200) {
                    showAlert('alert-register', res.msg, 'success');
                    regForm.reset();
                    loadAccountList();
                } else {
                    showAlert('alert-register', res.msg, 'error');
                }
            })
            .catch(err => {
                showAlert('alert-register', '网络连接失败，请检查 Web 与 MySQL 服务！', 'error');
            });
        });
    }

    // 改密表单
    const pwdForm = document.getElementById('form-password');
    if (pwdForm) {
        pwdForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const formData = new FormData(pwdForm);
            showAlert('alert-password', '正在提交改密请求...', 'info');

            fetch('api.php?action=change_pwd', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(res => {
                if (res.code === 200) {
                    showAlert('alert-password', res.msg, 'success');
                    pwdForm.reset();
                } else {
                    showAlert('alert-password', res.msg, 'error');
                }
            })
            .catch(() => {
                showAlert('alert-password', '网络异常，修改密码失败！', 'error');
            });
        });
    }
}

// 4. 显示通知框
function showAlert(elementId, text, type) {
    const alertBox = document.getElementById(elementId);
    if (!alertBox) return;
    alertBox.textContent = text;
    alertBox.className = 'alert-box ' + type;
    alertBox.style.display = 'block';
}

// 5. 加载已有账号列表
function loadAccountList() {
    const tbody = document.getElementById('accounts-tbody');
    if (!tbody) return;

    fetch('api.php?action=list_accounts')
        .then(res => res.json())
        .then(res => {
            if (res.code === 200 && res.data) {
                tbody.innerHTML = '';
                if (res.data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;color:#666;">暂无注册账号数据</td></tr>';
                    return;
                }
                res.data.forEach(acc => {
                    const tr = document.createElement('tr');
                    const isGm = parseInt(acc.gmlevel) >= 10;
                    tr.innerHTML = `
                        <td><strong>${acc.id}</strong></td>
                        <td style="color:#ffd700;"><strong>${escapeHtml(acc.username)}</strong></td>
                        <td><span class="badge ${isGm ? 'gm' : 'player'}">${isGm ? 'GM 管理员' : '普通玩家'}</span></td>
                        <td style="color:#2ecc71;">${acc.accgold}</td>
                        <td>${acc.joindate ? acc.joindate.substring(0, 16) : '-'}</td>
                        <td>${acc.locked == 1 ? '<span style="color:#e74c3c;">已冻结</span>' : '<span style="color:#2ecc71;">正常</span>'}</td>
                        <td>
                            <button class="btn-action" onclick="quickRecharge('${escapeHtml(acc.username)}')">+10万元宝</button>
                            <button class="btn-action" onclick="toggleLock('${escapeHtml(acc.username)}')">${acc.locked == 1 ? '解封' : '封号'}</button>
                        </td>
                    `;
                    tbody.appendChild(tr);
                });
            }
        })
        .catch(() => {
            tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;color:#e74c3c;">无法加载账号数据，请检查 MySQL 是否运行</td></tr>';
        });
}

// 快捷充值
function quickRecharge(username) {
    const amount = prompt(`请输入要为账号【${username}】充值的元宝数量：`, '100000');
    if (!amount || isNaN(amount) || parseInt(amount) <= 0) return;

    const fd = new FormData();
    fd.append('username', username);
    fd.append('amount', amount);

    fetch('api.php?action=recharge', {
        method: 'POST',
        body: fd
    })
    .then(res => res.json())
    .then(res => {
        alert(res.msg);
        loadAccountList();
    });
}

// 切换封禁
function toggleLock(username) {
    if (!confirm(`确定要切换账号【${username}】的锁定/正常状态吗？`)) return;

    const fd = new FormData();
    fd.append('username', username);

    fetch('api.php?action=toggle_lock', {
        method: 'POST',
        body: fd
    })
    .then(res => res.json())
    .then(res => {
        alert(res.msg);
        loadAccountList();
    });
}

function escapeHtml(str) {
    return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}
