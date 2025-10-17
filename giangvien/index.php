<?php
require_once '../includes/config.php';
require_once '../includes/auth.php';

redirectIfNotLoggedIn();
checkPermission(['giangvien']);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Giảng viên - Hệ thống KPI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="../css/dashboard.css" rel="stylesheet">
    <link href="../css/giangvien.css" rel="stylesheet">
    <style>
        /* CSS cho sidebar và layout mới */
        
        .dashboard-container {
            margin-left: 280px;
            margin-top: 70px;
            padding: 25px;
            transition: all 0.3s ease;
            min-height: calc(100vh - 70px);
            background: #f8f9fa;
        }
        
        
    </style>
</head>
<body>
    <?php include '../includes/header.php'; ?>
    <?php include '../includes/sidebar.php'; ?>

    <!-- Main Content -->
    <div class="dashboard-container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-content">
                <h1 class="welcome-title">Chào mừng trở lại, <span class="text-primary"><?php echo $_SESSION['full_name']; ?></span>!</h1>
                <p class="welcome-subtitle">Đây là tổng quan hiệu suất và công việc của bạn</p>
                <div class="welcome-meta">
                    <span class="meta-item">
                        <i class="fas fa-calendar-alt me-2"></i>
                        <?php echo date('d/m/Y'); ?>
                    </span>
                    <span class="meta-item">
                        <i class="fas fa-building me-2"></i>
                        <?php
                        $stmt = $pdo->prepare("SELECT department_name FROM departments WHERE id = ?");
                        $stmt->execute([$_SESSION['department_id']]);
                        $department = $stmt->fetch();
                        echo $department ? $department['department_name'] : 'Chưa phân khoa';
                        ?>
                    </span>
                </div>
            </div>
            <div class="welcome-actions">
                <a href="kpi_submission.php" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Nhập KPI mới
                </a>
            </div>
        </div>
