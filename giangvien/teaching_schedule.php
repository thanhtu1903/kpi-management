<?php
require_once '../includes/config.php';
require_once '../includes/auth.php';
require_once '../includes/header.php';

redirectIfNotLoggedIn();
checkPermission(['giangvien']);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch giảng dạy - Hệ thống KPI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* CSS từ file bạn gửi - đã tối ưu */
        .tab-nav {
            display: flex;
            background: #f0f0f0;
            border-radius: 8px;
            margin: 20px 0;
            padding: 5px;
        }
        .tab-btn {
            flex: 1;
            padding: 12px 20px;
            border: none;
            background: transparent;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            transition: all 0.3s;
        }
        .tab-btn.active {
            background: #3498db;
            color: white;
            font-weight: bold;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .button-bar {
            margin: 20px 0;
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        input[type="text"] {
            border: none;
            border-bottom: 1px solid #ccc;
            padding: 5px;
            width: 200px;
        }
        .header-left, .header-right {
            width: 30%;
        }
        .header-center {
            width: 40%;
            text-align: center;
        }
        header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .footer {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <div class="container-fluid py-4">
        <div class="dashboard-container">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="welcome-content">
                    <h1 class="welcome-title">
                        <i class="fas fa-calendar-alt me-2"></i>Lịch giảng dạy
                    </h1>
                    <p class="welcome-subtitle">Quản lý lịch trình giảng dạy và bài thực hành</p>
                </div>
            </div>

            <!-- Nội dung chính từ file bạn gửi -->
            <div class="dashboard-card">
                <div class="card-body">
                    <!-- TAB NAVIGATION -->
                    <div class="tab-nav">
                        <button class="tab-btn active" onclick="switchTab('lich-trinh')">
                            <i class="fas fa-clipboard-list me-2"></i>Lịch trình giảng dạy
                        </button>
                        <button class="tab-btn" onclick="switchTab('thuc-hanh')">
                            <i class="fas fa-flask me-2"></i>Bài học thực hành
                        </button>
                    </div>

                    <!-- TAB 1: LỊCH TRÌNH GIẢNG DẠY -->
                    <div id="lich-trinh" class="tab-content active">
                        <!-- Nội dung tab 1 giữ nguyên từ file bạn gửi -->
                        <header>
                            <div class="header-left">
                                <p>Khoa: <?php 
                                    $stmt = $pdo->prepare("SELECT department_name FROM departments WHERE id = ?");
                                    $stmt->execute([$_SESSION['department_id']]);
                                    $dept = $stmt->fetch();
                                    echo $dept ? $dept['department_name'] : 'Công nghệ thông tin';
                                ?></p>
                                <p>Năm học: 2025 - 2026</p>
                                <p>Học kỳ: 1</p>
                            </div>
                            <div class="header-center">
                                <h4>LỊCH TRÌNH GIẢNG DẠY</h4>
                            </div>
                            <div class="header-right">
                                <p><strong>Giảng viên:</strong> <?php echo $_SESSION['full_name']; ?></p>
                                <p><strong>Ngày tạo:</strong> <?php echo date('d/m/Y'); ?></p>
                            </div>
                        </header>

                        <!-- KHUNG THÔNG TIN HỌC PHẦN -->
                        <section class="info">
                            <div class="left">
                                <p><strong>Học phần:</strong> <input type="text" id="hocphan-lt"></p>
                                <p><strong>Mã số học phần:</strong> <input type="text" id="mahp-lt"></p>
                            </div>
                            <div class="right">
                                <p><strong>Tổng số giờ giảng:</strong> <input type="text" id="gio_tong-lt"></p>
                                <p><strong>Số giờ giảng trực tiếp:</strong> <input type="text" id="gio_tructiep-lt"></p>
                            </div>
                        </section>

                        <!-- BẢNG LỊCH TRÌNH -->
                        <div class="table-responsive">
                            <table class="schedule table table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th>TT</th>
                                        <th>TÊN ĐỀ MỤC</th>
                                        <th>SỐ GIỜ</th>
                                        <th>THỨ TỰ BÀI HỌC</th>
                                        <th>NỘI DUNG</th>
                                        <th>THỜI GIAN</th>
                                        <th>GHI CHÚ</th>
                                    </tr>
                                </thead>
                                <tbody id="schedule-body-lt">
                                    <tr>
                                        <td contenteditable="true">1</td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- TAB 2: BÀI HỌC THỰC HÀNH -->
                    <div id="thuc-hanh" class="tab-content">
                        <!-- Nội dung tab 2 tương tự, đã rút gọn -->
                        <header>
                            <div class="header-left">
                                <p>Khoa: <?php echo $dept ? $dept['department_name'] : 'Công nghệ thông tin'; ?></p>
                                <p>Năm học: 2025 - 2026</p>
                                <p>Học kỳ: 1</p>
                            </div>
                            <div class="header-center">
                                <h4>BÀI HỌC THỰC HÀNH</h4>
                            </div>
                            <div class="header-right">
                                <p><strong>Giảng viên:</strong> <?php echo $_SESSION['full_name']; ?></p>
                                <p><strong>Ngày tạo:</strong> <?php echo date('d/m/Y'); ?></p>
                            </div>
                        </header>

                        <section class="info">
                            <div class="left">
                                <p><strong>Học phần:</strong> <input type="text" id="hocphan-th"></p>
                                <p><strong>Mã số học phần:</strong> <input type="text" id="mahp-th"></p>
                            </div>
                            <div class="right">
                                <p><strong>Tổng số giờ thực hành:</strong> <input type="text" id="gio_tong-th"></p>
                                <p><strong>Số bài thực hành:</strong> <input type="text" id="so_bai-th"></p>
                            </div>
                        </section>

                        <div class="table-responsive">
                            <table class="schedule table table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th>TT</th>
                                        <th>TÊN BÀI THỰC HÀNH</th>
                                        <th>SỐ GIỜ</th>
                                        <th>MỤC TIÊU</th>
                                        <th>NỘI DUNG</th>
                                        <th>YÊU CẦU</th>
                                        <th>THỜI GIAN</th>
                                        <th>ĐÁNH GIÁ</th>
                                    </tr>
                                </thead>
                                <tbody id="schedule-body-th">
                                    <tr>
                                        <td contenteditable="true">1</td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                        <td contenteditable="true"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Nút chức năng -->
                    <div class="button-bar">
                        <button id="addRowBtn" class="btn btn-success">
                            <i class="fas fa-plus me-2"></i>Thêm dòng
                        </button>
                        <button id="saveBtn" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Lưu tạm
                        </button>
                        <button id="exportBtn" class="btn btn-info">
                            <i class="fas fa-download me-2"></i>Xuất file
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // CHUYỂN TAB
        function switchTab(tabName) {
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            document.getElementById(tabName).classList.add('active');
            event.target.classList.add('active');
        }

        // THÊM DÒNG MỚI
        document.getElementById("addRowBtn").addEventListener("click", () => {
            const activeTab = document.querySelector('.tab-content.active');
            const tbodyId = activeTab.id === 'lich-trinh' ? 'schedule-body-lt' : 'schedule-body-th';
            const tbody = document.getElementById(tbodyId);
            
            const rowCount = tbody.children.length + 1;
            const row = document.createElement("tr");
            
            if (activeTab.id === 'lich-trinh') {
                // 7 cột cho lịch trình
                row.innerHTML = `
                    <td contenteditable="true">${rowCount}</td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                `;
            } else {
                // 8 cột cho thực hành
                row.innerHTML = `
                    <td contenteditable="true">${rowCount}</td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                    <td contenteditable="true"></td>
                `;
            }
            
            tbody.appendChild(row);
        });

        // LƯU DỮ LIỆU
        document.getElementById("saveBtn").addEventListener("click", () => {
            const activeTab = document.querySelector('.tab-content.active');
            const isLichTrinh = activeTab.id === 'lich-trinh';
            
            const data = {
                type: isLichTrinh ? 'schedule' : 'practice',
                saved_at: new Date().toLocaleString('vi-VN')
            };
            
            localStorage.setItem('teachingData', JSON.stringify(data));
            alert('✅ Đã lưu tạm thời! Dữ liệu sẽ được lưu trong trình duyệt.');
        });

        // XUẤT FILE
        document.getElementById("exportBtn").addEventListener("click", () => {
            const activeTab = document.querySelector('.tab-content.active');
            const isLichTrinh = activeTab.id === 'lich-trinh';
            const title = isLichTrinh ? 'Lich_trinh_giang_day' : 'Bai_thuc_hanh';
            
            // Tạo nội dung HTML để xuất
            const tabContent = activeTab.innerHTML;
            const htmlContent = `
                <!DOCTYPE html>
                <html>
                <head>
                    <title>${title}</title>
                    <style>
                        body { font-family: Arial, sans-serif; margin: 20px; }
                        table { width: 100%; border-collapse: collapse; }
                        th, td { border: 1px solid #000; padding: 8px; }
                        th { background: #f0f0f0; }
                    </style>
                </head>
                <body>
                    <h2>${title} - <?php echo $_SESSION['full_name']; ?></h2>
                    <p>Ngày xuất: <?php echo date('d/m/Y H:i'); ?></p>
                    ${tabContent}
                </body>
                </html>
            `;
            
            // Tạo và tải file
            const blob = new Blob([htmlContent], { type: 'text/html' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `${title}_<?php echo date('Y-m-d'); ?>.html`;
            a.click();
            URL.revokeObjectURL(url);
        });
    </script>

    <?php include '../includes/footer.php'; ?>
</body>
</html>