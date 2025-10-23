<?php
// Kiểm tra xem người dùng đã đăng nhập chưa
if (!isset($_SESSION['user_id'])) {
    header('Location: ../login.php');
    exit();
}
?>
<!-- Header -->
<link rel="stylesheet" href="../css/header.css">
<div class="header">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <!-- Page Title -->
                <h4 class="page-title mb-0 text-white">
                    <?php 
                    // Dynamic page title based on current page
                    $pageTitles = [
                        'index.php' => 'Dashboard Quản trị',
                        'users.php' => 'Quản lý Người dùng',
                        'departments.php' => 'Quản lý Khoa/Bộ môn',
                        'kpi_groups.php' => 'Nhóm KPI',
                        'kpi_indicators.php' => 'Chỉ số KPI',
                        'evaluation_cycles.php' => 'Kỳ đánh giá',
                        // Add more page titles as needed
                    ];
                    $currentPage = basename($_SERVER['PHP_SELF']);
                    echo $pageTitles[$currentPage] ?? 'KPI System Admin';
                    ?>
                </h4>
            </div>
            
            <div class="d-flex align-items-center">
                <!-- Notifications -->
                <div class="dropdown notification-dropdown me-3">
                    <a class="dropdown-toggle text-white position-relative" href="#" role="button" 
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-bell fs-5"></i>
                        <span class="notification-badge badge rounded-pill">3</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown">
                        <li class="dropdown-header">Thông báo mới</li>
                        <li>
                            <a class="dropdown-item" href="#">
                                <div class="d-flex align-items-center">
                                    <div class="notification-icon success">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-title">KPI đã được duyệt</div>
                                        <div class="notification-time">2 giờ trước</div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="#">
                                <div class="d-flex align-items-center">
                                    <div class="notification-icon warning">
                                        <i class="fas fa-exclamation-triangle"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-title">Cần bổ sung minh chứng</div>
                                        <div class="notification-time">1 ngày trước</div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="#">
                                <div class="d-flex align-items-center">
                                    <div class="notification-icon info">
                                        <i class="fas fa-info-circle"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-title">Kỳ đánh giá mới đã bắt đầu</div>
                                        <div class="notification-time">2 ngày trước</div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-center text-primary" href="#">Xem tất cả thông báo</a></li>
                    </ul>
                </div>

                <!-- User Dropdown -->
                <div class="dropdown user-dropdown">
                    <a class="dropdown-toggle d-flex align-items-center text-decoration-none" href="#" 
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="user-avatar me-2">
                            <?php 
                            // Hiển thị chữ cái đầu của tên người dùng
                            $name = $_SESSION['full_name'] ?? 'Admin';
                            $firstLetter = mb_substr($name, 0, 1, 'UTF-8');
                            echo strtoupper($firstLetter);
                            ?>
                        </div>
                        <div class="user-info d-none d-md-block">
                            <div class="user-name text-white fw-bold"><?php echo $_SESSION['full_name'] ?? 'Admin'; ?></div>
                            <div class="user-role text-white-50 small">
                                <?php 
                                $role = $_SESSION['user_type'] ?? 'admin';
                                echo ucfirst($role);
                                ?>
                            </div>
                        </div>
                        <i class="fas fa-caret-down text-white ms-2"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <a class="dropdown-item" href="../admin/profile.php">
                                <i class="fas fa-user-circle me-2"></i> Hồ sơ cá nhân
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="../admin/settings.php">
                                <i class="fas fa-cog me-2"></i> Cài đặt
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="../admin/notifications.php">
                                <i class="fas fa-bell me-2"></i> Quản lý thông báo
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="../logout.php">
                                <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>