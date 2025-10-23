<?php
require_once '../includes/config.php';
require_once '../includes/headeradmin.php';
require_once '../includes/sidebaradmin.php';

// Kết nối database


try {
    // Tổng số người dùng
    $stmt = $pdo->query("SELECT COUNT(*) as total_users FROM users WHERE is_active = 1");
    $total_users = $stmt->fetch(PDO::FETCH_ASSOC)['total_users'];

    // Tổng số khoa/bộ môn
    $stmt = $pdo->query("SELECT COUNT(*) as total_departments FROM departments WHERE is_active = 1");
    $total_departments = $stmt->fetch(PDO::FETCH_ASSOC)['total_departments'];

    // Kỳ đánh giá đang chạy (status = 'active' hoặc 'in_progress')
    $stmt = $pdo->query("SELECT COUNT(*) as active_cycles FROM evaluation_cycles WHERE status IN ('active', 'in_progress')");
    $active_cycles = $stmt->fetch(PDO::FETCH_ASSOC)['active_cycles'];

    // KPI chờ duyệt
    $stmt = $pdo->query("SELECT COUNT(*) as pending_kpi FROM lecturer_kpi_data WHERE status = 'pending'");
    $pending_kpi = $stmt->fetch(PDO::FETCH_ASSOC)['pending_kpi'];

    // Số lượng giảng viên
    $stmt = $pdo->query("SELECT COUNT(*) as total_lecturers FROM users WHERE user_type = 'giangvien' AND is_active = 1");
    $total_lecturers = $stmt->fetch(PDO::FETCH_ASSOC)['total_lecturers'];

    // Số lượng chỉ số KPI
    $stmt = $pdo->query("SELECT COUNT(*) as total_indicators FROM kpi_indicators WHERE is_active = 1");
    $total_indicators = $stmt->fetch(PDO::FETCH_ASSOC)['total_indicators'];

    // Số lượng kỳ đánh giá
    $stmt = $pdo->query("SELECT COUNT(*) as total_evaluation_cycles FROM evaluation_cycles");
    $total_evaluation_cycles = $stmt->fetch(PDO::FETCH_ASSOC)['total_evaluation_cycles'];

    // Hoạt động gần đây (lấy 10 bản ghi mới nhất)
    $stmt = $pdo->query("
        SELECT al.created_at, u.full_name, al.action, al.description 
        FROM activity_logs al 
        LEFT JOIN users u ON al.user_id = u.id 
        ORDER BY al.created_at DESC 
        LIMIT 10
    ");
    $recent_activities = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    // Xử lý lỗi
    $error = "Lỗi kết nối database: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Quản trị - KPI System</title>
    <style>
        .page-header {
            padding-top: 20px;
        }
        
        .stat-card {
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .activity-table tbody tr {
            transition: background-color 0.3s ease;
        }
        
        .activity-table tbody tr:hover {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="container-fluid">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">Dashboard Quản trị</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                </nav>
            </div>

            <!-- Hiển thị lỗi nếu có -->
            <?php if (isset($error)): ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Lỗi!</strong> <?php echo $error; ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <!-- Statistics Cards -->
            <div class="row">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2 stat-card">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                        Tổng người dùng</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                        <?php echo number_format($total_users ?? 0); ?>
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
                    <div class="card border-left-success shadow h-100 py-2 stat-card">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                        Tổng khoa/bộ môn</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                        <?php echo number_format($total_departments ?? 0); ?>
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
                    <div class="card border-left-info shadow h-100 py-2 stat-card">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                        Kỳ đánh giá đang chạy</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                        <?php echo number_format($active_cycles ?? 0); ?>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-warning shadow h-100 py-2 stat-card">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                        KPI chờ duyệt</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                        <?php echo number_format($pending_kpi ?? 0); ?>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-chart-line fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="row">
                <div class="col-lg-8">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex justify-content-between align-items-center">
                            <h6 class="m-0 font-weight-bold text-primary">Hoạt động gần đây</h6>
                            <small class="text-muted">10 hoạt động mới nhất</small>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered activity-table" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Thời gian</th>
                                            <th>Người dùng</th>
                                            <th>Hành động</th>
                                            <th>Mô tả</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (isset($recent_activities) && count($recent_activities) > 0): ?>
                                            <?php foreach ($recent_activities as $activity): ?>
                                                <tr>
                                                    <td><?php echo date('d/m/Y H:i', strtotime($activity['created_at'])); ?></td>
                                                    <td><?php echo htmlspecialchars($activity['full_name'] ?? 'N/A'); ?></td>
                                                    <td>
                                                        <span class="badge 
                                                            <?php 
                                                            $action = strtolower($activity['action']);
                                                            if (strpos($action, 'login') !== false) echo 'bg-success';
                                                            elseif (strpos($action, 'submit') !== false) echo 'bg-primary';
                                                            elseif (strpos($action, 'update') !== false) echo 'bg-warning';
                                                            elseif (strpos($action, 'delete') !== false) echo 'bg-danger';
                                                            else echo 'bg-secondary';
                                                            ?>">
                                                            <?php echo htmlspecialchars($activity['action']); ?>
                                                        </span>
                                                    </td>
                                                    <td><?php echo htmlspecialchars($activity['description'] ?? 'Không có mô tả'); ?></td>
                                                </tr>
                                            <?php endforeach; ?>
                                        <?php else: ?>
                                            <tr>
                                                <td colspan="4" class="text-center text-muted py-3">
                                                    <i class="fas fa-info-circle me-2"></i>Không có hoạt động nào gần đây
                                                </td>
                                            </tr>
                                        <?php endif; ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Thống kê nhanh</h6>
                        </div>
                        <div class="card-body">
                            <div class="list-group list-group-flush">
                                <a href="../admin/users/index.php" class="list-group-item list-group-item-action">
                                    <div class="d-flex w-100 justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Giảng viên</h6>
                                            <small class="text-muted">Tổng số giảng viên trong hệ thống</small>
                                        </div>
                                        <span class="badge bg-primary rounded-pill"><?php echo number_format($total_lecturers ?? 0); ?></span>
                                    </div>
                                </a>
                                <a href="../admin/departments/index.php" class="list-group-item list-group-item-action">
                                    <div class="d-flex w-100 justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Khoa/Bộ môn</h6>
                                            <small class="text-muted">Đơn vị đào tạo và quản lý</small>
                                        </div>
                                        <span class="badge bg-success rounded-pill"><?php echo number_format($total_departments ?? 0); ?></span>
                                    </div>
                                </a>
                                <a href="../admin/kpi/indicators.php" class="list-group-item list-group-item-action">
                                    <div class="d-flex w-100 justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Chỉ số KPI</h6>
                                            <small class="text-muted">Tiêu chí đánh giá giảng viên</small>
                                        </div>
                                        <span class="badge bg-info rounded-pill"><?php echo number_format($total_indicators ?? 0); ?></span>
                                    </div>
                                </a>
                                <a href="../admin/evaluation/cycles.php" class="list-group-item list-group-item-action">
                                    <div class="d-flex w-100 justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Kỳ đánh giá</h6>
                                            <small class="text-muted">Đợt đánh giá KPI</small>
                                        </div>
                                        <span class="badge bg-warning rounded-pill"><?php echo number_format($total_evaluation_cycles ?? 0); ?></span>
                                    </div>
                                </a>
                            </div>
                            
                            <!-- Thêm phần thống kê phụ -->
                            <div class="mt-4 pt-3 border-top">
                                <h6 class="text-muted mb-3">Thống kê bổ sung</h6>
                                <div class="row text-center">
                                    <div class="col-6 mb-3">
                                        <div class="border rounded p-2">
                                            <small class="text-muted d-block">KPI đã duyệt</small>
                                            <strong class="text-success">
                                                <?php 
                                                $stmt = $pdo->query("SELECT COUNT(*) as approved FROM lecturer_kpi_data WHERE status = 'approved'");
                                                echo number_format($stmt->fetch(PDO::FETCH_ASSOC)['approved'] ?? 0);
                                                ?>
                                            </strong>
                                        </div>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <div class="border rounded p-2">
                                            <small class="text-muted d-block">KPI bị từ chối</small>
                                            <strong class="text-danger">
                                                <?php 
                                                $stmt = $pdo->query("SELECT COUNT(*) as rejected FROM lecturer_kpi_data WHERE status = 'rejected'");
                                                echo number_format($stmt->fetch(PDO::FETCH_ASSOC)['rejected'] ?? 0);
                                                ?>
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Auto-refresh dashboard mỗi 5 phút
        setTimeout(function() {
            window.location.reload();
        }, 300000); // 5 phút

        // Thêm hiệu ứng cho các card thống kê
        document.addEventListener('DOMContentLoaded', function() {
            const statCards = document.querySelectorAll('.stat-card');
            statCards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
        });
    </script>

    <?php require_once '../includes/footer.php'; ?>
</body>
</html>