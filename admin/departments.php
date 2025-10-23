<?php
require_once '../includes/config.php';
require_once '../includes/headeradmin.php';
require_once '../includes/sidebaradmin.php';
?>

<div class="main-content">
    <div class="container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Quản lý Khoa/Bộ môn</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="../index.php">Dashboard</a></li>
                    <li class="breadcrumb-item active">Quản lý Khoa</li>
                </ol>
            </nav>
        </div>

        <!-- Action Buttons -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="d-flex justify-content-between">
                    <div>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDepartmentModal">
                            <i class="fas fa-plus me-2"></i>Thêm khoa mới
                        </button>
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary">
                            <i class="fas fa-download me-2"></i>Xuất Excel
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Departments Table -->
        <div class="card shadow">
            <div class="card-header">
                <h6 class="card-title m-0 font-weight-bold text-primary">Danh sách khoa/bộ môn</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="departmentsTable">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Mã khoa</th>
                                <th>Tên khoa</th>
                                <th>Trạng thái</th>
                                <th>Trưởng khoa</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>CNTT</td>
                                <td>Công nghệ thông tin</td>
                                <td><span class="badge bg-success">Hoạt động</span></td>
                                <td>Nguyễn Văn A</td>
                                <td>2024-01-01</td>
                                <td>
                                    <div class="btn-group">
                                        <button class="btn btn-sm btn-outline-primary" title="Sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-info" title="Chi tiết">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>KT</td>
                                <td>Kế toán</td>
                                <td><span class="badge bg-success">Hoạt động</span></td>
                                <td>Trần Thị B</td>
                                <td>2024-01-01</td>
                                <td>
                                    <div class="btn-group">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-info">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Department Modal -->
<div class="modal fade" id="addDepartmentModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm khoa mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="addDepartmentForm">
                    <div class="mb-3">
                        <label class="form-label">Mã khoa</label>
                        <input type="text" class="form-control" name="department_code" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tên khoa</label>
                        <input type="text" class="form-control" name="department_name" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="is_active" checked>
                            <label class="form-check-label">Kích hoạt</label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary">Lưu</button>
            </div>
        </div>
    </div>
</div>

<?php require_once '../../includes/footer.php'; ?>