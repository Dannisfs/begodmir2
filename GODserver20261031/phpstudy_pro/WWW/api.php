<?php
/**
 * GOD引擎 网页账号管理中心 REST API
 */
header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/config.php';

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
        'rungate' => ['name' => '游戏运行网关 (7000端口)', 'status' => check_port('127.0.0.1', 7000)],
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
    $initgold = isset($_POST['initgold']) ? intval($_POST['initgold']) : 10000;
    $isgm     = !empty($_POST['isgm']) ? 10 : 0;

    if (empty($username) || empty($password)) {
        json_out(400, '账号和密码不能为空！');
    }

    if (strlen($username) < 3 || strlen($username) > 20) {
        json_out(400, '账号长度必须在 3 ~ 20 位之间！');
    }

    if ($password !== $repass) {
        json_out(400, '两次输入的密码不一致！');
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
        json_out(200, "账号【{$username}】注册成功！赠送元宝：{$initgold}" . ($isgm ? "（已开通 GM 权限）" : ""));
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

    if (empty($username) || empty($newpass)) {
        json_out(400, '账号和新密码不能为空！');
    }

    // 查询该账号
    $stmt = $pdo->prepare("SELECT * FROM account WHERE username = ?");
    $stmt->execute([$username]);
    $acc = $stmt->fetch();
    if (!$acc) {
        json_out(404, "账号【{$username}】不存在！");
    }

    // 校验原密码或安全码
    $verified = false;
    if (!empty($oldpass) && $acc['password'] === $oldpass) {
        $verified = true;
    } elseif (!empty($seccode) && $acc['SecCode'] === $seccode) {
        $verified = true;
    }

    if (!$verified) {
        json_out(403, '原密码或安全码验证错误，无法修改密码！');
    }

    $updateStmt = $pdo->prepare("UPDATE account SET password = ? WHERE username = ?");
    $updateStmt->execute([$newpass, $username]);
    json_out(200, "账号【{$username}】密码修改成功，请牢记新密码！");
}

// 4. 查询最近账号列表 (最多返回最新30个)
if ($action === 'list_accounts') {
    try {
        $stmt = $pdo->query("SELECT id, username, gmlevel, accgold, joindate, last_login, locked, SecCode FROM account ORDER BY id DESC LIMIT 30");
        $list = $stmt->fetchAll();
        json_out(200, 'success', $list);
    } catch (Exception $e) {
        json_out(500, '查询失败：' . $e->getMessage());
    }
}

// 5. 快速快捷充值元宝
if ($action === 'recharge') {
    $username = isset($_POST['username']) ? trim($_POST['username']) : '';
    $amount   = isset($_POST['amount']) ? intval($_POST['amount']) : 0;

    if (empty($username) || $amount <= 0) {
        json_out(400, '充值账号或金额无效！');
    }

    $stmt = $pdo->prepare("UPDATE account SET accgold = accgold + ?, accgoldadd = accgoldadd + ? WHERE username = ?");
    $stmt->execute([$amount, $amount, $username]);
    if ($stmt->rowCount() > 0) {
        json_out(200, "成功为账号【{$username}】充值 {$amount} 元宝！");
    } else {
        json_out(404, "未找到账号【{$username}】！");
    }
}

// 6. 一键切换封号/解封
if ($action === 'toggle_lock') {
    $username = isset($_POST['username']) ? trim($_POST['username']) : '';
    if (empty($username)) {
        json_out(400, '账号不能为空！');
    }
    $stmt = $pdo->prepare("UPDATE account SET locked = IF(locked=1, 0, 1) WHERE username = ?");
    $stmt->execute([$username]);
    json_out(200, "账号【{$username}】状态已切换！");
}

json_out(404, 'Unknown Action');
?>
