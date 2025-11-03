<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/kpi_result.php';
require_once __DIR__ . '/../includes/kpi_functions.php';

// Kiểm tra đăng nhập
if (!isLoggedIn()) {
    header('Location: login.php');
    exit;
}

$user_id = $_SESSION['user_id'];
$user_type = $_SESSION['user_type'];
$current_cycle = getCurrentEvaluationCycle();

// Xử lý filter và tìm kiếm
$cycle_id = isset($_GET['cycle_id']) ? intval($_GET['cycle_id']) : $current_cycle['id'];
$department_id = isset($_GET['department_id']) ? intval($_GET['department_id']) : null;
$rating_filter = isset($_GET['rating']) ? $_GET['rating'] : 'all';
$view_mode = isset($_GET['view']) ? $_GET['view'] : 'grid'; // grid hoặc list

// Lấy dữ liệu kết quả
if ($user_type === 'admin') {
    $results = getKpiResults($cycle_id, $department_id, $rating_filter);
    $departments = getAllDepartments();
} elseif ($user_type === 'truongkhoa') {
    $user_department = getUserDepartment($user_id);
    $department_id = $user_department['id'];
    $results = getKpiResults($cycle_id, $department_id, $rating_filter);
    $departments = [$user_department];
} else {
    $results = getLecturerKpiResults($user_id, $cycle_id);
    $departments = [];
}

