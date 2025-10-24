<?php
require_once '../includes/config.php';
require_once '../includes/auth.php';

redirectIfNotLoggedIn();
checkPermission(['giangvien']);

// Lấy dữ liệu từ cơ sở dữ liệu
try {
    // Lấy thông tin khoa
    $stmt = $pdo->prepare("SELECT department_name FROM departments WHERE id = ?");
    $stmt->execute([$_SESSION['department_id']]);
    $dept = $stmt->fetch();
    // Lấy danh sách năm học và học kỳ từ bảng thoigian_hocky
    $stmt = $pdo->query("SELECT id_nhhk, nam_hocky FROM thoigian_hocky ORDER BY id_nhhk DESC");
    $school_years_data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    // Tạo mảng năm học và học kỳ
    $school_years = [];
    $semesters = [];
    
    foreach ($school_years_data as $row) {
        $school_years[$row['id_nhhk']] = $row['nam_hocky'];
        
        // Phân tích học kỳ từ chuỗi nam_hocky
        if (preg_match('/(\d{4}-\d{4}), học kỳ (\d+)/', $row['nam_hocky'], $matches)) {
            $semesters[$row['id_nhhk']] = $matches[2];
        }
    }
    
    // Nếu không có năm học trong DB, tạo mặc định
    if (empty($school_years)) {
        $current_year = date('Y');
        $default_id = 1;
        $school_years[$default_id] = ($current_year - 1) . ' - ' . $current_year . ', học kỳ 1';
        $semesters[$default_id] = 1;
    }
    
    // Lấy danh sách chương trình đào tạo
    $stmt = $pdo->query("SELECT program_code, program_name FROM training_programs ORDER BY program_name");
    $training_programs = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);
    
    // Lấy danh sách bảng giờ
    $hour_tables = [
        '2' => '2 tiết/tuần',
        '3' => '3 tiết/tuần',
    ];
    // Lấy năm học hiện tại (lấy bản ghi đầu tiên)
    $current_school_year_id = !empty($school_years) ? array_key_first($school_years) : 0;
    $current_school_year = !empty($school_years) ? reset($school_years) : '';
} catch (PDOException $e) {
    // Xử lý lỗi nếu cần
    error_log("Database error: " . $e->getMessage());
}
// Khai báo biến mặc định để tránh lỗi undefined
if (!isset($current_school_year_id)) $current_school_year_id = 0;
if (!isset($current_school_year)) $current_school_year = '';
if (!isset($school_years)) $school_years = [];
if (!isset($training_programs)) $training_programs = [];
if (!isset($hour_tables)) $hour_tables = [];
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
                            <?php echo $dept ? $dept['department_name'] : 'Chưa phân khoa'; ?>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="dashboard-card">
            <div class="card-body">
                <!-- Filter Section -->
                <!-- Filter Section -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label"><strong>Năm học, học kỳ:</strong></label>
                            <select class="form-select form-select-custom" id="namhoc">
                                <?php if (!empty($school_years)): ?>
                                    <?php foreach ($school_years as $id => $nam_hocky): ?>
                                        <option value="<?php echo $id; ?>" <?php echo $id == $current_school_year_id ? 'selected' : ''; ?>>
                                            <?php echo htmlspecialchars($nam_hocky); ?>
                                        </option>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <option value="">-- Không có dữ liệu --</option>
                                <?php endif; ?>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label"><strong>Chương trình đào tạo:</strong></label>
                            <select class="form-select form-select-custom" id="chuong-trinh">
                                <option value="">-- Chọn chương trình --</option>
                                <?php if (!empty($training_programs)): ?>
                                    <?php foreach ($training_programs as $code => $name): ?>
                                        <option value="<?php echo $code; ?>"><?php echo htmlspecialchars($name); ?></option>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Phần môn học phần - Ẩn ban đầu -->
                <div class="row mb-4" id="hocphan-section" style="display: none;">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label"><strong>Học phần:</strong></label>
                            <select class="form-select form-select-custom" id="hocphan">
                                <option value="">-- Chọn học phần --</option>
                                <!-- Các option sẽ được load bằng JavaScript -->
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label"><strong>Mã số học phần:</strong></label>
                            <input type="text" class="form-control form-control-custom" id="mahp" placeholder="Mã HP sẽ tự động hiển thị" readonly>
                        </div>
                    </div>
                </div>
                <!-- Thêm sau phần học phần -->
                <div class="row mb-4" id="class-section" style="display: none;">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label"><strong>Lớp học phần:</strong></label>
                            <select class="form-select form-select-custom" id="class-dropdown">
                                <option value="">-- Chọn lớp --</option>
                                <!-- Các option sẽ được tạo tự động -->
                            </select>
                        </div>
                    </div>
                </div>
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
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label"><strong>Tổng số giờ lý thuyết:</strong></label>
                                    <input type="number" class="form-control form-control-custom" id="gio_tong-lt" placeholder="Sẽ tự động hiển thị" readonly>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label"><strong>Số giờ giảng trực tiếp:</strong></label>
                                    <input type="number" class="form-control form-control-custom" id="gio_tructiep-lt" placeholder="Tự động tính" readonly>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label"><strong>Số giờ học online (20%):</strong></label>
                                    <input type="number" class="form-control form-control-custom" id="gio_online-lt" placeholder="Tự động tính" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label"><strong>Chọn bảng giờ:</strong></label>
                                    <select class="form-select form-select-custom" id="bang-gio-lt">
                                        <option value="">-- Chọn bảng giờ --</option>
                                        <?php foreach ($hour_tables as $value => $label): ?>
                                            <option value="<?php echo $value; ?>"><?php echo $label; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Hiển thị thông tin bảng giờ -->
                        <div class="row mt-3" id="bang-gio-info-lt" style="display: none;">
                            <div class="col-12">
                                <div class="alert alert-info-custom p-3">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <strong>Thông tin bảng giờ:</strong>
                                            <div id="bang-gio-details-lt"></div>
                                        </div>
                                        <div class="col-md-6">
                                            <strong>Tổng số dòng cần:</strong> 
                                            <span id="tong-dong-lt">0</span> dòng
                                        </div>
                                    </div>
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
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label"><strong>Tổng số giờ giảng:</strong></label>
                                    <input type="number" class="form-control form-control-custom" id="gio_tong-th" placeholder="Nhập tổng số giờ" min="1">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label"><strong>Chọn bảng giờ:</strong></label>
                                    <select class="form-select form-select-custom" id="bang-gio-th">
                                        <option value="">-- Chọn bảng giờ --</option>
                                        <?php foreach ($hour_tables as $value => $label): ?>
                                            <option value="<?php echo $value; ?>"><?php echo $label; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label"><strong>Số giờ giảng trực tiếp:</strong></label>
                                    <input type="text" class="form-control form-control-custom" id="gio_tructiep-th" placeholder="Số giờ trực tiếp" readonly>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Hiển thị thông tin bảng giờ -->
                        <div class="row mt-3" id="bang-gio-info-th" style="display: none;">
                            <div class="col-12">
                                <div class="alert alert-info-custom p-3">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <strong>Thông tin bảng giờ:</strong>
                                            <div id="bang-gio-details-th"></div>
                                        </div>
                                        <div class="col-md-6">
                                            <strong>Tổng số dòng cần:</strong> 
                                            <span id="tong-dong-th">0</span> dòng
                                        </div>
                                    </div>
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
            const namhoc = document.getElementById('namhoc').value;
            const hocky = document.getElementById('hocky').value;
            
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
            const namhoc = document.getElementById('namhoc').value;
            const hocky = document.getElementById('hocky').value;
            
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

        function handleHourTableChange(tableId, infoId, detailsId, totalRowsId, directHoursId, totalHoursInputId) {
            const hourTable = document.getElementById(tableId);
            const infoSection = document.getElementById(infoId);
            const detailsElement = document.getElementById(detailsId);
            const totalRowsElement = document.getElementById(totalRowsId);
            const directHoursElement = document.getElementById(directHoursId);
            const totalHoursInput = document.getElementById(totalHoursInputId);

            // Khi chọn bảng giờ
            hourTable.addEventListener('change', function () {
                const weeklyHours = parseInt(this.value); // Số tiết/tuần (2 hoặc 3)
                const totalHours = parseInt(totalHoursInput.value); // Tổng số giờ nhập vào

                if (!totalHours || totalHours <= 0) {
                    alert("Vui lòng nhập tổng số giờ giảng trước khi chọn bảng giờ!");
                    this.value = "";
                    return;
                }

                if (weeklyHours) {
                    infoSection.style.display = 'block';

                    // Tính toán
                    const directHours = Math.floor(totalHours * 0.7);
                    const rowsNeeded = Math.ceil(totalHours / weeklyHours);

                    // Hiển thị thông tin
                    detailsElement.innerHTML = `
                        <p class="mb-1">Tổng số giờ: ${totalHours} tiết</p>
                        <p class="mb-1">Giờ/tuần: ${weeklyHours} tiết</p>
                        <p class="mb-0">Số giờ trực tiếp (70%): ${directHours} tiết</p>
                    `;
                    totalRowsElement.textContent = rowsNeeded;
                    directHoursElement.value = directHours;

                    // Xác định bảng lịch trình đang hiển thị
                    const activeTab = document.querySelector('.tab-content.active');
                    const tbodyId = activeTab.id === 'lich-trinh' ? 'schedule-body-lt' : 'schedule-body-th';
                    const tbody = document.getElementById(tbodyId);

                    // Xóa các dòng cũ
                    tbody.innerHTML = '';

                    // Thêm dòng mới
                    for (let i = 1; i <= rowsNeeded; i++) {
                        const row = document.createElement('tr');
                        if (activeTab.id === 'lich-trinh') {
                            row.innerHTML = `
                                <td contenteditable="true" class="text-center">${i}</td>
                                <td contenteditable="true">Tuần ${i}</td>
                                <td contenteditable="true" class="text-center">${weeklyHours}</td>
                                <td contenteditable="true" class="text-center"></td>
                                <td contenteditable="true"></td>
                                <td contenteditable="true"></td>
                                <td contenteditable="true"></td>
                            `;
                        } else {
                            row.innerHTML = `
                                <td contenteditable="true" class="text-center">${i}</td>
                                <td contenteditable="true">Tuần ${i}</td>
                                <td contenteditable="true" class="text-center">${weeklyHours}</td>
                                <td contenteditable="true"></td>
                                <td contenteditable="true"></td>
                                <td contenteditable="true"></td>
                                <td contenteditable="true"></td>
                                <td contenteditable="true"></td>
                            `;
                        }
                        tbody.appendChild(row);
                    }
                } else {
                    infoSection.style.display = 'none';
                    directHoursElement.value = '';
                }
            });
        }

        // Gọi hàm cho từng tab
        handleHourTableChange(
            'bang-gio-lt', 
            'bang-gio-info-lt', 
            'bang-gio-details-lt', 
            'tong-dong-lt', 
            'gio_tructiep-lt', 
            'gio_tong-lt' // input tổng số giờ lý thuyết
        );
