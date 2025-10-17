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
                
            </div>
            
            <div class="d-flex align-items-center">
                <!-- Notifications -->
                <div class="dropdown me-3">
                    <a class="position-relative text-white" href="#" role="button" id="notificationDropdown" 
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-bell fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            3
                            <span class="visually-hidden">Thông báo chưa đọc</span>
                        </span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown">
                        <li><h6 class="dropdown-header">Thông báo mới</h6></li>
                        <li>
                            <a class="dropdown-item" href="#">
                                <div class="d-flex">
                                    <div class="flex-shrink-0">
                                        <i class="fas fa-check-circle text-success"></i>
                                    </div>
                                    <div class="flex-grow-1 ms-2">
                                        <div class="fw-bold">KPI đã được duyệt</div>
                                        <small>2 giờ trước</small>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="#">
                                <div class="d-flex">
                                    <div class="flex-shrink-0">
                                        <i class="fas fa-exclamation-triangle text-warning"></i>
                                    </div>
                                    <div class="flex-grow-1 ms-2">
                                        <div class="fw-bold">Cần bổ sung minh chứng</div>
                                        <small>1 ngày trước</small>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-center" href="#">Xem tất cả thông báo</a></li>
                    </ul>
                </div>

                <!-- User Dropdown -->
                <div class="user-dropdown">
                    <a class="dropdown-toggle d-flex align-items-center text-decoration-none" href="#" 
                       role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="user-avatar me-2">
                            <?php 
                            // Hiển thị chữ cái đầu của tên người dùng
                            $name = $_SESSION['full_name'] ?? 'User';
                            $firstLetter = mb_substr($name, 0, 1, 'UTF-8');
                            echo strtoupper($firstLetter);
                            ?>
                        </div>
                        <div class="user-info d-none d-md-block">
                            <div class="user-name text-white fw-bold"><?php echo $_SESSION['full_name']; ?></div>
                            <div class="user-role text-white-50 small">
                                <?php 
                                $role = $_SESSION['role'] ?? 'giangvien';
                                echo ucfirst($role);
                                ?>
                            </div>
                        </div>
                        <i class="fas fa-caret-down text-white ms-2"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li>
                            <a class="dropdown-item" href="../giangvien/profile.php">
                                <i class="fas fa-user-circle me-2"></i> Hồ sơ cá nhân
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="../giangvien/settings.php">
                                <i class="fas fa-cog me-2"></i> Cài đặt
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