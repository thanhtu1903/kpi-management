<?php
require_once '../includes/config.php';
require_once '../includes/auth.php';
require_once '../includes/header.php';


redirectIfNotLoggedIn();
checkPermission(['admin']);



?>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1><i class="fas fa-tachometer-alt me-2"></i>Dashboard Quản trị</h1>
            </div>
        </div>
    </div>

    <!-- Thống kê tổng quan -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                Tổng giảng viên</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <?php
                                $stmt = $pdo->query("SELECT COUNT(*) FROM users WHERE user_type = 'giangvien' AND is_active = 1");
                                echo $stmt->fetchColumn();
                                ?>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-users fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Tổng khoa/bộ môn</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <?php
                                $stmt = $pdo->query("SELECT COUNT(*) FROM departments WHERE is_active = 1");
                                echo $stmt->fetchColumn();
                                ?>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-building fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                Đợt đánh giá đang hoạt động</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <?php
                                $stmt = $pdo->query("SELECT COUNT(*) FROM evaluation_cycles WHERE status = 'active'");
                                echo $stmt->fetchColumn();
                                ?>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-calendar-alt fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                KPI chờ duyệt</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <?php
                                $stmt = $pdo->query("SELECT COUNT(*) FROM lecturer_kpi_data WHERE status = 'pending'");
                                echo $stmt->fetchColumn();
                                ?>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clock fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row">
        <div class="col-lg-4 mb-4">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0"><i class="fas fa-cog me-2"></i>Quản lý hệ thống</h5>
                </div>
                <div class="card-body">
                    <div class="list-group">
                        <a href="users.php" class="list-group-item list-group-item-action">
                            <i class="fas fa-users me-2"></i>Quản lý người dùng
                        </a>
                        <a href="departments.php" class="list-group-item list-group-item-action">
                            <i class="fas fa-building me-2"></i>Quản lý khoa
                        </a>
                        <a href="kpi_settings.php" class="list-group-item list-group-item-action">
                            <i class="fas fa-chart-line me-2"></i>Cài đặt KPI
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="card-title mb-0"><i class="fas fa-bell me-2"></i>Thông báo gần đây</h5>
                </div>
                <div class="card-body">
                    <?php
                    $stmt = $pdo->query("SELECT * FROM notifications ORDER BY created_at DESC LIMIT 5");
                    $notifications = $stmt->fetchAll();
                    
                    if (empty($notifications)) {
                        echo '<p class="text-muted">Chưa có thông báo nào.</p>';
                    } else {
                        foreach ($notifications as $notification) {
                            echo '<div class="alert alert-light border">';
                            echo '<h6>' . htmlspecialchars($notification['title']) . '</h6>';
                            echo '<p class="mb-1 small">' . substr($notification['content'], 0, 100) . '...</p>';
                            echo '<small class="text-muted">' . $notification['created_at'] . '</small>';
                            echo '</div>';
                        }
                    }
                    ?>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once '../includes/footer.php'; ?>