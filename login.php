<?php
require_once 'includes/config.php';
require_once 'includes/auth.php';

if (isLoggedIn()) {
    header('Location: ' . BASE_URL . '/' . $_SESSION['user_type'] . '/index.php');
    exit;
}

// Xử lý Remember Me
if (isset($_COOKIE['remember_me']) && !isset($_SESSION['user_id'])) {
    $token = $_COOKIE['remember_me'];
    $user = validateRememberToken($token);
    if ($user) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['full_name'] = $user['full_name'];
        $_SESSION['user_type'] = $user['user_type'];
        $_SESSION['department_id'] = $user['department_id'];
        header('Location: ' . BASE_URL . '/' . $user['user_type'] . '/index.php');
        exit;
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];
    $remember_me = isset($_POST['remember_me']);
    
    if (loginUser($email, $password, $remember_me)) {
        header('Location: ' . BASE_URL . '/' . $_SESSION['user_type'] . '/index.php');
        exit;
    } else {
        $error = "Email hoặc mật khẩu không đúng!";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống KPI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/login.css" rel="stylesheet">
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <!-- Header -->
            <div class="login-header">
                <h1 class="login-title">Hệ thống quản lý KPI</h1>
                <p class="login-subtitle">Đăng nhập</p>
            </div>

            <!-- Error Alert -->
            <?php if (isset($error)): ?>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i>
                <?php echo $error; ?>
            </div>
            <?php endif; ?>

            <!-- Login Form -->
            <form method="POST" class="login-form" id="loginForm">
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <div class="input-group">
                        <input type="email" class="form-control" name="email" placeholder="username@st.vlute.edu.vn" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Mật khẩu</label>
                    <div class="input-group">
                        <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu" required>
                    </div>
                </div>

                <!-- Form Options -->
                <div class="form-options">
                    <div class="remember-me">
                        <div class="remember-checkbox" id="rememberCheckbox"></div>
                        <span class="remember-label">Ghi nhớ tài khoản</span>
                        <input type="checkbox" name="remember_me" id="remember_me" style="display: none;">
                    </div>
                    <a href="forgot_password.php" class="forgot-password">
                        Quên mật khẩu?
                    </a>
                </div>

                <!-- Login Button -->
                <button type="submit" class="btn-login" id="loginButton">
                    <i class="fas fa-sign-in-alt"></i>
                    <span>Đăng nhập</span>
                </button>
            </form>

            <!-- Divider -->
            <div class="divider">
                <span class="divider-text">Hoặc đăng nhập với</span>
            </div>

            <!-- Social Login -->
            <div class="social-login">
                <a href="#" class="btn-social">
                    <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google">
                    Google
                </a>
                <a href="#" class="btn-social">
                    <i class="fab fa-microsoft"></i>
                    Microsoft
                </a>
            </div>

            <!-- Footer -->
            <div class="login-footer">
                <p class="footer-text">
                    Bằng việc đăng nhập, bạn đồng ý với 
                    <a href="#" class="footer-link">Điều khoản sử dụng</a> 
                    và 
                    <a href="#" class="footer-link">Chính sách bảo mật</a>
                </p>
            </div>
        </div>
    </div>

    <script>
        // Remember Me Checkbox
        const rememberCheckbox = document.getElementById('rememberCheckbox');
        const rememberInput = document.getElementById('remember_me');
        
        rememberCheckbox.addEventListener('click', function() {
            this.classList.toggle('checked');
            rememberInput.checked = this.classList.contains('checked');
        });

        // Form Submission Loading
        const loginForm = document.getElementById('loginForm');
        const loginButton = document.getElementById('loginButton');
        
        loginForm.addEventListener('submit', function() {
            const buttonText = loginButton.querySelector('span');
            buttonText.textContent = 'Đang đăng nhập...';
            loginButton.disabled = true;
            
            const icon = loginButton.querySelector('i');
            icon.className = 'spinner';
        });

        // Auto focus on email field
        document.querySelector('input[name="email"]').focus();
    </script>
</body>
</html>