handleHourTableChange(
    'bang-gio-th', 
    'bang-gio-info-th', 
    'bang-gio-details-th', 
    'tong-dong-th', 
    'gio_tructiep-th', 
    'gio_tong-th' // input tổng số giờ thực hành
);

        // CHỈ GIỮ LẠI 1 EVENT LISTENER DUY NHẤT CHO CHƯƠNG TRÌNH ĐÀO TẠO
        document.getElementById('chuong-trinh').addEventListener('change', function() {
            const programCode = this.value;
            const programName = this.options[this.selectedIndex].text;
            const hocphanSection = document.getElementById('hocphan-section');
            const hocphanSelect = document.getElementById('hocphan');
            const mahpInput = document.getElementById('mahp');
            
            // Ẩn/hiện phần học phần
            if (programCode) {
                // Hiển thị thông tin chương trình đã chọn
                console.log('Đã chọn chương trình:', programName);
                
                hocphanSection.style.display = 'block';
                
                // Hiệu ứng hiện lên mượt mà
                setTimeout(() => {
                    hocphanSection.style.opacity = '1';
                    hocphanSection.style.transform = 'translateY(0)';
                }, 10);
                
                // Xóa các option cũ và thêm option mặc định
                hocphanSelect.innerHTML = '<option value="">-- Đang tải môn học... --</option>';
                mahpInput.value = '';
                
                // SỬA URL AJAX - sử dụng đường dẫn đúng
                const ajaxUrl = '../ajax/get_subjects.php';
                
                // Gửi yêu cầu AJAX để lấy danh sách học phần
                fetch(`${ajaxUrl}?program_code=${programCode}`)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        console.log('Dữ liệu nhận được:', data);
                        
                        // Xóa option "đang tải"
                        hocphanSelect.innerHTML = '<option value="">-- Chọn môn học --</option>';
                        
                        if (data.success && data.subjects && data.subjects.length > 0) {
                            console.log(`Tìm thấy ${data.subjects.length} môn học cho ${programName}`);
                            
                            // Nhóm môn học theo học kỳ
                            const subjectsBySemester = {};
                            data.subjects.forEach(subject => {
                                if (!subjectsBySemester[subject.semester]) {
                                    subjectsBySemester[subject.semester] = [];
                                }
                                subjectsBySemester[subject.semester].push(subject);
                            });
                            
                            // Thêm optgroup cho từng học kỳ
                            Object.keys(subjectsBySemester).sort().forEach(semester => {
                                const optgroup = document.createElement('optgroup');
                                optgroup.label = `Học kỳ ${semester}`;
                                
                                subjectsBySemester[semester].forEach(subject => {
                                    const option = document.createElement('option');
                                    option.value = subject.id;
                                    option.textContent = subject.display_text || subject.name;
                                    option.dataset.code = subject.code;
                                    option.dataset.credits = subject.credits;
                                    option.dataset.theoryHours = subject.theory_hours;   // 🔹 thêm
                                    option.dataset.practiceHours = subject.practice_hours; // 🔹 thêm
                                    optgroup.appendChild(option);
                                });

                                
                                hocphanSelect.appendChild(optgroup);
                            });
                            
                            // Thêm hiệu ứng thành công
                            hocphanSelect.style.borderColor = '#28a745';
                            setTimeout(() => {
                                hocphanSelect.style.borderColor = '';
                            }, 2000);
                            
                        } else {
                            // Nếu không có môn học
                            const option = document.createElement('option');
                            option.value = "";
                            option.textContent = data.message || "-- Không có môn học nào trong chương trình này --";
                            hocphanSelect.appendChild(option);
                            
                            // Hiệu ứng cảnh báo
                            hocphanSelect.style.borderColor = '#ffc107';
                        }
                    })
                    .catch(error => {
                        console.error('Lỗi kết nối:', error);
                        hocphanSelect.innerHTML = '<option value="">-- Lỗi tải dữ liệu --</option>';
                        hocphanSelect.style.borderColor = '#dc3545';
                        
                        // Hiển thị thông báo lỗi chi tiết
                        alert('Lỗi tải dữ liệu: ' + error.message);
                    });
                    
            } else {
                // Ẩn phần học phần nếu chưa chọn chương trình
                hocphanSection.style.display = 'none';
                hocphanSelect.innerHTML = '<option value="">-- Chọn môn học --</option>';
                mahpInput.value = '';
            }
        });
        // CẬP NHẬT MÃ HỌC PHẦN KHI CHỌN HỌC PHẦN
        document.getElementById('hocphan').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const mahpInput = document.getElementById('mahp');
            const tongLt = document.getElementById('gio_tong-lt');
            const trucTiepLt = document.getElementById('gio_tructiep-lt');
            const onlineLt = document.getElementById('gio_online-lt');

            if (selectedOption.value && selectedOption.dataset.code) {
                mahpInput.value = selectedOption.dataset.code;

                // 🟢 Lấy dữ liệu số giờ từ thuộc tính dataset
                const theoryHours = parseFloat(selectedOption.dataset.theoryHours || 0);
                const tongGio = theoryHours;
                const onlineGio = +(tongGio * 0.2).toFixed(1);
                const trucTiepGio = tongGio - onlineGio;

                // 🟢 Hiển thị vào các ô input
                tongLt.value = tongGio;
                trucTiepLt.value = trucTiepGio;
                onlineLt.value = onlineGio;

                // 🟢 Hiệu ứng khi cập nhật
                [tongLt, trucTiepLt, onlineLt].forEach(input => {
                    input.style.borderColor = '#28a745';
                    input.style.backgroundColor = '#f8fff9';
                    setTimeout(() => {
                        input.style.borderColor = '';
                        input.style.backgroundColor = '';
                    }, 1500);
                });

            } else {
                mahpInput.value = '';
                tongLt.value = '';
                trucTiepLt.value = '';
                onlineLt.value = '';
            }
        });


        // Hàm test kết nối AJAX
        function testAjaxConnection() {
            const testUrl = '../ajax/get_subjects.php?program_code=CNTT';
            console.log('Testing AJAX connection to:', testUrl);
            
            fetch(testUrl)
                .then(response => {
                    console.log('Test Response Status:', response.status);
                    return response.text();
                })
                .then(data => {
                    console.log('Test Raw Response:', data);
                    try {
                        const jsonData = JSON.parse(data);
                        console.log('Test Parsed JSON:', jsonData);
                    } catch (e) {
                        console.log('Response is not JSON:', data.substring(0, 200));
                    }
                })
                .catch(error => {
                    console.error('Test Connection Error:', error);
                });
        }

        // Test khi trang load
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded, testing AJAX connection...');
            testAjaxConnection();
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
    <script>
                // Hàm tạo mã lớp tự động
        function generateClassCode(selectedYear, selectedSemester, subjectCode, hasPracticeHours, classCount, teachingFormat) {
            // Lấy 2 số cuối năm học (ví dụ: 2025 -> 25)
            const yearShort = selectedYear.substring(2, 4);
            
            // Xác định học kỳ a/b dựa trên số lớp
            const semesterType = classCount % 2 === 0 ? 'a' : 'b';
            const semesterCode = selectedSemester + semesterType;
            
            // Kiểm tra có thực hành không
            const practiceCode = hasPracticeHours ? '(BT)' : '';
            
            // Format số lớp (01, 02, ...)
            const classNumber = classCount.toString().padStart(2, '0');
            
            // Tạo mã lớp hoàn chỉnh
            return `${yearShort}${semesterCode}_${subjectCode}_${practiceCode}_${classNumber}_${teachingFormat}`;
        }

        // Xử lý khi chọn học phần
        document.getElementById('hocphan').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const yearSelect = document.getElementById('namhoc');
            const classDropdown = document.getElementById('class-dropdown'); // Dropdown mới
            
            if (selectedOption.value && yearSelect.value) {
                // Lấy thông tin từ các dropdown
                const selectedYear = yearSelect.options[yearSelect.selectedIndex].text;
                const selectedSemester = selectedOption.dataset.semester; // Cần thêm semester vào dataset
                const subjectCode = selectedOption.dataset.code;
                const hasPracticeHours = parseInt(selectedOption.dataset.practiceHours) > 0;
                
                // Tạo dropdown lớp học
                classDropdown.innerHTML = '<option value="">-- Chọn lớp --</option>';
                
                // Tạo 2 lớp cho mỗi học kỳ (a và b)
                for (let i = 1; i <= 2; i++) {
                    const classCount = i;
                    const teachingFormat = 'tructiep'; // Có thể thêm dropdown chọn hình thức
                    
                    const classCode = generateClassCode(selectedYear, selectedSemester, subjectCode, hasPracticeHours, classCount, teachingFormat);
                    
                    const option = document.createElement('option');
                    option.value = classCode;
                    option.textContent = classCode;
                    option.dataset.classCount = classCount;
                    option.dataset.teachingFormat = teachingFormat;
                    
                    classDropdown.appendChild(option);
                }
                
                // Hiển thị dropdown lớp học
                document.getElementById('class-section').style.display = 'block';
            }
        });
    </script>
    <script src="../js/sidebar.js"></script>
</body>
</html>