<!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card primary">
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-number">85%</div>
                    <div class="stat-label">Hoàn thành KPI</div>
                    <div class="progress-container">
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 85%"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="stat-card success">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-number">24</div>
                    <div class="stat-label">Tiêu chí đã duyệt</div>
                    <div class="stat-trend trend-up">
                        <i class="fas fa-arrow-up me-1"></i> 15% so với kỳ trước
                    </div>
                </div>
            </div>

            <div class="stat-card warning">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-number">5</div>
                    <div class="stat-label">Đang chờ duyệt</div>
                    <div class="stat-trend trend-neutral">
                        <i class="fas fa-minus me-1"></i> Cần bổ sung minh chứng
                    </div>
                </div>
            </div>

            <div class="stat-card info">
                <div class="stat-icon">
                    <i class="fas fa-target"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-number">92</div>
                    <div class="stat-label">Điểm trung bình</div>
                    <div class="stat-trend trend-up">
                        <i class="fas fa-arrow-up me-1"></i> Xuất sắc
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Grid -->
        <div class="content-grid">
            <!-- Left Column -->
            <div class="content-column">
                <!-- Quick Actions -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-bolt me-2"></i>Thao tác nhanh
                        </h3>
                    </div>
                    <div class="card-body">
                        <div class="quick-actions">
                            <a href="kpi_submission.php" class="action-btn primary">
                                <div class="action-icon">
                                    <i class="fas fa-upload"></i>
                                </div>
                                <div class="action-text">
                                    <div class="action-title">Nhập KPI</div>
                                    <div class="action-desc">Cập nhật minh chứng mới</div>
                                </div>
                            </a>

                            <a href="teaching_schedule.php" class="action-btn info">
                                <div class="action-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <div class="action-text">
                                    <div class="action-title">Lịch giảng dạy</div>
                                    <div class="action-desc">Quản lý lịch trình & bài tập</div>
                                </div>
                            </a>

                            <a href="my_reports.php" class="action-btn success">
                                <div class="action-icon">
                                    <i class="fas fa-chart-bar"></i>
                                </div>
                                <div class="action-text">
                                    <div class="action-title">Xem báo cáo</div>
                                    <div class="action-desc">Kết quả đánh giá chi tiết</div>
                                </div>
                            </a>

                            <a href="#" class="action-btn warning">
                                <div class="action-icon">
                                    <i class="fas fa-file-export"></i>
                                </div>
                                <div class="action-text">
                                    <div class="action-title">Xuất báo cáo</div>
                                    <div class="action-desc">PDF, Excel, Word</div>
                                </div>
                            </a>

                            <a href="#" class="action-btn secondary">
                                <div class="action-icon">
                                    <i class="fas fa-bell"></i>
                                </div>
                                <div class="action-text">
                                    <div class="action-title">Thông báo</div>
                                    <div class="action-desc">Tin nhắn từ trưởng khoa</div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Recent KPI Submissions -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-history me-2"></i>KPI gần đây
                        </h3>
                        <a href="kpi_submission.php" class="card-link">Xem tất cả</a>
                    </div>
                    <div class="card-body">
                        <div class="kpi-list">
                            <?php
                            // Lấy dữ liệu KPI gần đây của giảng viên
                            $stmt = $pdo->prepare("
                                SELECT lkd.*, ki.indicator_name, ec.cycle_name 
                                FROM lecturer_kpi_data lkd 
                                JOIN kpi_indicators ki ON lkd.kpi_indicator_id = ki.id 
                                JOIN evaluation_cycles ec ON lkd.evaluation_cycle_id = ec.id 
                                WHERE lkd.user_id = ? 
                                ORDER BY lkd.created_at DESC 
                                LIMIT 5
                            ");
                            $stmt->execute([$_SESSION['user_id']]);
                            $recent_kpis = $stmt->fetchAll();

                            if (empty($recent_kpis)) {
                                echo '<div class="empty-state">';
                                echo '<i class="fas fa-inbox fa-3x mb-3 text-muted"></i>';
                                echo '<p>Chưa có KPI nào được nhập</p>';
                                echo '<a href="kpi_submission.php" class="btn btn-primary">Bắt đầu nhập KPI</a>';
                                echo '</div>';
                            } else {
                                foreach ($recent_kpis as $kpi) {
                                    $status_class = '';
                                    switch ($kpi['status']) {
                                        case 'approved': $status_class = 'status-approved'; break;
                                        case 'pending': $status_class = 'status-pending'; break;
                                        case 'rejected': $status_class = 'status-rejected'; break;
                                        default: $status_class = 'status-draft';
                                    }
                                    ?>
                                    <div class="kpi-item">
                                        <div class="kpi-info">
                                            <div class="kpi-name"><?php echo htmlspecialchars($kpi['indicator_name']); ?></div>
                                            <div class="kpi-meta">
                                                <span class="cycle"><?php echo htmlspecialchars($kpi['cycle_name']); ?></span>
                                                <span class="score">Điểm: <?php echo $kpi['final_score'] ?: $kpi['auto_calculated_score']; ?></span>
                                            </div>
                                        </div>
                                        <div class="kpi-status">
                                            <span class="status-badge <?php echo $status_class; ?>">
                                                <?php
                                                $status_text = [
                                                    'draft' => 'Nháp',
                                                    'pending' => 'Chờ duyệt', 
                                                    'approved' => 'Đã duyệt',
                                                    'rejected' => 'Từ chối'
                                                ];
                                                echo $status_text[$kpi['status']];
                                                ?>
                                            </span>
                                        </div>
                                    </div>
                                    <?php
                                }
                            }
                            ?>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column -->
            <div class="content-column">
                <!-- KPI Progress -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-tasks me-2"></i>Tiến độ KPI
                        </h3>
                    </div>
                    <div class="card-body">
                        <div class="progress-list">
                            <div class="progress-item">
                                <div class="progress-label">
                                    <span>Giảng dạy</span>
                                    <span>45/50 điểm</span>
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill teaching" style="width: 90%"></div>
                                </div>
                            </div>

                            <div class="progress-item">
                                <div class="progress-label">
                                    <span>Nghiên cứu khoa học</span>
                                    <span>35/40 điểm</span>
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill research" style="width: 88%"></div>
                                </div>
                            </div>

                            <div class="progress-item">
                                <div class="progress-label">
                                    <span>Phục vụ</span>
                                    <span>12/10 điểm</span>
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill service" style="width: 120%"></div>
                                </div>
                            </div>
                        </div>

                        <div class="progress-summary">
                            <div class="summary-item">
                                <div class="summary-value">92%</div>
                                <div class="summary-label">Tổng hoàn thành</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-value">A+</div>
                                <div class="summary-label">Xếp loại</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-value">#3</div>
                                <div class="summary-label">Xếp hạng khoa</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Notifications -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-bell me-2"></i>Thông báo mới
                        </h3>
                        <a href="#" class="card-link">Đánh dấu đã đọc</a>
                    </div>
                    <div class="card-body">
                        <div class="notifications-list">
                            <div class="notification-item unread">
                                <div class="notification-icon">
                                    <i class="fas fa-check-circle text-success"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-title">KPI đã được duyệt</div>
                                    <div class="notification-desc">Tiêu chí "Số giờ giảng" đã được trưởng khoa phê duyệt</div>
                                    <div class="notification-time">2 giờ trước</div>
                                </div>
                            </div>

                            <div class="notification-item">
                                <div class="notification-icon">
                                    <i class="fas fa-exclamation-triangle text-warning"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-title">Cần bổ sung minh chứng</div>
                                    <div class="notification-desc">Vui lòng bổ sung minh chứng cho tiêu chí nghiên cứu khoa học</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </div>

                            <div class="notification-item">
                                <div class="notification-icon">
                                    <i class="fas fa-info-circle text-info"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-title">Hạn nộp KPI</div>
                                    <div class="notification-desc">Còn 5 ngày để hoàn thành nhập liệu KPI học kỳ 1</div>
                                    <div class="notification-time">3 ngày trước</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upcoming Deadlines -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-calendar-day me-2"></i>Sắp đến hạn
                        </h3>
                    </div>
                    <div class="card-body">
                        <div class="deadlines-list">
                            <div class="deadline-item urgent">
                                <div class="deadline-date">
                                    <div class="date-day">15</div>
                                    <div class="date-month">TH12</div>
                                </div>
                                <div class="deadline-content">
                                    <div class="deadline-title">Hạn nộp KPI HK1</div>
                                    <div class="deadline-desc">Hoàn thành nhập minh chứng</div>
                                </div>
                            </div>

                            <div class="deadline-item">
                                <div class="deadline-date">
                                    <div class="date-day">20</div>
                                    <div class="date-month">TH12</div>
                                </div>
                                <div class="deadline-content">
                                    <div class="deadline-title">Họp tổng kết</div>
                                    <div class="deadline-desc">Phòng họp A1 - 14:00</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
         <?php include '../includes/footer.php'; ?>
</div> <!-- Kết thúc dashboard-container -->
           
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // JavaScript cho toggle sidebar
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.body.classList.toggle('collapsed');
        });

        // JavaScript cho mobile menu
        document.getElementById('mobileMenuToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('mobile-open');
        });

        // Đóng sidebar khi click ra ngoài trên mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.querySelector('.sidebar');
            const mobileToggle = document.getElementById('mobileMenuToggle');
            
            if (window.innerWidth <= 768 && 
                !sidebar.contains(event.target) && 
                !mobileToggle.contains(event.target)) {
                sidebar.classList.remove('mobile-open');
            }
        });
    </script>
    <script src="../js/giangvien.js"></script>
    <script src="../js/sidebar.js"></script>
    </body>
    </html>
    
