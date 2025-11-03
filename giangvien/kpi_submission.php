<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/kpi_functions.php';

// Kiểm tra đăng nhập và phân quyền giảng viên
if (!isLoggedIn() || $_SESSION['user_type'] !== 'giangvien') {
    header('Location: login.php');
    exit;
}

$user_id = $_SESSION['user_id'];
$current_cycle = getCurrentEvaluationCycle();

// Xử lý submit KPI
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $result = processKpiSubmission($user_id, $current_cycle['id'], $_POST);
    if ($result['success']) {
        $success_message = $result['message'];
    } else {
        $error_message = $result['message'];
    }
}

// Lấy dữ liệu KPI đã nhập
$existing_kpi_data = getLecturerKpiData($user_id, $current_cycle['id']);
$kpi_indicators = getKpiIndicators();
$kpi_groups = getKpiGroups();

?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập KPI - Hệ thống Đánh giá Giảng viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #4cc9f0;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --hover-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        body {
            background-color: #f5f7fb;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border-radius: 1rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--card-shadow);
        }

        .kpi-group-card {
            background: white;
            border-radius: 1rem;
            border: none;
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .kpi-group-card:hover {
            box-shadow: var(--hover-shadow);
            transform: translateY(-2px);
        }

        .kpi-group-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
            border-bottom: none;
        }

        .kpi-indicator-card {
            border: 1px solid #e9ecef;
            border-radius: 0.75rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .kpi-indicator-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .kpi-indicator-card.completed {
            border-left: 4px solid #28a745;
        }

        .kpi-indicator-card.pending {
            border-left: 4px solid #ffc107;
        }

        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            text-align: center;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--hover-shadow);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .floating-actions {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            z-index: 1000;
        }

        .floating-btn {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .floating-btn:hover {
            transform: scale(1.1);
        }

        .file-upload-area {
            border: 2px dashed #dee2e6;
            border-radius: 0.75rem;
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            background: var(--light-bg);
        }

        .file-upload-area:hover {
            border-color: var(--primary-color);
            background: rgba(67, 97, 238, 0.05);
        }

        .file-upload-area.dragover {
            border-color: var(--primary-color);
            background: rgba(67, 97, 238, 0.1);
        }

        .nav-tabs-custom {
            background: white;
            border-radius: 1rem;
            padding: 1rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
        }

        .progress-ring {
            transform: rotate(-90deg);
        }

        .progress-ring-circle {
            transition: stroke-dashoffset 0.3s ease;
        }

        .search-box {
            max-width: 300px;
        }

        .auto-save-indicator {
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 1050;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .auto-save-indicator.show {
            opacity: 1;
        }

        .kpi-summary {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .dashboard-header {
                padding: 1.5rem;
                margin-bottom: 1rem;
            }
            
            .floating-actions {
                bottom: 1rem;
                right: 1rem;
            }
            
            .floating-btn {
                width: 50px;
                height: 50px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">
                <i class="fas fa-chart-line me-2"></i>HỆ THỐNG KPI
            </a>
            <div class="navbar-nav ms-auto align-items-center">
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                        <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px;">
                            <i class="fas fa-user text-primary"></i>
                        </div>
                        <span><?php echo $_SESSION['full_name']; ?></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>Hồ sơ</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i>Cài đặt</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout.php"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <!-- Auto-save Indicator -->
    <div class="auto-save-indicator alert alert-success" id="autoSaveIndicator">
        <i class="fas fa-check-circle me-2"></i>Đã tự động lưu
    </div>

    <div class="container mt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header animate__animated animate__fadeIn">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="h2 mb-2"><i class="fas fa-tasks me-2"></i>Nhập chỉ số KPI</h1>
                    <p class="mb-1">Chu kỳ đánh giá: <strong><?php echo $current_cycle['cycle_name']; ?></strong></p>
                    <p class="mb-0">
                        <i class="fas fa-clock me-1"></i>
                        Hạn nộp: <?php echo date('d/m/Y', strtotime($current_cycle['submission_deadline'])); ?>
                        <?php 
                        $days_left = ceil((strtotime($current_cycle['submission_deadline']) - time()) / (60 * 60 * 24));
                        if ($days_left > 0) {
                            echo "<span class='badge bg-light text-dark ms-2'>Còn $days_left ngày</span>";
                        } elseif ($days_left == 0) {
                            echo "<span class='badge bg-warning ms-2'>Hạn cuối hôm nay</span>";
                        } else {
                            echo "<span class='badge bg-danger ms-2'>Đã quá hạn</span>";
                        }
                        ?>
                    </p>
                </div>
                <div class="col-md-4 text-end">
                    <?php
                    $submission_stats = getKpiSubmissionStats($user_id, $current_cycle['id']);
                    $completion_rate = $submission_stats['total_indicators'] > 0 ? 
                        ($submission_stats['submitted_indicators'] / $submission_stats['total_indicators']) * 100 : 0;
                    ?>
                    <div class="d-flex align-items-center justify-content-end">
                        <div class="me-3 text-end">
                            <div class="h4 mb-0"><?php echo round($completion_rate); ?>%</div>
                            <small>Hoàn thành</small>
                        </div>
                        <div class="position-relative" style="width: 80px; height: 80px;">
                            <svg class="progress-ring" width="80" height="80">
                                <circle class="progress-ring-circle" 
                                    stroke="white" 
                                    stroke-width="4" 
                                    fill="transparent" 
                                    r="36" 
                                    cx="40" 
                                    cy="40"
                                    stroke-dasharray="226.2"
                                    stroke-dashoffset="<?php echo 226.2 - (226.2 * $completion_rate / 100); ?>"/>
                            </svg>
                            <div class="position-absolute top-50 start-50 translate-middle">
                                <i class="fas fa-check text-white"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="quick-stats">
            <div class="stat-card">
                <div class="stat-number text-primary"><?php echo $submission_stats['total_indicators']; ?></div>
                <div class="text-muted">Tổng chỉ số</div>
            </div>
            <div class="stat-card">
                <div class="stat-number text-success"><?php echo $submission_stats['submitted_indicators']; ?></div>
                <div class="text-muted">Đã hoàn thành</div>
            </div>
            <div class="stat-card">
                <div class="stat-number text-warning"><?php echo $submission_stats['total_indicators'] - $submission_stats['submitted_indicators']; ?></div>
                <div class="text-muted">Chưa hoàn thành</div>
            </div>
            <div class="stat-card">
                <div class="stat-number text-info"><?php echo count($kpi_groups); ?></div>
                <div class="text-muted">Nhóm chỉ số</div>
            </div>
        </div>

        <!-- Messages -->
        <?php if (isset($success_message)): ?>
            <div class="alert alert-success alert-dismissible fade show animate__animated animate__fadeIn" role="alert">
                <div class="d-flex align-items-center">
                    <i class="fas fa-check-circle me-2"></i>
                    <div><?php echo $success_message; ?></div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <?php if (isset($error_message)): ?>
            <div class="alert alert-danger alert-dismissible fade show animate__animated animate__fadeIn" role="alert">
                <div class="d-flex align-items-center">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <div><?php echo $error_message; ?></div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <!-- Search and Filter -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="search-box">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0">
                        <i class="fas fa-search text-muted"></i>
                    </span>
                    <input type="text" class="form-control border-start-0" id="searchKpi" placeholder="Tìm kiếm chỉ số KPI...">
                </div>
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-outline-primary btn-sm" id="expandAll">
                    <i class="fas fa-expand me-1"></i>Mở rộng tất cả
                </button>
                <button class="btn btn-outline-secondary btn-sm" id="collapseAll">
                    <i class="fas fa-compress me-1"></i>Thu gọn tất cả
                </button>
            </div>
        </div>

        <!-- KPI Summary -->
        <div class="kpi-summary">
            <h5 class="mb-3"><i class="fas fa-chart-pie me-2"></i>Tổng quan KPI</h5>
            <div class="row">
                <?php foreach ($kpi_groups as $group): ?>
                    <?php
                    $group_indicators = array_filter($kpi_indicators, function($indicator) use ($group) {
                        return $indicator['kpi_group_id'] == $group['id'];
                    });
                    $completed_in_group = 0;
                    foreach ($group_indicators as $indicator) {
                        foreach ($existing_kpi_data as $data) {
                            if ($data['kpi_indicator_id'] == $indicator['id']) {
                                $completed_in_group++;
                                break;
                            }
                        }
                    }
                    $group_completion = count($group_indicators) > 0 ? ($completed_in_group / count($group_indicators)) * 100 : 0;
                    ?>
                    <div class="col-md-3 col-6 mb-3">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-light rounded p-2 me-2">
                                    <i class="fas fa-folder text-primary"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1">
                                <div class="fw-bold small"><?php echo $group['group_name']; ?></div>
                                <div class="progress" style="height: 4px;">
                                    <div class="progress-bar" role="progressbar" 
                                         style="width: <?php echo $group_completion; ?>%; background-color: #4361ee;">
                                    </div>
                                </div>
                                <small class="text-muted"><?php echo $completed_in_group; ?>/<?php echo count($group_indicators); ?></small>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>

        <!-- KPI Form -->
        <form method="POST" enctype="multipart/form-data" id="kpiForm">
            <div class="accordion" id="kpiAccordion">
                <?php foreach ($kpi_groups as $index => $group): ?>
                    <div class="kpi-group-card">
                        <div class="kpi-group-header" id="heading<?php echo $index; ?>">
                            <h5 class="mb-0">
                                <button class="btn btn-link text-white text-decoration-none w-100 text-start d-flex justify-content-between align-items-center" 
                                        type="button" 
                                        data-bs-toggle="collapse" 
                                        data-bs-target="#collapse<?php echo $index; ?>" 
                                        aria-expanded="true" 
                                        aria-controls="collapse<?php echo $index; ?>">
                                    <span>
                                        <i class="fas fa-folder-open me-2"></i>
                                        <?php echo $group['group_name']; ?>
                                    </span>
                                    <span class="badge bg-light text-dark">
                                        <i class="fas fa-weight-hanging me-1"></i>
                                        <?php echo ($group['weight'] * 100); ?>%
                                    </span>
                                </button>
                            </h5>
                        </div>

                        <div id="collapse<?php echo $index; ?>" 
                             class="collapse <?php echo $index === 0 ? 'show' : ''; ?>" 
                             aria-labelledby="heading<?php echo $index; ?>" 
                             data-bs-parent="#kpiAccordion">
                            <div class="card-body">
                                <?php
                                $group_indicators = array_filter($kpi_indicators, function($indicator) use ($group) {
                                    return $indicator['kpi_group_id'] == $group['id'];
                                });
                                ?>

                                <?php foreach ($group_indicators as $indicator): ?>
                                    <?php
                                    $existing_data = null;
                                    foreach ($existing_kpi_data as $data) {
                                        if ($data['kpi_indicator_id'] == $indicator['id']) {
                                            $existing_data = $data;
                                            break;
                                        }
                                    }
                                    $card_class = $existing_data ? 'completed' : 'pending';
                                    ?>
                                    <div class="kpi-indicator-card <?php echo $card_class; ?>" data-kpi-code="<?php echo strtolower($indicator['indicator_code']); ?>">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-lg-8">
                                                    <div class="d-flex align-items-start mb-2">
                                                        <h6 class="card-title mb-0 flex-grow-1 <?php echo $indicator['is_required'] ? 'required-field' : ''; ?>">
                                                            <?php echo $indicator['indicator_name']; ?>
                                                        </h6>
                                                        <div class="ms-2">
                                                            <span class="badge bg-primary">
                                                                <?php echo $indicator['indicator_code']; ?>
                                                            </span>
                                                            <?php if ($existing_data): ?>
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-check"></i> Đã nộp
                                                                </span>
                                                            <?php endif; ?>
                                                        </div>
                                                    </div>
                                                    
                                                    <p class="card-text text-muted small mb-3">
                                                        <?php echo $indicator['description']; ?>
                                                    </p>
                                                    
                                                    <div class="row g-3">
                                                        <div class="col-sm-4">
                                                            <small class="text-muted">
                                                                <i class="fas fa-ruler me-1"></i>
                                                                <strong>Đơn vị:</strong> <?php echo $indicator['measurement_unit']; ?>
                                                            </small>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <small class="text-muted">
                                                                <i class="fas fa-bullseye me-1"></i>
                                                                <strong>Chỉ tiêu:</strong> <?php echo $indicator['target_value']; ?>
                                                            </small>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <small class="text-muted">
                                                                <i class="fas fa-weight-hanging me-1"></i>
                                                                <strong>Trọng số:</strong> <?php echo ($indicator['weight'] * 100); ?>%
                                                            </small>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold">Giá trị thực tế</label>
                                                        <input type="number" 
                                                               step="0.01"
                                                               class="form-control form-control-lg" 
                                                               name="actual_value[<?php echo $indicator['id']; ?>]"
                                                               value="<?php echo $existing_data ? $existing_data['actual_value'] : ''; ?>"
                                                               placeholder="Nhập giá trị..."
                                                               <?php echo $indicator['is_required'] ? 'required' : ''; ?>>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Evidence Upload Section -->
                                            <div class="row mt-4">
                                                <div class="col-12">
                                                    <label class="form-label fw-bold">
                                                        <i class="fas fa-paperclip me-1"></i>
                                                        Minh chứng
                                                    </label>
                                                    <div class="file-upload-area" 
                                                         id="uploadArea_<?php echo $indicator['id']; ?>"
                                                         onclick="document.getElementById('evidence_<?php echo $indicator['id']; ?>').click()">
                                                        <i class="fas fa-cloud-upload-alt fa-2x text-muted mb-3"></i>
                                                        <p class="mb-1 fw-bold">Kéo thả file hoặc nhấn để tải lên</p>
                                                        <small class="text-muted">PDF, DOC, DOCX, JPG, PNG (Tối đa 10MB)</small>
                                                    </div>
                                                    <input type="file" 
                                                           id="evidence_<?php echo $indicator['id']; ?>"
                                                           name="evidence_file[<?php echo $indicator['id']; ?>]"
                                                           class="d-none"
                                                           accept=".pdf,.doc,.docx,.xls,.xlsx,.jpg,.png,.zip"
                                                           onchange="handleFileSelect(this, <?php echo $indicator['id']; ?>)">
                                                    
                                                    <div id="filePreview_<?php echo $indicator['id']; ?>" class="mt-2">
                                                        <?php if ($existing_data && $existing_data['evidence_file_url']): ?>
                                                            <div class="d-flex align-items-center justify-content-between bg-light rounded p-2">
                                                                <div class="d-flex align-items-center">
                                                                    <i class="fas fa-file text-primary me-2"></i>
                                                                    <span><?php echo basename($existing_data['evidence_file_url']); ?></span>
                                                                </div>
                                                                <div>
                                                                    <a href="<?php echo $existing_data['evidence_file_url']; ?>" 
                                                                       target="_blank" class="btn btn-sm btn-outline-primary me-1">
                                                                        <i class="fas fa-eye"></i>
                                                                    </a>
                                                                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeFile(<?php echo $indicator['id']; ?>)">
                                                                        <i class="fas fa-times"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        <?php endif; ?>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Evidence Description -->
                                            <div class="row mt-3">
                                                <div class="col-12">
                                                    <label class="form-label fw-bold">
                                                        <i class="fas fa-comment me-1"></i>
                                                        Mô tả minh chứng
                                                    </label>
                                                    <textarea class="form-control" 
                                                              name="evidence_description[<?php echo $indicator['id']; ?>]"
                                                              rows="2"
                                                              placeholder="Mô tả ngắn gọn về minh chứng đã nộp..."><?php 
                                                        echo $existing_data ? $existing_data['evidence_description'] : ''; 
                                                    ?></textarea>
                                                </div>
                                            </div>

                                            <!-- Notes -->
                                            <div class="row mt-3">
                                                <div class="col-12">
                                                    <label class="form-label fw-bold">
                                                        <i class="fas fa-sticky-note me-1"></i>
                                                        Ghi chú
                                                    </label>
                                                    <textarea class="form-control" 
                                                              name="notes[<?php echo $indicator['id']; ?>]"
                                                              rows="2"
                                                              placeholder="Ghi chú thêm (nếu có)..."><?php 
                                                        echo $existing_data ? $existing_data['notes'] : ''; 
                                                    ?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </form>
    </div>

    <!-- Floating Action Buttons -->
    <div class="floating-actions">
        <div class="d-flex flex-column gap-2">
            <button type="submit" form="kpiForm" name="action" value="submit" class="floating-btn btn btn-success" title="Nộp KPI">
                <i class="fas fa-paper-plane"></i>
            </button>
            <button type="submit" form="kpiForm" name="action" value="save_draft" class="floating-btn btn btn-primary" title="Lưu nháp">
                <i class="fas fa-save"></i>
            </button>
            <button type="button" class="floating-btn btn btn-info" onclick="scrollToTop()" title="Lên đầu trang">
                <i class="fas fa-arrow-up"></i>
            </button>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-light mt-5 py-4">
        <div class="container text-center">
            <p class="text-muted mb-0">
                <i class="fas fa-copyright me-1"></i>
                2024 Hệ thống Đánh giá KPI Giảng viên
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // File upload handling
        function handleFileSelect(input, indicatorId) {
            const file = input.files[0];
            if (file) {
                const preview = document.getElementById(`filePreview_${indicatorId}`);
                const uploadArea = document.getElementById(`uploadArea_${indicatorId}`);
                
                uploadArea.innerHTML = `
                    <i class="fas fa-check-circle fa-2x text-success mb-3"></i>
                    <p class="mb-1 fw-bold text-success">${file.name}</p>
                    <small class="text-muted">${(file.size / 1024 / 1024).toFixed(2)} MB</small>
                `;
                
                preview.innerHTML = `
                    <div class="d-flex align-items-center justify-content-between bg-light rounded p-2">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-file text-primary me-2"></i>
                            <span>${file.name}</span>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeFile(${indicatorId})">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `;
            }
        }

        function removeFile(indicatorId) {
            const input = document.getElementById(`evidence_${indicatorId}`);
            const preview = document.getElementById(`filePreview_${indicatorId}`);
            const uploadArea = document.getElementById(`uploadArea_${indicatorId}`);
            
            input.value = '';
            preview.innerHTML = '';
            uploadArea.innerHTML = `
                <i class="fas fa-cloud-upload-alt fa-2x text-muted mb-3"></i>
                <p class="mb-1 fw-bold">Kéo thả file hoặc nhấn để tải lên</p>
                <small class="text-muted">PDF, DOC, DOCX, JPG, PNG (Tối đa 10MB)</small>
            `;
        }

        // Drag and drop functionality
        document.querySelectorAll('.file-upload-area').forEach(area => {
            area.addEventListener('dragover', function(e) {
                e.preventDefault();
                this.classList.add('dragover');
            });
            
            area.addEventListener('dragleave', function(e) {
                e.preventDefault();
                this.classList.remove('dragover');
            });
            
            area.addEventListener('drop', function(e) {
                e.preventDefault();
                this.classList.remove('dragover');
                const indicatorId = this.id.split('_')[1];
                const input = document.getElementById(`evidence_${indicatorId}`);
                input.files = e.dataTransfer.files;
                handleFileSelect(input, indicatorId);
            });
        });

        // Search functionality
        document.getElementById('searchKpi').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const kpiCards = document.querySelectorAll('.kpi-indicator-card');
            
            kpiCards.forEach(card => {
                const kpiCode = card.getAttribute('data-kpi-code');
                const cardText = card.textContent.toLowerCase();
                
                if (cardText.includes(searchTerm) || kpiCode.includes(searchTerm)) {
                    card.style.display = 'block';
                    // Highlight matching text
                    card.innerHTML = card.innerHTML.replace(
                        new RegExp(searchTerm, 'gi'),
                        match => `<mark class="bg-warning">${match}</mark>`
                    );
                } else {
                    card.style.display = 'none';
                }
            });
        });

        // Expand/Collapse all
        document.getElementById('expandAll').addEventListener('click', function() {
            const collapses = document.querySelectorAll('.collapse');
            collapses.forEach(collapse => {
                new bootstrap.Collapse(collapse, { show: true });
            });
        });

        document.getElementById('collapseAll').addEventListener('click', function() {
            const collapses = document.querySelectorAll('.collapse');
            collapses.forEach(collapse => {
                new bootstrap.Collapse(collapse, { hide: true });
            });
        });

        // Auto-save functionality
        let autoSaveTimer;
        const autoSaveIndicator = document.getElementById('autoSaveIndicator');
        
        document.getElementById('kpiForm').addEventListener('input', function() {
            clearTimeout(autoSaveTimer);
            autoSaveTimer = setTimeout(function() {
                // Simulate auto-save
                autoSaveIndicator.classList.add('show');
                setTimeout(() => {
                    autoSaveIndicator.classList.remove('show');
                }, 3000);
                
                // In real implementation, you would send an AJAX request here
                console.log('Auto-saving...');
            }, 2000);
        });

        // Scroll to top
        function scrollToTop() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        // Progress animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            const progressCircles = document.querySelectorAll('.progress-ring-circle');
            progressCircles.forEach(circle => {
                const radius = circle.r.baseVal.value;
                const circumference = radius * 2 * Math.PI;
                circle.style.strokeDasharray = `${circumference} ${circumference}`;
            });
        });

        // Form validation and enhancement
        document.querySelectorAll('input[type="number"]').forEach(input => {
            input.addEventListener('blur', function() {
                const card = this.closest('.kpi-indicator-card');
                if (this.value.trim() !== '') {
                    card.classList.add('completed');
                    card.classList.remove('pending');
                } else {
                    card.classList.remove('completed');
                    card.classList.add('pending');
                }
                
                // Update completion stats
                updateCompletionStats();
            });
        });

        function updateCompletionStats() {
            const total = document.querySelectorAll('.kpi-indicator-card').length;
            const completed = document.querySelectorAll('.kpi-indicator-card.completed').length;
            const completionRate = total > 0 ? Math.round((completed / total) * 100) : 0;
            
            // Update progress ring
            const circle = document.querySelector('.progress-ring-circle');
            if (circle) {
                const radius = circle.r.baseVal.value;
                const circumference = radius * 2 * Math.PI;
                const offset = circumference - (completionRate / 100) * circumference;
                circle.style.strokeDashoffset = offset;
            }
            
            // Update completion text
            const completionText = document.querySelector('.dashboard-header .h4');
            if (completionText) {
                completionText.textContent = `${completionRate}%`;
            }
        }

        // Initialize completion stats
        updateCompletionStats();
    </script>
</body>
</html>