<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống KPI - Giảng viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
    .navbar { background: #3498db; }
    .navbar-brand, .nav-link { color: white !important; }
    .nav-link:hover { color: #f8f9fa !important; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="../giangvien/index.php">
                <i class="fas fa-chart-line me-2"></i>KPI SYSTEM
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="../giangvien/index.php">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../giangvien/kpi_submission.php">
                            <i class="fas fa-upload me-1"></i>Nhập KPI
                        </a>
                    </li>
                    <!-- MENU MỚI ĐÃ THÊM -->
                    <li class="nav-item">
                        <a class="nav-link" href="../giangvien/teaching_schedule.php">
                            <i class="fas fa-calendar-alt me-1"></i>Lịch giảng dạy
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../giangvien/my_reports.php">
                            <i class="fas fa-chart-bar me-1"></i>Kết quả
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="../logout.php">
                            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>