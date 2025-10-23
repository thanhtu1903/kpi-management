<?php
session_start();

// Database configuration
define('DB_HOST', 'localhost');
define('DB_NAME', 'kpi');
define('DB_USER', 'root');
define('DB_PASS', '');

try {
    $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    // Nếu kết nối lỗi, trả về JSON thay vì die()
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode([
        'success' => false,
        'message' => 'Lỗi kết nối CSDL: ' . $e->getMessage()
    ]);
    exit;
}

// Base URL
define('BASE_URL', 'http://localhost/kpi-management');
?>
