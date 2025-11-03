<?php
// Hàm lấy kết quả KPI
function getKpiResults($cycle_id, $department_id = null, $rating_filter = 'all') {
    global $pdo;
    
    $sql = "SELECT 
                u.id as user_id,
                u.full_name,
                u.email,
                d.department_name,
                ks.teaching_score,
                ks.research_score,
                ks.service_score,
                ks.total_final_score,
                ks.overall_rating,
                ks.ranking,
                ks.is_finalized
            FROM kpi_summaries ks
            JOIN users u ON ks.user_id = u.id
            JOIN departments d ON u.department_id = d.id
            WHERE ks.evaluation_cycle_id = :cycle_id";
    
    $params = ['cycle_id' => $cycle_id];
    
    if ($department_id) {
        $sql .= " AND u.department_id = :department_id";
        $params['department_id'] = $department_id;
    }
    
    if ($rating_filter !== 'all') {
        $rating_map = [
            'excellent' => 'Xuất sắc',
            'good' => 'Tốt', 
            'average' => 'Khá',
            'poor' => 'Trung bình'
        ];
        $sql .= " AND ks.overall_rating = :rating";
        $params['rating'] = $rating_map[$rating_filter];
    }
    
    $sql .= " ORDER BY ks.total_final_score DESC, ks.ranking ASC";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Hàm lấy kết quả KPI của giảng viên
function getLecturerKpiResults($user_id, $cycle_id) {
    global $pdo;
    
    $sql = "SELECT 
                u.id as user_id,
                u.full_name,
                u.email,
                d.department_name,
                ks.teaching_score,
                ks.research_score,
                ks.service_score,
                ks.total_final_score,
                ks.overall_rating,
                ks.ranking,
                ks.is_finalized
            FROM kpi_summaries ks
            JOIN users u ON ks.user_id = u.id
            JOIN departments d ON u.department_id = d.id
            WHERE ks.user_id = :user_id AND ks.evaluation_cycle_id = :cycle_id";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        'user_id' => $user_id,
        'cycle_id' => $cycle_id
    ]);
    
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Hàm lấy thống kê kết quả
function getKpiResultsStats($cycle_id, $department_id = null) {
    global $pdo;
    
    // Tổng số giảng viên
    $sql_total = "SELECT COUNT(*) as total 
                  FROM users u 
                  WHERE u.user_type = 'giangvien'";
    
    if ($department_id) {
        $sql_total .= " AND u.department_id = :department_id";
    }
    
    $stmt = $pdo->prepare($sql_total);
    if ($department_id) {
        $stmt->execute(['department_id' => $department_id]);
    } else {
        $stmt->execute();
    }
    $total_lecturers = $stmt->fetchColumn();
    
    // Số lượng đã đánh giá
    $sql_evaluated = "SELECT COUNT(DISTINCT ks.user_id) as evaluated
                      FROM kpi_summaries ks
                      JOIN users u ON ks.user_id = u.id
                      WHERE ks.evaluation_cycle_id = :cycle_id 
                      AND ks.is_finalized = 1";
    
    if ($department_id) {
        $sql_evaluated .= " AND u.department_id = :department_id";
    }
    
    $stmt = $pdo->prepare($sql_evaluated);
    $params = ['cycle_id' => $cycle_id];
    if ($department_id) {
        $params['department_id'] = $department_id;
    }
    $stmt->execute($params);
    $completed_evaluations = $stmt->fetchColumn();
    
    // Điểm trung bình
    $sql_avg = "SELECT AVG(ks.total_final_score) as avg_score
                FROM kpi_summaries ks
                JOIN users u ON ks.user_id = u.id
                WHERE ks.evaluation_cycle_id = :cycle_id 
                AND ks.is_finalized = 1";
    
    if ($department_id) {
        $sql_avg .= " AND u.department_id = :department_id";
    }
    
    $stmt = $pdo->prepare($sql_avg);
    $stmt->execute($params);
    $average_score = $stmt->fetchColumn() ?: 0;
    
    // Phân bố xếp loại
    $sql_rating = "SELECT 
                      COUNT(*) as count,
                      ks.overall_rating
                   FROM kpi_summaries ks
                   JOIN users u ON ks.user_id = u.id
                   WHERE ks.evaluation_cycle_id = :cycle_id
                   AND ks.is_finalized = 1";
    
    if ($department_id) {
        $sql_rating .= " AND u.department_id = :department_id";
    }
    
    $sql_rating .= " GROUP BY ks.overall_rating";
    
    $stmt = $pdo->prepare($sql_rating);
    $stmt->execute($params);
    $rating_distribution = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Điểm trung bình theo khoa
    $sql_dept = "SELECT 
                    d.department_name,
                    AVG(ks.total_final_score) as average_score
                 FROM kpi_summaries ks
                 JOIN users u ON ks.user_id = u.id
                 JOIN departments d ON u.department_id = d.id
                 WHERE ks.evaluation_cycle_id = :cycle_id
                 AND ks.is_finalized = 1
                 GROUP BY d.id, d.department_name
                 ORDER BY average_score DESC";
    
    $stmt = $pdo->prepare($sql_dept);
    $stmt->execute(['cycle_id' => $cycle_id]);
    $department_scores = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    return [
        'total_lecturers' => $total_lecturers,
        'completed_evaluations' => $completed_evaluations,
        'pending_evaluations' => $total_lecturers - $completed_evaluations,
        'average_score' => $average_score,
        'rating_distribution' => $rating_distribution,
        'department_scores' => $department_scores
    ];
}

// Hàm lấy tất cả khoa
function getAllDepartments() {
    global $pdo;
    
    $stmt = $pdo->prepare("SELECT * FROM departments WHERE is_active = 1 ORDER BY department_name");
    $stmt->execute();
    
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Hàm lấy khoa của user
function getUserDepartment($user_id) {
    global $pdo;
    
    $stmt = $pdo->prepare("SELECT d.* FROM users u 
                          JOIN departments d ON u.department_id = d.id 
                          WHERE u.id = :user_id");
    $stmt->execute(['user_id' => $user_id]);
    
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

// Hàm lấy tất cả chu kỳ đánh giá
function getAllEvaluationCycles() {
    global $pdo;
    
    $stmt = $pdo->prepare("SELECT * FROM evaluation_cycles ORDER BY start_date DESC");
    $stmt->execute();
    
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
?>