<?php
// Kiểm tra quyền truy cập
if (!isset($_SESSION['user_id']) || $_SESSION['user_type'] != 'admin') {
    header('Location: ../login.php');
    exit();
}

// Xác định trang hiện tại chính xác hơn
$current_script = $_SERVER['PHP_SELF'];
$current_path = parse_url($current_script, PHP_URL_PATH);
$current_page = basename($current_script);

// Hàm kiểm tra đường dẫn hiện tại
function isCurrentPage($paths) {
    global $current_script;
    foreach ($paths as $path) {
        if (strpos($current_script, $path) !== false) {
            return true;
        }
    }
    return false;
}

// Hàm kiểm tra trang chính xác
function isExactPage($page_name) {
    global $current_page;
    return $current_page === $page_name;
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sidebar Admin</title>
    <link rel="stylesheet" href="../css/sidebaradmin.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="text-center py-3">
                <div class="sidebar-logo mb-2">
                    <i class="fas fa-cogs fa-2x text-white"></i>
                </div>
                <h4 class="text-white mb-0">KPI SYSTEM</h4>
                <small class="text-white-50">Quản trị hệ thống</small>
            </div>
        </div>

        <ul class="nav flex-column sidebar-menu">
            <!-- Dashboard -->
            <li class="nav-item">
                <a class="nav-link <?= isExactPage('index.php') && strpos($current_script, '/admin/') !== false ? 'active' : '' ?>" href="../admin/index.php">
                    <i class="fas fa-tachometer-alt"></i><span>Dashboard</span>
                </a>
            </li>

            <!-- Quản lý người dùng -->
            <li class="nav-item has-submenu <?= isCurrentPage(['/admin/index.php', '/admin/users.php']) ? 'active' : '' ?>">
                <a href="#" class="nav-link">
                    <i class="fas fa-users"></i><span>Quản lý người dùng</span><i class="fas fa-chevron-down arrow"></i>
                </a>
                <ul class="submenu">
                    <li><a class="submenu-link <?= isExactPage('index.php') && strpos($current_script, '/admin/') !== false && !strpos($current_script, '/admin/departments/') ? 'active' : '' ?>" href="../admin/index.php">Danh sách người dùng</a></li>
                    <li><a class="submenu-link <?= isExactPage('users.php') ? 'active' : '' ?>" href="../admin/users.php">Thêm người dùng</a></li>
                </ul>
            </li>

            <!-- Quản lý Khoa -->
            <li class="nav-item has-submenu <?= isCurrentPage(['/admin/departments/']) ? 'active' : '' ?>">
                <a href="#" class="nav-link">
                    <i class="fas fa-building"></i><span>Quản lý Khoa</span><i class="fas fa-chevron-down arrow"></i>
                </a>
                <ul class="submenu">
                    <li><a class="submenu-link <?= isExactPage('index.php') && strpos($current_script, '/admin/departments/') !== false ? 'active' : '' ?>" href="../admin/departments/index.php">Danh sách khoa</a></li>
                    <li><a class="submenu-link <?= isExactPage('heads.php') ? 'active' : '' ?>" href="../admin/departments/heads.php">Trưởng khoa</a></li>
                    <li><a class="submenu-link <?= isExactPage('kpis.php') ? 'active' : '' ?>" href="../admin/departments/kpis.php">KPI khoa</a></li>
                </ul>
            </li>

            <!-- Quản lý KPI -->
            <li class="nav-item has-submenu <?= isCurrentPage(['/admin/kpi/']) ? 'active' : '' ?>">
                <a href="#" class="nav-link">
                    <i class="fas fa-chart-line"></i><span>Quản lý KPI</span><i class="fas fa-chevron-down arrow"></i>
                </a>
                <ul class="submenu">
                    <li><a class="submenu-link <?= isExactPage('groups.php') ? 'active' : '' ?>" href="../admin/kpi/groups.php">Nhóm KPI</a></li>
                    <li><a class="submenu-link <?= isExactPage('indicators.php') ? 'active' : '' ?>" href="../admin/kpi/indicators.php">Chỉ số KPI</a></li>
                    <li><a class="submenu-link <?= isExactPage('summaries.php') ? 'active' : '' ?>" href="../admin/kpi/summaries.php">Tổng hợp KPI</a></li>
                </ul>
            </li>

            <!-- Đánh giá -->
            <li class="nav-item has-submenu <?= isCurrentPage(['/admin/evaluation/']) ? 'active' : '' ?>">
                <a href="#" class="nav-link">
                    <i class="fas fa-clipboard-check"></i><span>Đánh giá</span><i class="fas fa-chevron-down arrow"></i>
                </a>
                <ul class="submenu">
                    <li><a class="submenu-link <?= isExactPage('cycles.php') ? 'active' : '' ?>" href="../admin/evaluation/cycles.php">Kỳ đánh giá</a></li>
                    <li><a class="submenu-link <?= isExactPage('data.php') ? 'active' : '' ?>" href="../admin/evaluation/data.php">Dữ liệu đánh giá</a></li>
                </ul>
            </li>

            <!-- Đào tạo -->
            <li class="nav-item has-submenu <?= isCurrentPage(['/admin/training/']) ? 'active' : '' ?>">
                <a href="#" class="nav-link">
                    <i class="fas fa-graduation-cap"></i><span>Đào tạo</span><i class="fas fa-chevron-down arrow"></i>
                </a>
                <ul class="submenu">
                    <li><a class="submenu-link <?= isExactPage('programs.php') ? 'active' : '' ?>" href="../admin/training/programs.php">Chương trình đào tạo</a></li>
                    <li><a class="submenu-link <?= isExactPage('subjects.php') ? 'active' : '' ?>" href="../admin/training/subjects.php">Môn học</a></li>
                    <li><a class="submenu-link <?= isExactPage('curriculum.php') ? 'active' : '' ?>" href="../admin/training/curriculum.php">Khung chương trình</a></li>
                </ul>
            </li>

            <!-- Hệ thống -->
            <li class="nav-item has-submenu <?= isCurrentPage(['/admin/system/']) ? 'active' : '' ?>">
                <a href="#" class="nav-link">
                    <i class="fas fa-cog"></i><span>Hệ thống</span><i class="fas fa-chevron-down arrow"></i>
                </a>
                <ul class="submenu">
                    <li><a class="submenu-link <?= isExactPage('settings.php') ? 'active' : '' ?>" href="../admin/system/settings.php">Cài đặt</a></li>
                    <li><a class="submenu-link <?= isExactPage('notifications.php') ? 'active' : '' ?>" href="../admin/system/notifications.php">Thông báo</a></li>
                    <li><a class="submenu-link <?= isExactPage('logs.php') ? 'active' : '' ?>" href="../admin/system/logs.php">Nhật ký</a></li>
                </ul>
            </li>
        </ul>

        <div class="sidebar-footer mt-auto p-3 text-center text-white-50">
            © 2024 KPI System
        </div>
    </div>

    <button class="toggle-btn" id="sidebarToggle"><i class="fas fa-bars"></i></button>

    <script>
        document.getElementById('sidebarToggle').addEventListener('click', () => {
            document.getElementById('sidebar').classList.toggle('collapsed');
        });

        // Hiệu ứng mở submenu
        document.querySelectorAll('.has-submenu > .nav-link').forEach(link => {
            link.addEventListener('click', e => {
                e.preventDefault();
                const parent = link.parentElement;
                parent.classList.toggle('active');
            });
        });

        // Tự động mở submenu khi trang hiện tại nằm trong submenu đó
        document.addEventListener('DOMContentLoaded', function() {
            const activeSubmenuLinks = document.querySelectorAll('.submenu-link.active');
            activeSubmenuLinks.forEach(link => {
                const submenu = link.closest('.submenu');
                const parentItem = link.closest('.has-submenu');
                if (submenu && parentItem) {
                    parentItem.classList.add('active');
                    submenu.style.maxHeight = '500px';
                    submenu.style.opacity = '1';
                }
            });

            // Tự động mở submenu có item active
            const activeParentItems = document.querySelectorAll('.has-submenu.active');
            activeParentItems.forEach(item => {
                const submenu = item.querySelector('.submenu');
                if (submenu) {
                    submenu.style.maxHeight = '500px';
                    submenu.style.opacity = '1';
                }
            });
        });
    </script>
</body>
</html>