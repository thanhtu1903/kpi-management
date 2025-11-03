<?php
require_once __DIR__ . '/../includes/config.php';
header('Content-Type: application/json; charset=utf-8');

// Cho phép CORS nếu cần
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Xử lý preflight request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

// Lấy tham số từ request
$subject_id = $_GET['subject_id'] ?? $_POST['subject_id'] ?? null;
$type_param = $_GET['type'] ?? $_POST['type'] ?? null;

// Validate required parameters
if (!$subject_id) {
    http_response_code(400);
    echo json_encode([
        'success' => false, 
        'message' => 'Thiếu tham số subject_id'
    ]);
    exit;
}

// Chuyển đổi 'LT'/'TH' sang 0/1
$type = null;
if ($type_param === 'LT') {
    $type = 0;
} elseif ($type_param === 'TH') {
    $type = 1;
}

try {
    // Build SQL query
    $sql = "SELECT 
                st.id,
                st.topic_title,
                st.content,
                st.type,
                st.created_at,
                s.subject_code,
                s.subject_name
            FROM subject_topics st
            INNER JOIN subjects s ON st.subject_id = s.id
            WHERE st.subject_id = ?";
    
    $params = [$subject_id];
    
    // Add type filter if specified
    if ($type !== null) {
        $sql .= " AND st.type = ?";
        $params[] = $type;
    }
    
    // Order by topic order (you might want to add an order field to your table)
    $sql .= " ORDER BY st.id ASC";
    
    // Prepare and execute query
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $topics = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Format response
    $response = [
        'success' => true,
        'subject_id' => $subject_id,
        'type' => $type_param,
        'total_topics' => count($topics),
        'topics' => $topics
    ];
    
    // If no topics found, return empty array with info
    if (empty($topics)) {
        $response['message'] = 'Không tìm thấy chủ đề nào cho môn học này';
        
        // Get subject info for better error message
        $subject_sql = "SELECT subject_code, subject_name FROM subjects WHERE id = ?";
        $subject_stmt = $pdo->prepare($subject_sql);
        $subject_stmt->execute([$subject_id]);
        $subject = $subject_stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($subject) {
            $response['subject_info'] = $subject;
        }
    }
    
    echo json_encode($response);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false, 
        'message' => 'Lỗi cơ sở dữ liệu: ' . $e->getMessage()
    ]);
} catch (Throwable $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false, 
        'message' => 'Lỗi hệ thống: ' . $e->getMessage()
    ]);
}
?>