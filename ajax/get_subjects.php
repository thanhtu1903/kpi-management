<?php
// File: D:\Xampp\htdocs\kpi-management\ajax\get_subjects.php
session_start();

error_reporting(E_ALL);
ini_set('display_errors', 0); // Ngăn HTML lỗi bị in ra frontend

header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/auth.php';

// Kiểm tra đăng nhập và quyền
if (!isset($_SESSION['user_id']) || $_SESSION['user_type'] !== 'giangvien') {
    echo json_encode(['success' => false, 'message' => 'Không có quyền truy cập']);
    exit;
}

$program_code = $_GET['program_code'] ?? '';

if (empty($program_code)) {
    echo json_encode(['success' => false, 'message' => 'Thiếu thông tin chương trình đào tạo']);
    exit;
}

try {
    if (!isset($pdo) || !$pdo) {
        throw new Exception('Chưa kết nối được tới CSDL (pdo null)');
    }

    $sql = "
        SELECT 
            s.id,
            s.subject_code,
            s.subject_name, 
            s.credits,
            s.theory_hours,
            s.practice_hours,
            sp.semester,
            sp.is_compulsory
        FROM subjects s
        INNER JOIN subject_program sp ON s.id = sp.subject_id
        WHERE sp.program_code = ? AND s.is_active = 1
        ORDER BY sp.semester, s.subject_name
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$program_code]);
    $subjects = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (empty($subjects)) {
        echo json_encode(['success' => true, 'subjects' => [], 'message' => 'Không có môn học nào']);
        exit;
    }

    $result = array_map(function($subject) {
        return [
            'id' => $subject['id'],
            'code' => $subject['subject_code'],
            'name' => $subject['subject_name'],
            'credits' => $subject['credits'],
            'semester' => $subject['semester'],
            'theory_hours' => $subject['theory_hours'],
            'practice_hours' => $subject['practice_hours'],
            'display_text' => $subject['subject_code'] . ' - ' . $subject['subject_name']
        ];
    }, $subjects);


    echo json_encode(['success' => true, 'subjects' => $result]);

} catch (Throwable $e) {
    echo json_encode(['success' => false, 'message' => 'Lỗi: ' . $e->getMessage()]);
}