$evaluation_cycles = getAllEvaluationCycles();
$stats = getKpiResultsStats($cycle_id, $department_id);
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết Quả Đánh Giá KPI - Hệ thống Đánh giá Giảng viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #4895ef;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #f94144;
            --dark: #2b2d42;
            --light: #f8f9fa;
            --gray: #6c757d;
            --border: #e9ecef;
            --gradient-primary: linear-gradient(135deg, #4361ee 0%, #3f37c9 100%);
            --gradient-success: linear-gradient(135deg, #4cc9f0 0%, #3a86ff 100%);
            --gradient-warning: linear-gradient(135deg, #f8961e 0%, #f3722c 100%);
            --gradient-danger: linear-gradient(135deg, #f94144 0%, #f72585 100%);
            --gradient-dark: linear-gradient(135deg, #2b2d42 0%, #1d1e2c 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            margin-left: 280px;
            margin-top: 100px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
            min-height: 100vh;
            color: var(--dark);
            line-height: 1.6;
        }

        /* Navigation */
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .navbar {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95) !important;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }

        .nav-link {
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--primary) !important;
        }

        /* Main Container */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        /* Header */
        .page-header {
            background: var(--gradient-primary);
            color: white;
            border-radius: 20px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(67, 97, 238, 0.3);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(30%, -30%);
        }

        .page-header::after {
            content: '';
            position: absolute;
            bottom: -50px;
            left: -50px;
            width: 150px;
            height: 150px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
        }

        .page-title {
            font-weight: 800;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-subtitle {
            opacity: 0.9;
            font-size: 1.1rem;
            position: relative;
            z-index: 1;
        }

        /* Stat Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: none;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-primary);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 1.5rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .stat-icon.primary { background: var(--gradient-primary); color: white; }
        .stat-icon.success { background: var(--gradient-success); color: white; }
        .stat-icon.warning { background: var(--gradient-warning); color: white; }
        .stat-icon.info { background: var(--gradient-dark); color: white; }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-label {
            color: var(--gray);
            font-weight: 500;
            font-size: 0.95rem;
        }

        /* Filter Section */
        .filter-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            border: none;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .form-select, .form-control {
            border: 2px solid var(--border);
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            box-shadow: none;
        }

        .form-select:focus, .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        /* View Toggle */
        .view-toggle {
            display: flex;
            background: white;
            border-radius: 12px;
            padding: 0.5rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border);
        }

        .view-btn {
            padding: 0.75rem 1.5rem;
            border: none;
            background: transparent;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .view-btn.active {
            background: var(--gradient-primary);
            color: white;
            box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
        }

        /* Results Grid */
        .results-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .result-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: none;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .result-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .result-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-primary);
        }

        .ranking-badge {
            position: absolute;
            top: -10px;
            right: -10px;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: white;
            font-size: 1.1rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            z-index: 2;
        }

        .ranking-1 { background: var(--gradient-warning); }
        .ranking-2 { background: var(--gradient-dark); }
        .ranking-3 { background: var(--gradient-danger); }
        .ranking-other { background: var(--gradient-primary); }

        .lecturer-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
        }

        .lecturer-name {
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 0.25rem;
        }

        .lecturer-department {
            color: var(--gray);
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .score-section {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin: 1.5rem 0;
        }

        .score-item {
            text-align: center;
            padding: 0.75rem;
            border-radius: 10px;
            background: rgba(67, 97, 238, 0.05);
            transition: all 0.3s ease;
        }

        .score-item:hover {
            background: rgba(67, 97, 238, 0.1);
            transform: translateY(-2px);
        }

        .score-label {
            font-size: 0.8rem;
            color: var(--gray);
            margin-bottom: 0.25rem;
        }

        .score-value {
            font-weight: 700;
            font-size: 1.1rem;
        }

        .total-score {
            background: var(--gradient-primary);
            color: white;
            padding: 1rem;
            border-radius: 12px;
            text-align: center;
            margin: 1rem 0;
            box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
        }

        .total-score-value {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .total-score-label {
            opacity: 0.9;
            font-size: 0.9rem;
        }

        .rating-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .rating-excellent { background: rgba(25, 135, 84, 0.15); color: #198754; border: 1px solid rgba(25, 135, 84, 0.2); }
        .rating-good { background: rgba(13, 202, 240, 0.15); color: #0dcaf0; border: 1px solid rgba(13, 202, 240, 0.2); }
        .rating-average { background: rgba(255, 193, 7, 0.15); color: #ffc107; border: 1px solid rgba(255, 193, 7, 0.2); }
        .rating-poor { background: rgba(220, 53, 69, 0.15); color: #dc3545; border: 1px solid rgba(220, 53, 69, 0.2); }

        /* Chart Containers */
        .chart-container {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .chart-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-primary);
        }

        .chart-title {
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Table View */
        .table-container {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            border: none;
        }

        .table th {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 600;
            position: sticky;
            top: 0;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-color: var(--border);
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            border-radius: 10px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            border: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background: var(--gradient-primary);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(67, 97, 238, 0.4);
        }

        .btn-success {
            background: var(--gradient-success);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(76, 201, 240, 0.4);
        }

        .btn-danger {
            background: var(--gradient-danger);
        }

        .btn-outline-primary {
            border: 2px solid var(--primary);
            color: var(--primary);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
        }

        /* Footer */
        .footer {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-top: 2rem;
            color: var(--gray);
            border: none;
        }

        /* Loading Animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .loading-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .spinner-border {
            width: 3rem;
            height: 3rem;
            color: var(--primary);
        }

        /* Progress Bars */
        .progress {
            height: 8px;
            border-radius: 10px;
            background-color: rgba(67, 97, 238, 0.1);
            overflow: hidden;
        }

        .progress-bar {
            border-radius: 10px;
            background: var(--gradient-primary);
            transition: width 0.5s ease;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--secondary);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .results-grid {
                grid-template-columns: 1fr;
            }
            
            .score-section {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        /* Tooltip */
        .custom-tooltip {
            position: relative;
            display: inline-block;
        }

        .custom-tooltip .tooltip-text {
            visibility: hidden;
            width: 200px;
            background-color: var(--dark);
            color: white;
            text-align: center;
            border-radius: 6px;
            padding: 8px;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            transform: translateX(-50%);
            opacity: 0;
            transition: opacity 0.3s;
            font-size: 0.8rem;
        }

        .custom-tooltip:hover .tooltip-text {
            visibility: visible;
            opacity: 1;
        }

        /* Modal Enhancements */
        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            background: var(--gradient-primary);
            color: white;
            border-radius: 16px 16px 0 0;
            border: none;
        }

        .modal-title {
            font-weight: 600;
        }

        .btn-close {
            filter: invert(1);
        }

        /* Search Box */
        .search-box {
            position: relative;
        }

        .search-box input {
            padding-left: 2.5rem;
        }

        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }
    </style>
</head>
<body>
    <?php include '../includes/header.php'; ?>
    <?php include '../includes/sidebar.php'; ?>
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner-border" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>

       

    <!-- Main Content -->
    <div class="main-container">

        <!-- Statistics -->
        <div class="stats-grid">
            <div class="stat-card animate-fade-in-up" style="animation-delay: 0.1s;">
                <div class="stat-icon primary">
                    <i class="fas fa-user-check"></i>
                </div>
                <div class="stat-number"><?php echo $stats['total_lecturers']; ?></div>
                <div class="stat-label">Tổng Giảng Viên</div>
                <div class="progress mt-2">
                    <div class="progress-bar" style="width: 100%"></div>
                </div>
            </div>
            <div class="stat-card animate-fade-in-up" style="animation-delay: 0.2s;">
                <div class="stat-icon success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-number"><?php echo $stats['completed_evaluations']; ?></div>
                <div class="stat-label">Đã Đánh Giá</div>
                <div class="progress mt-2">
                    <div class="progress-bar" style="width: <?php echo $stats['total_lecturers'] > 0 ? ($stats['completed_evaluations'] / $stats['total_lecturers'] * 100) : 0; ?>%"></div>
                </div>
            </div>
            <div class="stat-card animate-fade-in-up" style="animation-delay: 0.3s;">
                <div class="stat-icon warning">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-number"><?php echo $stats['pending_evaluations']; ?></div>
                <div class="stat-label">Chờ Đánh Giá</div>
                <div class="progress mt-2">
                    <div class="progress-bar" style="width: <?php echo $stats['total_lecturers'] > 0 ? ($stats['pending_evaluations'] / $stats['total_lecturers'] * 100) : 0; ?>%"></div>
                </div>
            </div>
            <div class="stat-card animate-fade-in-up" style="animation-delay: 0.4s;">
                <div class="stat-icon info">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-number"><?php echo round($stats['average_score'], 1); ?></div>
                <div class="stat-label">Điểm Trung Bình</div>
                <div class="progress mt-2">
                    <div class="progress-bar" style="width: <?php echo $stats['average_score']; ?>%"></div>
                </div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-card animate-fade-in-up">
            <div class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label">Chu kỳ đánh giá</label>
                    <select class="form-select" name="cycle_id" id="cycleSelect">
                        <?php foreach ($evaluation_cycles as $cycle): ?>
                            <option value="<?php echo $cycle['id']; ?>" <?php echo $cycle_id == $cycle['id'] ? 'selected' : ''; ?>>
                                <?php echo $cycle['cycle_name']; ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                
                <?php if ($user_type !== 'giangvien'): ?>
                <div class="col-md-2">
                    <label class="form-label">Khoa/Bộ môn</label>
                    <select class="form-select" name="department_id" id="departmentSelect">
                        <option value="">Tất cả khoa</option>
                        <?php foreach ($departments as $dept): ?>
                            <option value="<?php echo $dept['id']; ?>" <?php echo $department_id == $dept['id'] ? 'selected' : ''; ?>>
                                <?php echo $dept['department_name']; ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <?php endif; ?>
                
                <div class="col-md-2">
                    <label class="form-label">Xếp loại</label>
                    <select class="form-select" name="rating" id="ratingSelect">
                        <option value="all" <?php echo $rating_filter == 'all' ? 'selected' : ''; ?>>Tất cả</option>
                        <option value="excellent" <?php echo $rating_filter == 'excellent' ? 'selected' : ''; ?>>Xuất sắc</option>
                        <option value="good" <?php echo $rating_filter == 'good' ? 'selected' : ''; ?>>Tốt</option>
                        <option value="average" <?php echo $rating_filter == 'average' ? 'selected' : ''; ?>>Khá</option>
                        <option value="poor" <?php echo $rating_filter == 'poor' ? 'selected' : ''; ?>>Trung bình</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <label class="form-label">Chế độ xem</label>
                    <div class="view-toggle">
                        <button type="button" class="view-btn <?php echo $view_mode == 'grid' ? 'active' : ''; ?>" onclick="changeViewMode('grid')">
                            <i class="fas fa-th-large"></i> Grid
                        </button>
                        <button type="button" class="view-btn <?php echo $view_mode == 'list' ? 'active' : ''; ?>" onclick="changeViewMode('list')">
                            <i class="fas fa-list"></i> List
                        </button>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm giảng viên...">
                    </div>
                </div>
                
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100" onclick="applyFilters()">
                        <i class="fas fa-filter me-1"></i>Áp dụng
                    </button>
                </div>
            </div>
        </div>

        <!-- Charts -->
        <div class="row">
            <div class="col-lg-6">
                <div class="chart-container animate-fade-in-up">
                    <h5 class="chart-title">
                        <i class="fas fa-chart-pie text-primary"></i>
                        Phân bố xếp loại
                    </h5>
                    <canvas id="ratingChart" height="250"></canvas>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="chart-container animate-fade-in-up">
                    <h5 class="chart-title">
                        <i class="fas fa-chart-bar text-success"></i>
                        Điểm trung bình theo khoa
                    </h5>
                    <canvas id="departmentChart" height="250"></canvas>
                </div>
            </div>
        </div>

        <!-- Results -->
        <?php if ($view_mode == 'grid'): ?>
            <!-- Grid View -->
            <div class="results-grid animate-fade-in-up" id="resultsGrid">
                <?php if (empty($results)): ?>
                    <div class="col-12 text-center py-5">
                        <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                        <h4 class="text-muted">Không có dữ liệu kết quả</h4>
                        <p class="text-muted">Hãy thay đổi bộ lọc để xem kết quả</p>
                    </div>
                <?php else: ?>
                    <?php foreach ($results as $index => $result): ?>
                        <?php
                        $ranking_class = 'ranking-other';
                        if ($result['ranking'] == 1) $ranking_class = 'ranking-1';
                        elseif ($result['ranking'] == 2) $ranking_class = 'ranking-2';
                        elseif ($result['ranking'] == 3) $ranking_class = 'ranking-3';
                        
                        $rating_class = 'rating-average';
                        if ($result['total_final_score'] >= 90) $rating_class = 'rating-excellent';
                        elseif ($result['total_final_score'] >= 75) $rating_class = 'rating-good';
                        elseif ($result['total_final_score'] >= 60) $rating_class = 'rating-average';
                        else $rating_class = 'rating-poor';
                        ?>
                        <div class="result-card" data-search="<?php echo strtolower($result['full_name'] . ' ' . $result['department_name']); ?>">
                            <?php if ($result['ranking']): ?>
                                <div class="ranking-badge <?php echo $ranking_class; ?>">
                                    #<?php echo $result['ranking']; ?>
                                </div>
                            <?php endif; ?>
                            
                            <div class="lecturer-avatar">
                                <?php echo strtoupper(substr($result['full_name'], 0, 1)); ?>
                            </div>
                            
                            <h4 class="lecturer-name"><?php echo $result['full_name']; ?></h4>
                            <div class="lecturer-department">
                                <i class="fas fa-building me-1"></i>
                                <?php echo $result['department_name']; ?>
                            </div>
                            
                            <div class="score-section">
                                <div class="score-item">
                                    <div class="score-label">Giảng dạy</div>
                                    <div class="score-value text-primary">
                                        <?php echo $result['teaching_score'] ? number_format($result['teaching_score'], 1) : '-'; ?>
                                    </div>
                                </div>
                                <div class="score-item">
                                    <div class="score-label">Nghiên cứu</div>
                                    <div class="score-value text-success">
                                        <?php echo $result['research_score'] ? number_format($result['research_score'], 1) : '-'; ?>
                                    </div>
                                </div>
                                <div class="score-item">
                                    <div class="score-label">Phục vụ</div>
                                    <div class="score-value text-warning">
                                        <?php echo $result['service_score'] ? number_format($result['service_score'], 1) : '-'; ?>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="total-score">
                                <div class="total-score-value">
                                    <?php echo $result['total_final_score'] ? number_format($result['total_final_score'], 1) : '-'; ?>
                                </div>
                                <div class="total-score-label">Tổng điểm</div>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="rating-badge <?php echo $rating_class; ?>">
                                    <?php echo $result['overall_rating'] ?: 'Chưa đánh giá'; ?>
                                </span>
                                <div class="action-buttons">
                                    <button class="btn btn-sm btn-outline-primary custom-tooltip" 
                                            onclick="viewDetails(<?php echo $result['user_id']; ?>, <?php echo $cycle_id; ?>)"
                                            title="Xem chi tiết">
                                        <i class="fas fa-eye"></i>
                                        <span class="tooltip-text">Xem chi tiết kết quả đánh giá</span>
                                    </button>
                                    <?php if ($user_type !== 'giangvien'): ?>
                                    <button class="btn btn-sm btn-outline-success custom-tooltip"
                                            onclick="exportReport(<?php echo $result['user_id']; ?>, <?php echo $cycle_id; ?>)"
                                            title="Xuất báo cáo">
                                        <i class="fas fa-download"></i>
                                        <span class="tooltip-text">Xuất báo cáo chi tiết</span>
                                    </button>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
        <?php else: ?>
            <!-- Table View -->
            <div class="table-container animate-fade-in-up">
                <div class="table-responsive">
                    <table class="table table-hover mb-0" id="resultsTable">
                        <thead>
                            <tr>
                                <th width="60" class="sortable" data-sort="ranking"># <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="name">Giảng viên <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="department">Khoa <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="teaching">Giảng dạy <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="research">Nghiên cứu <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="service">Phục vụ <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="total">Tổng điểm <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="rating">Xếp loại <i class="fas fa-sort"></i></th>
                                <th width="100">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($results)): ?>
                                <tr>
                                    <td colspan="9" class="text-center py-4 text-muted">
                                        <i class="fas fa-inbox fa-2x mb-2"></i>
                                        <p>Không có dữ liệu kết quả đánh giá</p>
                                    </td>
                                </tr>
                            <?php else: ?>
                                <?php foreach ($results as $index => $result): ?>
                                    <?php
                                    $rating_class = 'rating-average';
                                    if ($result['total_final_score'] >= 90) $rating_class = 'rating-excellent';
                                    elseif ($result['total_final_score'] >= 75) $rating_class = 'rating-good';
                                    elseif ($result['total_final_score'] >= 60) $rating_class = 'rating-average';
                                    else $rating_class = 'rating-poor';
                                    ?>
                                    <tr data-search="<?php echo strtolower($result['full_name'] . ' ' . $result['department_name']); ?>">
                                        <td class="text-center fw-bold text-primary">
                                            <?php echo $result['ranking'] ? '#' . $result['ranking'] : '-'; ?>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="lecturer-avatar me-2" style="width: 35px; height: 35px; font-size: 0.9rem;">
                                                    <?php echo strtoupper(substr($result['full_name'], 0, 1)); ?>
                                                </div>
                                                <div>
                                                    <div class="fw-bold"><?php echo $result['full_name']; ?></div>
                                                    <small class="text-muted"><?php echo $result['email']; ?></small>
                                                </div>
                                            </div>
                                        </td>
                                        <td><?php echo $result['department_name']; ?></td>
                                        <td class="text-center fw-bold">
                                            <?php echo $result['teaching_score'] ? number_format($result['teaching_score'], 1) : '-'; ?>
                                        </td>
                                        <td class="text-center fw-bold">
                                            <?php echo $result['research_score'] ? number_format($result['research_score'], 1) : '-'; ?>
                                        </td>
                                        <td class="text-center fw-bold">
                                            <?php echo $result['service_score'] ? number_format($result['service_score'], 1) : '-'; ?>
                                        </td>
                                        <td class="text-center fw-bold fs-6">
                                            <?php echo $result['total_final_score'] ? number_format($result['total_final_score'], 1) : '-'; ?>
                                        </td>
                                        <td>
                                            <span class="rating-badge <?php echo $rating_class; ?>">
                                                <?php echo $result['overall_rating'] ?: 'Chưa đánh giá'; ?>
                                            </span>
                                        </td>
                                        <td class="action-buttons">
                                            <button class="btn btn-sm btn-outline-primary custom-tooltip" 
                                                    onclick="viewDetails(<?php echo $result['user_id']; ?>, <?php echo $cycle_id; ?>)">
                                                <i class="fas fa-eye"></i>
                                                <span class="tooltip-text">Xem chi tiết kết quả đánh giá</span>
                                            </button>
                                            <?php if ($user_type !== 'giangvien'): ?>
                                            <button class="btn btn-sm btn-outline-success custom-tooltip"
                                                    onclick="exportReport(<?php echo $result['user_id']; ?>, <?php echo $cycle_id; ?>)">
                                                <i class="fas fa-download"></i>
                                                <span class="tooltip-text">Xuất báo cáo chi tiết</span>
                                            </button>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        <?php endif; ?>

        <!-- Export Section -->
        <div class="filter-card text-center">
            <button class="btn btn-success me-2" onclick="exportAllResults()">
                <i class="fas fa-file-excel me-1"></i>Xuất Excel
            </button>
            <button class="btn btn-danger me-2" onclick="exportPDF()">
                <i class="fas fa-file-pdf me-1"></i>Xuất PDF
            </button>
            <button class="btn btn-primary" onclick="printResults()">
                <i class="fas fa-print me-1"></i>In Kết Quả
            </button>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p class="mb-0">
                <i class="fas fa-copyright me-1"></i>
                2024 Hệ thống Đánh giá KPI Giảng viên. Đã được cải tiến với ❤️
            </p>
        </div>
    </div>

    <!-- Modal for Details -->
    <div class="modal fade" id="detailsModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết KPI</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="detailsContent">
                    <!-- Content will be loaded via AJAX -->
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Charts
        const ratingChart = new Chart(document.getElementById('ratingChart'), {
            type: 'doughnut',
            data: {
                labels: ['Xuất sắc', 'Tốt', 'Khá', 'Trung bình', 'Chưa đánh giá'],
                datasets: [{
                    data: [
                        <?php echo $stats['rating_distribution']['excellent'] ?? 0; ?>,
                        <?php echo $stats['rating_distribution']['good'] ?? 0; ?>,
                        <?php echo $stats['rating_distribution']['average'] ?? 0; ?>,
                        <?php echo $stats['rating_distribution']['poor'] ?? 0; ?>,
                        <?php echo $stats['rating_distribution']['pending'] ?? 0; ?>
                    ],
                    backgroundColor: [
                        '#198754',
                        '#0dcaf0',
                        '#ffc107',
                        '#dc3545',
                        '#6c757d'
                    ],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.raw || 0;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = Math.round((value / total) * 100);
                                return `${label}: ${value} (${percentage}%)`;
                            }
                        }
                    }
                },
                cutout: '60%'
            }
        });

        const departmentChart = new Chart(document.getElementById('departmentChart'), {
            type: 'bar',
            data: {
                labels: <?php echo json_encode(array_column($stats['department_scores'] ?? [], 'department_name')); ?>,
                datasets: [{
                    label: 'Điểm trung bình',
                    data: <?php echo json_encode(array_column($stats['department_scores'] ?? [], 'average_score')); ?>,
                    backgroundColor: '#4361ee',
                    borderRadius: 8,
                    borderSkipped: false,
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        grid: {
                            drawBorder: false
                        },
                        ticks: {
                            callback: function(value) {
                                return value + ' điểm';
                            }
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `Điểm trung bình: ${context.raw} điểm`;
                            }
                        }
                    }
                }
            }
        });

        // View details function
        function viewDetails(userId, cycleId) {
            const modal = new bootstrap.Modal(document.getElementById('detailsModal'));
            
            document.getElementById('detailsContent').innerHTML = `
                <div class="text-center py-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2">Đang tải dữ liệu...</p>
                </div>
            `;
            
            modal.show();
            
            // Simulate AJAX call
            setTimeout(() => {
                document.getElementById('detailsContent').innerHTML = `
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        Tính năng đang được phát triển. Sẽ có trong phiên bản tiếp theo.
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Giảng viên ID:</strong> ${userId}</p>
                            <p><strong>Chu kỳ ID:</strong> ${cycleId}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Ngày xem:</strong> ${new Date().toLocaleDateString('vi-VN')}</p>
                            <p><strong>Thời gian:</strong> ${new Date().toLocaleTimeString('vi-VN')}</p>
                        </div>
                    </div>
                `;
            }, 1500);
        }

        // Export functions
        function exportReport(userId, cycleId) {
            showLoading();
            setTimeout(() => {
                hideLoading();
                alert(`📊 Đã xuất báo cáo cho giảng viên ID: ${userId}, Chu kỳ: ${cycleId}`);
            }, 2000);
        }

        function exportAllResults() {
            showLoading();
            setTimeout(() => {
                hideLoading();
                alert('📥 Đã xuất toàn bộ kết quả ra file Excel');
            }, 2000);
        }

        function exportPDF() {
            showLoading();
            setTimeout(() => {
                hideLoading();
                alert('📄 Đã xuất toàn bộ kết quả ra file PDF');
            }, 2000);
        }

        function printResults() {
            window.print();
        }

        // View mode functions
        function changeViewMode(mode) {
            showLoading();
            const url = new URL(window.location);
            url.searchParams.set('view', mode);
            setTimeout(() => {
                window.location.href = url.toString();
            }, 500);
        }

        function applyFilters() {
            showLoading();
            const cycleId = document.getElementById('cycleSelect').value;
            const departmentId = document.getElementById('departmentSelect')?.value || '';
            const rating = document.getElementById('ratingSelect').value;
            const viewMode = '<?php echo $view_mode; ?>';
            
            let url = `kpi_results.php?cycle_id=${cycleId}&rating=${rating}&view=${viewMode}`;
            if (departmentId) {
                url += `&department_id=${departmentId}`;
            }
            
            setTimeout(() => {
                window.location.href = url;
            }, 500);
        }

        // Loading functions
        function showLoading() {
            document.getElementById('loadingOverlay').classList.add('active');
        }

        function hideLoading() {
            document.getElementById('loadingOverlay').classList.remove('active');
        }

        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            
            if ('<?php echo $view_mode; ?>' === 'grid') {
                // Grid view search
                const cards = document.querySelectorAll('.result-card');
                cards.forEach(card => {
                    const searchText = card.getAttribute('data-search');
                    if (searchText.includes(searchTerm)) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            } else {
                // Table view search
                const rows = document.querySelectorAll('#resultsTable tbody tr');
                rows.forEach(row => {
                    const searchText = row.getAttribute('data-search');
                    if (searchText.includes(searchTerm)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }
        });

        // Sorting functionality for table view
        document.querySelectorAll('.sortable').forEach(header => {
            header.addEventListener('click', function() {
                const table = this.closest('table');
                const tbody = table.querySelector('tbody');
                const rows = Array.from(tbody.querySelectorAll('tr'));
                const index = Array.from(this.parentNode.children).indexOf(this);
                const isAsc = this.classList.contains('asc');
                
                // Remove sort classes from all headers
                document.querySelectorAll('.sortable').forEach(h => {
                    h.classList.remove('asc', 'desc');
                });
                
                // Add sort class to current header
                this.classList.add(isAsc ? 'desc' : 'asc');
                
                // Sort rows
                rows.sort((a, b) => {
                    let aValue, bValue;
                    
                    switch (this.getAttribute('data-sort')) {
                        case 'ranking':
                            aValue = parseInt(a.cells[0].textContent.replace('#', '')) || 0;
                            bValue = parseInt(b.cells[0].textContent.replace('#', '')) || 0;
                            break;
                        case 'name':
                            aValue = a.cells[1].textContent.toLowerCase();
                            bValue = b.cells[1].textContent.toLowerCase();
                            break;
                        case 'department':
                            aValue = a.cells[2].textContent.toLowerCase();
                            bValue = b.cells[2].textContent.toLowerCase();
                            break;
                        case 'teaching':
                            aValue = parseFloat(a.cells[3].textContent) || 0;
                            bValue = parseFloat(b.cells[3].textContent) || 0;
                            break;
                        case 'research':
                            aValue = parseFloat(a.cells[4].textContent) || 0;
                            bValue = parseFloat(b.cells[4].textContent) || 0;
                            break;
                        case 'service':
                            aValue = parseFloat(a.cells[5].textContent) || 0;
                            bValue = parseFloat(b.cells[5].textContent) || 0;
                            break;
                        case 'total':
                            aValue = parseFloat(a.cells[6].textContent) || 0;
                            bValue = parseFloat(b.cells[6].textContent) || 0;
                            break;
                        case 'rating':
                            aValue = a.cells[7].textContent.toLowerCase();
                            bValue = b.cells[7].textContent.toLowerCase();
                            break;
                        default:
                            aValue = a.cells[index].textContent.toLowerCase();
                            bValue = b.cells[index].textContent.toLowerCase();
                    }
                    
                    if (isAsc) {
                        return aValue > bValue ? 1 : -1;
                    } else {
                        return aValue < bValue ? 1 : -1;
                    }
                });
                
                // Re-append sorted rows
                rows.forEach(row => tbody.appendChild(row));
            });
        });

        // Auto-refresh when main filters change
        document.getElementById('cycleSelect').addEventListener('change', applyFilters);
        document.getElementById('departmentSelect')?.addEventListener('change', applyFilters);
        document.getElementById('ratingSelect').addEventListener('change', applyFilters);

        // Add smooth animations
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.stat-card, .result-card');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
            
            // Add print styles
            const style = document.createElement('style');
            style.innerHTML = `
                @media print {
                    .navbar, .filter-card, .footer, .action-buttons, .btn {
                        display: none !important;
                    }
                    .page-header {
                        background: #4361ee !important;
                        -webkit-print-color-adjust: exact;
                    }
                    .main-container {
                        padding: 0 !important;
                    }
                    .stat-card, .chart-container, .table-container {
                        box-shadow: none !important;
                        border: 1px solid #ddd !important;
                    }
                }
            `;
            document.head.appendChild(style);
        });
    </script>
</body>
</html>