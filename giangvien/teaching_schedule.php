<?php
require_once '../includes/config.php';
require_once '../includes/auth.php';

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
    <link rel="stylesheet" href="../css/teaching_schedule.css">
</head>
<body>
    <?php include '../includes/header.php'; ?>
    <?php include '../includes/sidebar.php'; ?>

    <!-- Main Content -->
<div class="dashboard-container">
    <!-- Welcome Section -->
    <div class="welcome-section">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="welcome-title">
                    <i class="fas fa-calendar-alt me-3"></i>Lịch giảng dạy
                </h1>
                <p class="welcome-subtitle">Quản lý lịch trình giảng dạy và bài thực hành</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="welcome-meta">
                    <span class="meta-item">
                        <i class="fas fa-building me-2"></i>
                        <?php 
                            $stmt = $pdo->prepare("SELECT department_name FROM departments WHERE id = ?");
                            $stmt->execute([$_SESSION['department_id']]);
                            $dept = $stmt->fetch();
                            echo $dept ? $dept['department_name'] : 'Chưa phân khoa';
                        ?>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="dashboard-card">
        <div class="card-body">
            <!-- TAB NAVIGATION -->
            <div class="tab-nav">
                <button class="tab-btn active" onclick="switchTab('lich-trinh')">
                    <i class="fas fa-clipboard-list me-2"></i>Lịch trình lý thuyết
                </button>
                <button class="tab-btn" onclick="switchTab('thuc-hanh')">
                    <i class="fas fa-flask me-2"></i>Lịch trình thực hành
                </button>
            </div>

            <!-- TAB 1: LỊCH TRÌNH GIẢNG DẠY -->
            <div id="lich-trinh" class="tab-content active">
                <!-- Header Information -->
                <div class="schedule-header">
                    <div class="row">
                        <div class="col-md-4">
                            <p class="mb-1"><strong>Khoa:</strong> <?php echo $dept ? $dept['department_name'] : 'Công nghệ thông tin'; ?></p>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="form-label-sm"><strong>Năm học:</strong></label>
                                        <select class="form-select form-select-sm" id="namhoc-lt">
                                            <?php foreach ($school_years as $year): ?>
                                                <option value="<?php echo $year; ?>" <?php echo $year === ($current_year - 1) . ' - ' . $current_year ? 'selected' : ''; ?>>
                                                    <?php echo $year; ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="form-label-sm"><strong>Học kỳ:</strong></label>
                                        <select class="form-select form-select-sm" id="hocky-lt">
                                            <?php foreach ($semesters as $semester): ?>
                                                <option value="<?php echo $semester; ?>" <?php echo $semester == 1 ? 'selected' : ''; ?>>
                                                    Học kỳ <?php echo $semester; ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <h4 class="mb-0">LỊCH TRÌNH GIẢNG DẠY</h4>
                        </div>
                        <div class="col-md-4 text-end">
                            <p class="mb-1"><strong>Giảng viên:</strong> <?php echo $_SESSION['full_name']; ?></p>
                            <p class="mb-0"><strong>Ngày tạo:</strong> <?php echo date('d/m/Y'); ?></p>
                        </div>
                    </div>
                </div>

                <!-- Course Information -->
                <div class="info-section">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label"><strong>Học phần:</strong></label>
                                <input type="text" class="form-control form-control-custom" id="hocphan-lt" placeholder="Nhập tên học phần">
                            </div>
                            <div class="mb-3">
                                <label class="form-label"><strong>Mã số học phần:</strong></label>
                                <input type="text" class="form-control form-control-custom" id="mahp-lt" placeholder="Nhập mã học phần">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label"><strong>Tổng số giờ giảng:</strong></label>
                                <input type="text" class="form-control form-control-custom" id="gio_tong-lt" placeholder="Số giờ">
                            </div>
                            <div class="mb-3">
                                <label class="form-label"><strong>Số giờ giảng trực tiếp:</strong></label>
                                <input type="text" class="form-control form-control-custom" id="gio_tructiep-lt" placeholder="Số giờ trực tiếp">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Schedule Table -->
                <div class="table-responsive">
                    <table class="table schedule-table">
                        <thead>
                            <tr>
                                <th width="5%">TT</th>
                                <th width="20%">TÊN ĐỀ MỤC</th>
                                <th width="10%">SỐ GIỜ</th>
                                <th width="10%">THỨ TỰ BÀI HỌC</th>
                                <th width="25%">NỘI DUNG</th>
                                <th width="15%">THỜI GIAN</th>
                                <th width="15%">GHI CHÚ</th>
                            </tr>
                        </thead>
                        <tbody id="schedule-body-lt">
                            <tr>
                                <td contenteditable="true" class="text-center">1</td>
                                <td contenteditable="true"></td>
                                <td contenteditable="true" class="text-center"></td>
                                <td contenteditable="true" class="text-center"></td>
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
                <!-- Header Information -->
                <div class="schedule-header">
                    <div class="row">
                        <div class="col-md-4">
                            <p class="mb-1"><strong>Khoa:</strong> <?php echo $dept ? $dept['department_name'] : 'Công nghệ thông tin'; ?></p>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="form-label-sm"><strong>Năm học:</strong></label>
                                        <select class="form-select form-select-sm" id="namhoc-th">
                                            <?php foreach ($school_years as $year): ?>
                                                <option value="<?php echo $year; ?>" <?php echo $year === ($current_year - 1) . ' - ' . $current_year ? 'selected' : ''; ?>>
                                                    <?php echo $year; ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="form-label-sm"><strong>Học kỳ:</strong></label>
                                        <select class="form-select form-select-sm" id="hocky-th">
                                            <?php foreach ($semesters as $semester): ?>
                                                <option value="<?php echo $semester; ?>" <?php echo $semester == 1 ? 'selected' : ''; ?>>
                                                    Học kỳ <?php echo $semester; ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <h4 class="mb-0">BÀI HỌC THỰC HÀNH</h4>
                        </div>
                        <div class="col-md-4 text-end">
                            <p class="mb-1"><strong>Giảng viên:</strong> <?php echo $_SESSION['full_name']; ?></p>
                            <p class="mb-0"><strong>Ngày tạo:</strong> <?php echo date('d/m/Y'); ?></p>
                        </div>
                    </div>
                </div>

                <!-- Course Information -->
                <div class="info-section">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label"><strong>Học phần:</strong></label>
                                <input type="text" class="form-control form-control-custom" id="hocphan-th" placeholder="Nhập tên học phần">
                            </div>
                            <div class="mb-3">
                                <label class="form-label"><strong>Mã số học phần:</strong></label>
                                <input type="text" class="form-control form-control-custom" id="mahp-th" placeholder="Nhập mã học phần">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label"><strong>Tổng số giờ thực hành:</strong></label>
                                <input type="text" class="form-control form-control-custom" id="gio_tong-th" placeholder="Số giờ">
                            </div>
                            <div class="mb-3">
                                <label class="form-label"><strong>Số bài thực hành:</strong></label>
                                <input type="text" class="form-control form-control-custom" id="so_bai-th" placeholder="Số bài">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Practice Table -->
                <div class="table-responsive">
                    <table class="table schedule-table">
                        <thead>
                            <tr>
                                <th width="5%">TT</th>
                                <th width="15%">TÊN BÀI THỰC HÀNH</th>
                                <th width="8%">SỐ GIỜ</th>
                                <th width="15%">MỤC TIÊU</th>
                                <th width="20%">NỘI DUNG</th>
                                <th width="12%">YÊU CẦU</th>
                                <th width="10%">THỜI GIAN</th>
                                <th width="15%">ĐÁNH GIÁ</th>
                            </tr>
                        </thead>
                        <tbody id="schedule-body-th">
                            <tr>
                                <td contenteditable="true" class="text-center">1</td>
                                <td contenteditable="true"></td>
                                <td contenteditable="true" class="text-center"></td>
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

            <!-- Action Buttons -->
            <div class="button-bar">
                <button id="addRowBtn" class="btn btn-success btn-action">
                    <i class="fas fa-plus"></i>Thêm dòng
                </button>
                <button id="saveBtn" class="btn btn-primary btn-action">
                    <i class="fas fa-save"></i>Lưu tạm
                </button>
                <button id="exportBtn" class="btn btn-info btn-action">
                    <i class="fas fa-download"></i>Xuất file
                </button>
                <button id="printBtn" class="btn btn-warning btn-action">
                    <i class="fas fa-print"></i>In ấn
                </button>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <?php include '../includes/footer.php'; ?>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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
        event.currentTarget.classList.add('active');
    }

    // THÊM DÒNG MỚI
    document.getElementById("addRowBtn").addEventListener("click", () => {
        const activeTab = document.querySelector('.tab-content.active');
        const tbodyId = activeTab.id === 'lich-trinh' ? 'schedule-body-lt' : 'schedule-body-th';
        const tbody = document.getElementById(tbodyId);
        
        const rowCount = tbody.children.length + 1;
        const row = document.createElement("tr");
        
        if (activeTab.id === 'lich-trinh') {
            row.innerHTML = `
                <td contenteditable="true" class="text-center">${rowCount}</td>
                <td contenteditable="true"></td>
                <td contenteditable="true" class="text-center"></td>
                <td contenteditable="true" class="text-center"></td>
                <td contenteditable="true"></td>
                <td contenteditable="true"></td>
                <td contenteditable="true"></td>
            `;
        } else {
            row.innerHTML = `
                <td contenteditable="true" class="text-center">${rowCount}</td>
                <td contenteditable="true"></td>
                <td contenteditable="true" class="text-center"></td>
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
        
        // Lấy thông tin năm học và học kỳ
        const namhoc = isLichTrinh ? 
            document.getElementById('namhoc-lt').value : 
            document.getElementById('namhoc-th').value;
        const hocky = isLichTrinh ? 
            document.getElementById('hocky-lt').value : 
            document.getElementById('hocky-th').value;
        
        const data = {
            type: isLichTrinh ? 'schedule' : 'practice',
            namhoc: namhoc,
            hocky: hocky,
            saved_at: new Date().toLocaleString('vi-VN'),
            timestamp: new Date().getTime()
        };
        
        localStorage.setItem('teachingData', JSON.stringify(data));
        
        // Hiển thị thông báo
        alert('✅ Đã lưu tạm thời! Dữ liệu sẽ được lưu trong trình duyệt.');
    });

    // XUẤT FILE
    document.getElementById("exportBtn").addEventListener("click", () => {
        const activeTab = document.querySelector('.tab-content.active');
        const isLichTrinh = activeTab.id === 'lich-trinh';
        
        // Lấy thông tin năm học và học kỳ
        const namhoc = isLichTrinh ? 
            document.getElementById('namhoc-lt').value : 
            document.getElementById('namhoc-th').value;
        const hocky = isLichTrinh ? 
            document.getElementById('hocky-lt').value : 
            document.getElementById('hocky-th').value;
        
        const title = isLichTrinh ? 'Lich_trinh_giang_day' : 'Bai_thuc_hanh';
        
        // Tạo nội dung HTML để xuất
        const tabContent = activeTab.innerHTML;
        const htmlContent = `
            <!DOCTYPE html>
            <html>
            <head>
                <title>${title}</title>
                <meta charset="UTF-8">
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; color: #333; }
                    .header { background: #3498db; color: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; }
                    table { width: 100%; border-collapse: collapse; margin: 20px 0; }
                    th, td { border: 1px solid #ddd; padding: 10px 8px; text-align: left; }
                    th { background: #2c3e50; color: white; font-weight: bold; }
                    .footer { margin-top: 30px; padding-top: 20px; border-top: 2px solid #3498db; }
                    .form-select-sm { padding: 0.25rem 0.5rem; font-size: 0.875rem; }
                    .form-label-sm { font-size: 0.875rem; margin-bottom: 0.25rem; }
                </style>
            </head>
            <body>
                <div class="header">
                    <h2>${title.toUpperCase()}</h2>
                    <p><strong>Năm học:</strong> ${namhoc}</p>
                    <p><strong>Học kỳ:</strong> ${hocky}</p>
                    <p><strong>Giảng viên:</strong> <?php echo $_SESSION['full_name']; ?></p>
                    <p><strong>Ngày xuất:</strong> <?php echo date('d/m/Y H:i'); ?></p>
                </div>
                ${activeTab.innerHTML}
                <div class="footer">
                    <p><strong>Trường ĐH SPKT Vĩnh Long</strong> - Hệ thống Quản lý KPI Giảng viên</p>
                </div>
            </body>
            </html>
        `;
        
        const blob = new Blob([htmlContent], { type: 'text/html;charset=utf-8' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `${title}_${namhoc.replace(' - ', '_')}_HK${hocky}_<?php echo $_SESSION['user_id']; ?>_${new Date().getTime()}.html`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    });

    // IN ẤN
    document.getElementById("printBtn").addEventListener("click", () => {
        window.print();
    });
</script>
<script>
    // JavaScript cho toggle sidebar
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        document.body.classList.toggle('collapsed');
    });

    // JavaScript cho mobile menu
    document.getElementById('mobileMenuToggle').addEventListener('click', function() {
        document.querySelector('.sidebar').classList.toggle('mobile-open');
    });

    // Đóng sidebar khi click ra ngoài trên mobile
    document.addEventListener('click', function(event) {
        const sidebar = document.querySelector('.sidebar');
        const mobileToggle = document.getElementById('mobileMenuToggle');
        
        if (window.innerWidth <= 768 && 
            !sidebar.contains(event.target) && 
            !mobileToggle.contains(event.target)) {
            sidebar.classList.remove('mobile-open');
        }
    });
</script>
<script src="../js/sidebar.js"></script>
</body>
</html>