<?php
// includes/auth.php

// Đảm bảo session được start
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

function getUserRole() {
    return $_SESSION['user_type'] ?? null;
}

function redirectIfNotLoggedIn() {
    if (!isLoggedIn()) {
        header('Location: login.php');
        exit;
    }
}

function checkPermission($allowedRoles) {
    if (!isLoggedIn()) {
        header('Location: login.php');
        exit;
    }
    
    if (!in_array(getUserRole(), $allowedRoles)) {
        header('Location: ../access-denied.php');
        exit;
    }
}

function loginUser($email, $password, $remember_me = false) {
    global $pdo;
    
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ? AND is_active = 1");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    // SỬA: So sánh password trực tiếp (vì bạn đang lưu plain text)
    if ($user && $password === $user['password']) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['email'] = $user['email'];
        $_SESSION['full_name'] = $user['full_name'];
        $_SESSION['user_type'] = $user['user_type'];
        $_SESSION['department_id'] = $user['department_id'];
        
        return true;
    }
    return false;
}

function deleteRememberToken($token) {
    global $pdo;
    try {
        $stmt = $pdo->prepare("DELETE FROM user_sessions WHERE session_token = ?");
        return $stmt->execute([$token]);
    } catch (Exception $e) {
        return false;
    }
}

function logoutUser() {
    // Xóa remember token nếu có
    if (isset($_COOKIE['remember_me'])) {
        $token = $_COOKIE['remember_me'];
        deleteRememberToken($token);
        setcookie('remember_me', '', time() - 3600, '/');
    }
    
    // Hủy session
    $_SESSION = array();
    session_destroy();
    
    // Chuyển hướng về login
    header('Location: login.php');
    exit;
}
?>