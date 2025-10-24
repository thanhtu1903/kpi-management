<?php
// Kiểm tra xem người dùng đã đăng nhập chưa
if (!isset($_SESSION['user_id'])) {
    header('Location: ../login.php');
    exit();
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/headeradmin.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <div class="header" id="header">
        <div class="container-fluid">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <!-- Sidebar Toggle Button for Mobile -->
                    <button class="btn btn-sm btn-outline-light me-3 d-lg-none" id="mobileSidebarToggle">
                        <i class="fas fa-bars"></i>
                    </button>
                    
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Header functionality
        document.addEventListener('DOMContentLoaded', function() {
            const header = document.getElementById('header');
            const sidebar = document.getElementById('sidebar');
            
            // Function to update header position based on sidebar state
            function updateHeaderPosition() {
                if (sidebar.classList.contains('collapsed')) {
                    header.style.marginLeft = '70px';
                    header.style.width = 'calc(100% - 70px)';
                } else {
                    header.style.marginLeft = '280px';
                    header.style.width = 'calc(100% - 280px)';
                }
            }
            
            // Initialize header position
            updateHeaderPosition();
            
            // Observe sidebar for changes
            const observer = new MutationObserver(function(mutations) {
                mutations.forEach(function(mutation) {
                    if (mutation.attributeName === 'class') {
                        updateHeaderPosition();
                    }
                });
            });
            
            observer.observe(sidebar, {
                attributes: true,
                attributeFilter: ['class']
            });
            
            // Mobile sidebar toggle
            document.getElementById('mobileSidebarToggle').addEventListener('click', function() {
                sidebar.classList.toggle('mobile-show');
            });
            
            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(e) {
                if (window.innerWidth < 992 && !sidebar.contains(e.target) && 
                    !e.target.closest('#mobileSidebarToggle') && 
                    sidebar.classList.contains('mobile-show')) {
                    sidebar.classList.remove('mobile-show');
                }
            });
            
            // Handle window resize
            function handleResize() {
                if (window.innerWidth < 992) {
                    header.style.marginLeft = '0';
                    header.style.width = '100%';
                } else {
                    updateHeaderPosition();
                }
            }
            
            window.addEventListener('resize', handleResize);
            handleResize();
            
            // Notification dropdown auto-close when clicking outside
            document.addEventListener('click', function(e) {
                const notificationDropdown = document.querySelector('.notification-dropdown');
                if (!notificationDropdown.contains(e.target)) {
                    const dropdown = bootstrap.Dropdown.getInstance(notificationDropdown.querySelector('.dropdown-toggle'));
                    if (dropdown) {
                        dropdown.hide();
                    }
                }
            });

            // User dropdown auto-close when clicking outside
            document.addEventListener('click', function(e) {
                const userDropdown = document.querySelector('.user-dropdown');
                if (!userDropdown.contains(e.target)) {
                    const dropdown = bootstrap.Dropdown.getInstance(userDropdown.querySelector('.dropdown-toggle'));
                    if (dropdown) {
                        dropdown.hide();
                    }
                }
            });

            // Mark notifications as read
            document.querySelectorAll('.notification-dropdown .dropdown-item').forEach(item => {
                item.addEventListener('click', function() {
                    const badge = document.querySelector('.notification-badge');
                    let count = parseInt(badge.textContent);
                    if (count > 0) {
                        count--;
                        badge.textContent = count;
                        if (count === 0) {
                            badge.style.display = 'none';
                        }
                    }
                });
            });

            // Header scroll effect
            let lastScrollTop = 0;
            
            window.addEventListener('scroll', function() {
                const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
                
                if (scrollTop > lastScrollTop && scrollTop > 100) {
                    // Scroll down
                    header.style.transform = 'translateY(-100%)';
                } else {
                    // Scroll up
                    header.style.transform = 'translateY(0)';
                }
                
                lastScrollTop = scrollTop;
            });

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Ctrl + K for search focus (if search exists)
                if (e.ctrlKey && e.key === 'k') {
                    e.preventDefault();
                    const searchInput = document.querySelector('input[type="search"], input[name="search"]');
                    if (searchInput) {
                        searchInput.focus();
                    }
                }
                
                // Escape to close dropdowns
                if (e.key === 'Escape') {
                    const openDropdowns = document.querySelectorAll('.dropdown-menu.show');
                    openDropdowns.forEach(dropdown => {
                        const dropdownInstance = bootstrap.Dropdown.getInstance(dropdown.previousElementSibling);
                        if (dropdownInstance) {
                            dropdownInstance.hide();
                        }
                    });
                }
            });

            // Prevent dropdown close when clicking inside
            document.querySelectorAll('.dropdown-menu').forEach(menu => {
                menu.addEventListener('click', function(e) {
                    e.stopPropagation();
                });
            });
        });

        // Utility functions for other pages to use
        window.headerUtils = {
            // Show notification in header
            showNotification: function(title, message, type = 'info') {
                // This can be implemented to show custom notifications
                console.log('Notification:', title, message, type);
            },
            
            // Update notification badge count
            updateNotificationCount: function(count) {
                const badge = document.querySelector('.notification-badge');
                badge.textContent = count;
                if (count === 0) {
                    badge.style.display = 'none';
                } else {
                    badge.style.display = 'flex';
                }
            }
        };
    </script>
</body>
</html>