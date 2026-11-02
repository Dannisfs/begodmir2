<?php
/**
 * GOD引擎 网页系统核心后端 API
 */
require_once __DIR__ . '/config.php';

header('Content-Type: application/json; charset=utf-8');

$action = isset($_GET['action']) ? trim($_GET['action']) : '';
$pdo = get_db_connection();

function json_out($code, $msg, $data = null) {
    echo json_encode([
        'code' => $code,
        'msg' => $msg,
        'data' => $data
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

// 1. 获取服务器四项关键端口健康状态
if ($action === 'server_status') {
    $ports = [
        'web' => ['name' => 'Web微端 (88端口)', 'status' => check_port('127.0.0.1', 88)],
        'mysql' => ['name' => 'MySQL数据库 (3306端口)', 'status' => ($pdo !== null)],
        'logingate' => ['name' => '选区登录网关 (8090端口)', 'status' => check_port('127.0.0.1', 8090)],
        'rungate' => ['name' => '游戏运行网关 (7200端口)', 'status' => check_port('127.0.0.1', 7200)],
    ];
    json_out(200, 'success', $ports);
}

if (!$pdo) {
    json_out(500, '无法连接到 MySQL 账号数据库，请确保 3306 端口与服务正常启动！');
}

// 2. 账号注册
if ($action === 'register') {
    $username = isset($_POST['username']) ? trim($_POST['username']) : '';
    $password = isset($_POST['password']) ? trim($_POST['password']) : '';
    $repass   = isset($_POST['repass']) ? trim($_POST['repass']) : '';
    $seccode  = isset($_POST['seccode']) ? trim($_POST['seccode']) : '123456';
    $isgm     = isset($_POST['isgm']) && $_POST['isgm'] === '1' ? 10 : 0;
    $initgold = isset($_POST['initgold']) ? intval($_POST['initgold']) : 50000;

    if (empty($username) || empty($password)) {
        json_out(400, '账号和密码不能为空！');
    }

    if ($repass !== '' && $password !== $repass) {
        json_out(400, '两次输入的密码不一致！');
    }

    if (strlen($username) < 3 || strlen($username) > 16) {
        json_out(400, '账号长度必须在 3 到 16 个字符之间！');
    }

    if (!preg_match('/^[a-zA-Z0-9_]+$/', $username)) {
        json_out(400, '账号只能由英文字母、数字或下划线组成！');
    }

    // 检查账号是否存在
    $stmt = $pdo->prepare("SELECT id FROM account WHERE username = ?");
    $stmt->execute([$username]);
    if ($stmt->fetch()) {
        json_out(409, "账号【{$username}】已存在，请换一个账号名注册！");
    }

    // 写入账号数据
    $insertSql = "INSERT INTO account (
        username, password, gmlevel, channel, accgold, accgoldadd, 
        joindate, last_login, locked, cardname, cardid, phone, 
        quiz1, answer1, quiz2, answer2, birthday, mobilephone, error_count, action_tick, SecCode
    ) VALUES (
        ?, ?, ?, 1000, ?, ?, 
        NOW(), NOW(), 0, ?, '', '', 
        '1', '1', '1', '1', '1980/10/10', '', 0, 0, ?
    )";

    try {
        $insertStmt = $pdo->prepare($insertSql);
        $insertStmt->execute([
            $username,
            $password,
            $isgm,
            $initgold,
            $initgold,
            $username,
            $seccode
        ]);
        $gmText = $isgm ? " (已开通GM权限)" : "";
        json_out(200, "账号【{$username}】注册成功！赠送元宝：{$initgold}{$gmText}");
    } catch (Exception $e) {
        json_out(500, '注册写入数据库失败：' . $e->getMessage());
    }
}

// 3. 修改密码
if ($action === 'change_pwd') {
    $username = isset($_POST['username']) ? trim($_POST['username']) : '';
    $oldpass  = isset($_POST['oldpass']) ? trim($_POST['oldpass']) : '';
    $newpass  = isset($_POST['newpass']) ? trim($_POST['newpass']) : '';
    $seccode  = isset($_POST['seccode']) ? trim($_POST['seccode']) : '';

    if (empty($username) || empty($oldpass) || empty($newpass)) {
        json_out(400, '请填写完整的账号、原密码与新密码！');
    }

    $stmt = $pdo->prepare("SELECT id, password, SecCode FROM account WHERE username = ?");
    $stmt->execute([$username]);
    $user = $stmt->fetch();

    if (!$user) {
        json_out(404, '账号不存在！');
    }

    if ($user['password'] !== $oldpass) {
        json_out(403, '原密码错误，修改失败！');
    }

    if (!empty($user['SecCode']) && $user['SecCode'] !== '123456') {
        if ($user['SecCode'] !== $seccode) {
            json_out(403, '二级安全保护码校验失败！');
        }
    }

    $update = $pdo->prepare("UPDATE account SET password = ? WHERE id = ?");
    $update->execute([$newpass, $user['id']]);

    json_out(200, "账号【{$username}】密码修改成功！请使用新密码登录游戏。");
}

// 4. 获取账号列表
if ($action === 'list_accounts') {
    try {
        $stmt = $pdo->query("SELECT id, username, gmlevel, accgold, joindate, locked FROM account ORDER BY id DESC LIMIT 25");
        $list = $stmt->fetchAll();
        json_out(200, 'success', $list);
    } catch (Exception $e) {
        json_out(500, '查询账号列表失败：' . $e->getMessage());
    }
}

// 5. 快速充值元宝 / 封停解封
if ($action === 'admin_action') {
    $subAction = isset($_POST['sub_action']) ? $_POST['sub_action'] : '';
    $userId    = isset($_POST['id']) ? intval($_POST['id']) : 0;

    if ($userId <= 0) {
        json_out(400, '参数错误！');
    }

    if ($subAction === 'add_gold') {
        $amount = isset($_POST['amount']) ? intval($_POST['amount']) : 100000;
        $up = $pdo->prepare("UPDATE account SET accgold = accgold + ? WHERE id = ?");
        $up->execute([$amount, $userId]);
        json_out(200, "成功为账号增加 {$amount} 元宝！");
    }

    if ($subAction === 'toggle_lock') {
        $up = $pdo->prepare("UPDATE account SET locked = IF(locked=1, 0, 1) WHERE id = ?");
        $up->execute([$userId]);
        json_out(200, '账号封停/解封状态切换成功！');
    }

    json_out(400, '未知的管理操作！');
}

json_out(404, '未知的 API 操作请求！');
