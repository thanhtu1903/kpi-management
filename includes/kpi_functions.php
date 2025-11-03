<?php
// includes/kpi_functions.php

// Lấy chu kỳ đánh giá hiện tại
function getCurrentEvaluationCycle() {
    global $pdo;
    
    $sql = "SELECT * FROM evaluation_cycles 
            WHERE status = 'active' 
            ORDER BY start_date DESC 
            LIMIT 1";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $cycle = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$cycle) {
        // Fallback to latest draft cycle
        $sql = "SELECT * FROM evaluation_cycles 
                ORDER BY start_date DESC 
                LIMIT 1";
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
        $cycle = $stmt->fetch(PDO::FETCH_ASSOC);
    }
    
    return $cycle ?: [];
}

// Lấy tất cả chỉ số KPI
function getKpiIndicators() {
    global $pdo;
    
    $sql = "SELECT * FROM kpi_indicators WHERE is_active = 1 ORDER BY kpi_group_id, id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Lấy nhóm KPI
function getKpiGroups() {
    global $pdo;
    
    $sql = "SELECT * FROM kpi_groups WHERE is_active = 1 ORDER BY display_order";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Lấy dữ liệu KPI đã nhập của giảng viên
function getLecturerKpiData($user_id, $cycle_id) {
    global $pdo;
    
    $sql = "SELECT * FROM lecturer_kpi_data 
            WHERE user_id = ? AND evaluation_cycle_id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$user_id, $cycle_id]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Thống kê tình hình nộp KPI
function getKpiSubmissionStats($user_id, $cycle_id) {
    global $pdo;
    
    // Tổng số chỉ số
    $sql = "SELECT COUNT(*) as total FROM kpi_indicators WHERE is_active = 1";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $total = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    // Số chỉ số đã nộp
    $sql = "SELECT COUNT(*) as submitted FROM lecturer_kpi_data 
            WHERE user_id = ? AND evaluation_cycle_id = ? AND status != 'draft'";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$user_id, $cycle_id]);
    $submitted = $stmt->fetch(PDO::FETCH_ASSOC)['submitted'];
    
    return [
        'total_indicators' => $total,
        'submitted_indicators' => $submitted
    ];
}

// Xử lý submit KPI
function processKpiSubmission($user_id, $cycle_id, $post_data) {
    global $pdo;
    
    try {
        $pdo->beginTransaction();
        
        $action = $post_data['action'] ?? 'save_draft';
        $status = $action === 'submit' ? 'pending' : 'draft';
        
        foreach ($post_data['actual_value'] as $indicator_id => $actual_value) {
            if ($actual_value === '') continue;
            
            // Kiểm tra xem đã có dữ liệu chưa
            $sql = "SELECT id FROM lecturer_kpi_data 
                    WHERE user_id = ? AND evaluation_cycle_id = ? AND kpi_indicator_id = ?";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$user_id, $cycle_id, $indicator_id]);
            $existing = $stmt->fetch(PDO::FETCH_ASSOC);
            
            // Xử lý upload file
            $evidence_file_url = null;
            if (isset($_FILES['evidence_file']['name'][$indicator_id]) && 
                $_FILES['evidence_file']['error'][$indicator_id] === UPLOAD_ERR_OK) {
                $evidence_file_url = handleFileUpload($_FILES['evidence_file'], $indicator_id);
            }
            
            if ($existing) {
                // Update existing record
                $sql = "UPDATE lecturer_kpi_data 
                        SET actual_value = ?, evidence_description = ?, evidence_file_url = ?, 
                            notes = ?, status = ?, submitted_at = ?
                        WHERE id = ?";
                $stmt = $pdo->prepare($sql);
                $submitted_at = $status === 'pending' ? date('Y-m-d H:i:s') : null;
                $stmt->execute([
                    $actual_value,
                    $post_data['evidence_description'][$indicator_id] ?? null,
                    $evidence_file_url,
                    $post_data['notes'][$indicator_id] ?? null,
                    $status,
                    $submitted_at,
                    $existing['id']
                ]);
            } else {
                // Insert new record
                $sql = "INSERT INTO lecturer_kpi_data 
                        (user_id, kpi_indicator_id, evaluation_cycle_id, actual_value, 
                         evidence_description, evidence_file_url, notes, status, submitted_at) 
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                $stmt = $pdo->prepare($sql);
                $submitted_at = $status === 'pending' ? date('Y-m-d H:i:s') : null;
                $stmt->execute([
                    $user_id,
                    $indicator_id,
                    $cycle_id,
                    $actual_value,
                    $post_data['evidence_description'][$indicator_id] ?? null,
                    $evidence_file_url,
                    $post_data['notes'][$indicator_id] ?? null,
                    $status,
                    $submitted_at
                ]);
            }
            
            // Ghi log hoạt động
            logActivity($user_id, 
                $action === 'submit' ? 'SUBMIT_KPI' : 'SAVE_KPI_DRAFT',
                "Giảng viên đã " . ($action === 'submit' ? 'nộp' : 'lưu nháp') . " minh chứng KPI cho chỉ số ID: $indicator_id",
                'lecturer_kpi_data',
                $existing ? $existing['id'] : $pdo->lastInsertId()
            );
        }
        
        $pdo->commit();
        
        return [
            'success' => true,
            'message' => $action === 'submit' ? 
                'Đã nộp KPI thành công! Kết quả sẽ được trưởng khoa xét duyệt.' :
                'Đã lưu nháp thành công!'
        ];
        
    } catch (Exception $e) {
        $pdo->rollBack();
        return [
            'success' => false,
            'message' => 'Lỗi khi lưu dữ liệu: ' . $e->getMessage()
        ];
    }
}

// Xử lý upload file
function handleFileUpload($file_data, $indicator_id) {
    $upload_dir = __DIR__ . '/../uploads/evidence/';
    
    // Tạo thư mục nếu chưa tồn tại
    if (!file_exists($upload_dir)) {
        mkdir($upload_dir, 0777, true);
    }
    
    $file_name = $file_data['name'][$indicator_id];
    $file_tmp = $file_data['tmp_name'][$indicator_id];
    $file_size = $file_data['size'][$indicator_id];
    
    // Validate file type
    $allowed_types = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'jpg', 'png', 'zip'];
    $file_ext = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
    
    if (!in_array($file_ext, $allowed_types)) {
        throw new Exception("Loại file không được hỗ trợ: $file_ext");
    }
    
    // Validate file size (10MB)
    if ($file_size > 10 * 1024 * 1024) {
        throw new Exception("File quá lớn. Kích thước tối đa là 10MB");
    }
    
    // Generate unique filename
    $new_filename = 'kpi_' . $indicator_id . '_' . time() . '_' . uniqid() . '.' . $file_ext;
    $file_path = $upload_dir . $new_filename;
    
    if (move_uploaded_file($file_tmp, $file_path)) {
        return '/uploads/evidence/' . $new_filename;
    } else {
        throw new Exception("Không thể tải file lên");
    }
}

// Ghi log hoạt động
function logActivity($user_id, $action, $description, $table_name = null, $record_id = null) {
    global $pdo;
    
    $sql = "INSERT INTO activity_logs 
            (user_id, action, description, table_name, record_id, ip_address, user_agent) 
            VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        $user_id,
        $action,
        $description,
        $table_name,
        $record_id,
        $_SERVER['REMOTE_ADDR'],
        $_SERVER['HTTP_USER_AGENT']
    ]);
}
?>