<!-- Sidebar -->
<link rel="stylesheet" href="../css/sidebar.css">
<div class="sidebar">
    <div class="sidebar-header">
        <div class="text-center py-3">
            <div class="sidebar-logo mb-2">
                <i class="fas fa-chart-line fa-2x text-white"></i>
            </div>
            <h4 class="text-white mb-0">KPI SYSTEM</h4>
            <small class="text-white-50">Giảng viên</small>
        </div>
    </div>
    
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'index.php' ? 'active' : ''; ?>" 
               href="../giangvien/index.php">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'kpi_submission.php' ? 'active' : ''; ?>" 
               href="../giangvien/kpi_submission.php">
                <i class="fas fa-upload"></i>
                <span>Nhập KPI</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'teaching_schedule.php' ? 'active' : ''; ?>" 
               href="../giangvien/teaching_schedule.php">
                <i class="fas fa-calendar-alt"></i>
                <span>Lịch giảng dạy</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'research.php' ? 'active' : ''; ?>" 
               href="../giangvien/research.php">
                <i class="fas fa-flask"></i>
                <span>Nghiên cứu khoa học</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'my_reports.php' ? 'active' : ''; ?>" 
               href="../giangvien/my_reports.php">
                <i class="fas fa-chart-bar"></i>
                <span>Kết quả</span>
            </a>
        </li>
    </ul>

    <!-- Sidebar Footer -->
    <div class="sidebar-footer mt-auto p-3">
        <div class="text-center">
            <small class="text-white-50">© 2024 KPI System</small>
        </div>
    </div>
</div>

<!-- Toggle Button -->
<button class="toggle-btn" id="sidebarToggle">
    <i class="fas fa-bars"></i>
</button>