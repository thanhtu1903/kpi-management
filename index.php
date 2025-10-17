<?php
session_start();
require_once 'includes/config.php';

if (isset($_SESSION['user_id'])) {
    $role = $_SESSION['user_type'];
    header('Location: ' . $role . '/index.php');
    exit;
}

$base_url = 'http://localhost/kpi-management';
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống Quản lý KPI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<?php echo $base_url; ?>css/style.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        
        .hero-section h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .hero-section p {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        
        .feature-section {
            padding: 80px 0;
            background: #f8f9fa;
        }
        
        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
        }
        
        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: white;
            font-size: 2rem;
        }
        
        .feature-card h3 {
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        
        .feature-card p {
            color: #6c757d;
            line-height: 1.6;
        }
        
        .cta-section {
            background: #2c3e50;
            color: white;
            padding: 60px 0;
            text-align: center;
        }
        
        .btn-hero {
            background: white;
            color: #667eea;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 2px solid white;
        }
        
        .btn-hero:hover {
            background: transparent;
            color: white;
        }
        
        .btn-outline-hero {
            background: transparent;
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            border: 2px solid white;
            transition: all 0.3s ease;
        }
        
        .btn-outline-hero:hover {
            background: white;
            color: #667eea;
        }
        
        .stats-section {
            padding: 60px 0;
            background: white;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            color: #667eea;
            display: block;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 1.1rem;
        }
        
        .navbar-landing {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light navbar-landing fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">
                <i class="fas fa-chart-line me-2"></i>
                KPI SYSTEM
            </a>
            <div class="navbar-nav ms-auto">
                <a href="login.php" class="btn btn-primary px-4">
                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                </a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <h1>Hệ thống Quản lý KPI</h1>
                    <p>Nền tảng toàn diện cho việc đánh giá và quản lý hiệu suất giảng dạy, nghiên cứu khoa học</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <span class="stat-number" data-count="500">0</span>
                    <span class="stat-label">Giảng viên</span>
                </div>
                <div class="col-md-3 mb-4">
                    <span class="stat-number" data-count="25">0</span>
                    <span class="stat-label">Khoa/Bộ môn</span>
                </div>
                <div class="col-md-3 mb-4">
                    <span class="stat-number" data-count="1500">0</span>
                    <span class="stat-label">KPI được đánh giá</span>
                </div>
                <div class="col-md-3 mb-4">
                    <span class="stat-number" data-count="98">0</span>
                    <span class="stat-label">% Hài lòng</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="feature-section">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-lg-8 mx-auto">
                    <h2 class="display-4 mb-4">Tính năng nổi bật</h2>
                    <p class="lead">Hệ thống được thiết kế để tối ưu hóa quy trình đánh giá KPI cho giảng viên</p>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h3>Theo dõi KPI trực quan</h3>
                        <p>Dashboard trực quan với biểu đồ và số liệu chi tiết, giúp theo dõi hiệu suất theo thời gian thực</p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-file-upload"></i>
                        </div>
                        <h3>Nhập liệu thông minh</h3>
                        <p>Giao diện nhập liệu thân thiện, hỗ trợ upload file minh chứng và tự động tính điểm KPI</p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-check-double"></i>
                        </div>
                        <h3>Duyệt KPI linh hoạt</h3>
                        <p>Hệ thống duyệt KPI nhiều cấp với khả năng phê duyệt, từ chối và ghi chú chi tiết</p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-bell"></i>
                        </div>
                        <h3>Thông báo thời gian thực</h3>
                        <p>Hệ thống thông báo tự động khi có KPI cần duyệt, hạn nộp, hoặc thay đổi trạng thái</p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3>Bảo mật đa tầng</h3>
                        <p>Phân quyền chi tiết theo vai trò (Admin, Trưởng khoa, Giảng viên) và mã hóa dữ liệu</p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h3>Responsive Design</h3>
                        <p>Giao diện tối ưu cho mọi thiết bị từ desktop đến mobile, dễ dàng sử dụng mọi lúc mọi nơi</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- User Roles Section -->
    <section class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="display-5 mb-4">Phân quyền thông minh</h2>
                    <p class="lead mb-5">Hệ thống được thiết kế cho 3 nhóm người dùng chính với các chức năng chuyên biệt</p>
                    
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="text-center p-4">
                                <i class="fas fa-user-cog fa-3x mb-3 text-warning"></i>
                                <h4 class="text-warning">Quản trị viên</h4>
                                <p>Quản lý hệ thống, người dùng, thiết lập tiêu chí KPI</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="text-center p-4">
                                <i class="fas fa-user-tie fa-3x mb-3 text-info"></i>
                                <h4 class="text-info">Trưởng khoa</h4>
                                <p>Duyệt KPI, xem báo cáo, quản lý giảng viên trong khoa</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="text-center p-4">
                                <i class="fas fa-user-graduate fa-3x mb-3 text-success"></i>
                                <h4 class="text-success">Giảng viên</h4>
                                <p>Nhập KPI, theo dõi kết quả, quản lý minh chứng</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-5">
                        <a href="login.php" class="btn-hero me-3">
                            <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập ngay
                        </a>
                        <a href="#contact" class="btn-outline-hero">
                            <i class="fas fa-envelope me-2"></i>Liên hệ hỗ trợ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-light py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <h5><i class="fas fa-university me-2"></i>Trường ĐH SPKT Vĩnh Long</h5>
                    <p>Hệ thống Quản lý KPI Giảng viên - Nâng cao chất lượng giáo dục</p>
                </div>
                <div class="col-lg-6 text-lg-end">
                    <p class="mb-1">Địa chỉ:73 Nguyễn Huệ, Phường Long Châu, Tỉnh Vĩnh Long</p>
                    <p class="mb-1">Email: spkt@vlute.edu.vn</p>
                    <p class="mb-0">Điện thoại: 02703 822 141</p>
                </div>
            </div>
            <hr class="my-4">
            <div class="row">
                <div class="col-12 text-center">
                    <p>Bản quyền thuộc về Trường Đại học Sư phạm Kỹ thuật Vĩnh Long (VLUTE)
                       <br>Copyright belongs to Vinh Long University of Technology Education (VLUTE)</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animation cho số thống kê
        function animateNumbers() {
            const counters = document.querySelectorAll('.stat-number');
            const speed = 200;
            
            counters.forEach(counter => {
                const target = +counter.getAttribute('data-count');
                const count = +counter.innerText;
                const increment = target / speed;
                
                if (count < target) {
                    counter.innerText = Math.ceil(count + increment);
                    setTimeout(() => animateNumbers(), 1);
                } else {
                    counter.innerText = target;
                }
            });
        }
        
        // Kích hoạt animation khi scroll đến section
        function isElementInViewport(el) {
            const rect = el.getBoundingClientRect();
            return (
                rect.top >= 0 &&
                rect.left >= 0 &&
                rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
                rect.right <= (window.innerWidth || document.documentElement.clientWidth)
            );
        }
        
        function checkAnimation() {
            const statsSection = document.querySelector('.stats-section');
            if (isElementInViewport(statsSection)) {
                animateNumbers();
                window.removeEventListener('scroll', checkAnimation);
            }
        }
        
        window.addEventListener('scroll', checkAnimation);
        
        // Smooth scroll cho navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>