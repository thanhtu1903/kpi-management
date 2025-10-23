<?php
require_once '../includes/config.php';
require_once '../includes/headeradmin.php';
require_once '../includes/sidebaradmin.php';

// Kết nối database


// Xử lý phân trang và tìm kiếm
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = 10;
$offset = ($page - 1) * $limit;

$search = isset($_GET['search']) ? $_GET['search'] : '';
$user_type = isset($_GET['user_type']) ? $_GET['user_type'] : '';
$department_id = isset($_GET['department_id']) ? $_GET['department_id'] : '';
$status = isset($_GET['status']) ? $_GET['status'] : '';

// Xây dựng điều kiện WHERE
$whereConditions = [];
$params = [];

if (!empty($search)) {
    $whereConditions[] = "(u.username LIKE ? OR u.full_name LIKE ? OR u.email LIKE ?)";
    $params[] = "%$search%";
    $params[] = "%$search%";
    $params[] = "%$search%";
}

if (!empty($user_type)) {
    $whereConditions[] = "u.user_type = ?";
    $params[] = $user_type;
}

if (!empty($department_id)) {
    $whereConditions[] = "u.department_id = ?";
    $params[] = $department_id;
}

if (!empty($status)) {
    $whereConditions[] = "u.is_active = ?";
    $params[] = ($status == 'active') ? 1 : 0;
}

$whereSQL = '';
if (!empty($whereConditions)) {
    $whereSQL = 'WHERE ' . implode(' AND ', $whereConditions);
}

try {
    // Đếm tổng số bản ghi cho phân trang
    $countSql = "SELECT COUNT(*) as total FROM users u $whereSQL";
    if (!empty($params)) {
        $stmt = $pdo->prepare($countSql);
        $stmt->execute($params);
    } else {
        $stmt = $pdo->query($countSql);
    }
    $totalUsers = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    $totalPages = ceil($totalUsers / $limit);

    // Lấy danh sách người dùng - SỬA LẠI PHẦN NÀY
    $sql = "SELECT u.*, d.department_name 
            FROM users u 
            LEFT JOIN departments d ON u.department_id = d.id 
            $whereSQL 
            ORDER BY u.created_at DESC 
            LIMIT $limit OFFSET $offset";
    
    if (!empty($params)) {
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
    } else {
        $stmt = $pdo->query($sql);
    }
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Lấy danh sách khoa cho filter
    $departments = $pdo->query("SELECT id, department_name FROM departments WHERE is_active = 1")->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    $error = "Lỗi kết nối database: " . $e->getMessage();
}
?>
<style>
    .page-header{
        padding-top: 100px;
    }
</style>
<div class="main-content">
    <div class="container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Quản lý Người dùng</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="../index.php">Dashboard</a></li>
                    <li class="breadcrumb-item active">Quản lý Người dùng</li>
                </ol>
            </nav>
        </div>

        <!-- Hiển thị lỗi nếu có -->
        <?php if (isset($error)): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Lỗi!</strong> <?php echo $error; ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <!-- Action Buttons -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <a href="manage.php" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Thêm người dùng mới
                        </a>
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#exportModal">
                            <i class="fas fa-download me-2"></i>Xuất Excel
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="card shadow mb-4">
            <div class="card-header">
                <h6 class="card-title m-0 font-weight-bold text-primary">
                    <i class="fas fa-filter me-2"></i>Bộ lọc
                </h6>
            </div>
            <div class="card-body">
                <form method="GET" action="">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label">Tìm kiếm</label>
                            <input type="text" class="form-control" name="search" value="<?php echo htmlspecialchars($search); ?>" 
                                   placeholder="Username, tên, email...">
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Loại người dùng</label>
                            <select class="form-select" name="user_type">
                                <option value="">Tất cả</option>
                                <option value="admin" <?php echo $user_type == 'admin' ? 'selected' : ''; ?>>Admin</option>
                                <option value="giangvien" <?php echo $user_type == 'giangvien' ? 'selected' : ''; ?>>Giảng viên</option>
                                <option value="truongkhoa" <?php echo $user_type == 'truongkhoa' ? 'selected' : ''; ?>>Trưởng khoa</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Khoa/Bộ môn</label>
                            <select class="form-select" name="department_id">
                                <option value="">Tất cả</option>
                                <?php foreach ($departments as $dept): ?>
                                    <option value="<?php echo $dept['id']; ?>" 
                                        <?php echo $department_id == $dept['id'] ? 'selected' : ''; ?>>
                                        <?php echo htmlspecialchars($dept['department_name']); ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Trạng thái</label>
                            <select class="form-select" name="status">
                                <option value="">Tất cả</option>
                                <option value="active" <?php echo $status == 'active' ? 'selected' : ''; ?>>Hoạt động</option>
                                <option value="inactive" <?php echo $status == 'inactive' ? 'selected' : ''; ?>>Không hoạt động</option>
                            </select>
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <div class="d-flex gap-2 w-100">
                                <button type="submit" class="btn btn-primary flex-fill">
                                    <i class="fas fa-search me-2"></i>Tìm kiếm
                                </button>
                                <a href="index.php" class="btn btn-outline-secondary">
                                    <i class="fas fa-refresh me-2"></i>Reset
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Users Table -->
        <div class="card shadow">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h6 class="card-title m-0 font-weight-bold text-primary">Danh sách người dùng</h6>
                <span class="text-muted">Tổng: <?php echo number_format($totalUsers); ?> người dùng</span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="usersTable">
                        <thead class="table-light">
                            <tr>
                                <th width="50">#</th>
                                <th>Username</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Loại người dùng</th>
                                <th>Khoa</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th width="150">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (count($users) > 0): ?>
                                <?php foreach ($users as $index => $user): ?>
                                    <tr>
                                        <td><?php echo $offset + $index + 1; ?></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <?php if (!empty($user['avatar_url'])): ?>
                                                    <img src="<?php echo htmlspecialchars($user['avatar_url']); ?>" 
                                                         class="rounded-circle me-2" width="32" height="32" 
                                                         alt="<?php echo htmlspecialchars($user['full_name']); ?>">
                                                <?php else: ?>
                                                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-2" 
                                                         style="width: 32px; height: 32px; font-size: 0.8rem;">
                                                        <?php echo strtoupper(substr($user['full_name'], 0, 1)); ?>
                                                    </div>
                                                <?php endif; ?>
                                                <strong><?php echo htmlspecialchars($user['username']); ?></strong>
                                            </div>
                                        </td>
                                        <td><?php echo htmlspecialchars($user['full_name']); ?></td>
                                        <td><?php echo htmlspecialchars($user['email']); ?></td>
                                        <td>
                                            <?php 
                                            $badge_class = [
                                                'admin' => 'bg-danger',
                                                'giangvien' => 'bg-primary',
                                                'truongkhoa' => 'bg-success'
                                            ];
                                            $type_text = [
                                                'admin' => 'Admin',
                                                'giangvien' => 'Giảng viên',
                                                'truongkhoa' => 'Trưởng khoa'
                                            ];
                                            ?>
                                            <span class="badge <?php echo $badge_class[$user['user_type']] ?? 'bg-secondary'; ?>">
                                                <?php echo $type_text[$user['user_type']] ?? $user['user_type']; ?>
                                            </span>
                                        </td>
                                        <td><?php echo htmlspecialchars($user['department_name'] ?? 'N/A'); ?></td>
                                        <td>
                                            <span class="badge <?php echo $user['is_active'] ? 'bg-success' : 'bg-secondary'; ?>">
                                                <?php echo $user['is_active'] ? 'Hoạt động' : 'Không hoạt động'; ?>
                                            </span>
                                        </td>
                                        <td><?php echo date('d/m/Y', strtotime($user['created_at'])); ?></td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <a href="manage.php?id=<?php echo $user['id']; ?>" 
                                                   class="btn btn-outline-primary" title="Sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="view.php?id=<?php echo $user['id']; ?>" 
                                                   class="btn btn-outline-info" title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <button type="button" class="btn btn-outline-warning reset-password-btn" 
                                                        data-user-id="<?php echo $user['id']; ?>" 
                                                        data-user-name="<?php echo htmlspecialchars($user['full_name']); ?>"
                                                        title="Reset mật khẩu">
                                                    <i class="fas fa-key"></i>
                                                </button>
                                                <button type="button" class="btn btn-outline-danger delete-user-btn" 
                                                        data-user-id="<?php echo $user['id']; ?>" 
                                                        data-user-name="<?php echo htmlspecialchars($user['full_name']); ?>"
                                                        title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <tr>
                                    <td colspan="9" class="text-center py-4">
                                        <div class="text-muted">
                                            <i class="fas fa-users fa-3x mb-3"></i>
                                            <h5>Không tìm thấy người dùng nào</h5>
                                            <p>Hãy thử thay đổi điều kiện tìm kiếm hoặc thêm người dùng mới</p>
                                        </div>
                                    </td>
                                </tr>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <?php if ($totalPages > 1): ?>
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item <?php echo $page <= 1 ? 'disabled' : ''; ?>">
                            <a class="page-link" href="?<?php echo http_build_query(array_merge($_GET, ['page' => $page - 1])); ?>">Trước</a>
                        </li>
                        
                        <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                            <li class="page-item <?php echo $i == $page ? 'active' : ''; ?>">
                                <a class="page-link" href="?<?php echo http_build_query(array_merge($_GET, ['page' => $i])); ?>">
                                    <?php echo $i; ?>
                                </a>
                            </li>
                        <?php endfor; ?>
                        
                        <li class="page-item <?php echo $page >= $totalPages ? 'disabled' : ''; ?>">
                            <a class="page-link" href="?<?php echo http_build_query(array_merge($_GET, ['page' => $page + 1])); ?>">Sau</a>
                        </li>
                    </ul>
                </nav>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<!-- Reset Password Modal -->
<div class="modal fade" id="resetPasswordModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Reset mật khẩu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn reset mật khẩu của <strong id="resetUserName"></strong>?</p>
                <p class="text-muted">Mật khẩu mới sẽ được gửi qua email.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-warning" id="confirmResetPassword">Reset mật khẩu</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete User Modal -->
<div class="modal fade" id="deleteUserModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xóa người dùng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn xóa người dùng <strong id="deleteUserName"></strong>?</p>
                <p class="text-danger"><small>Hành động này không thể hoàn tác. Tất cả dữ liệu liên quan sẽ bị xóa.</small></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteUser">Xóa người dùng</button>
            </div>
        </div>
    </div>
</div>

<!-- Export Modal -->
<div class="modal fade" id="exportModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xuất dữ liệu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="exportForm" action="export.php" method="POST">
                    <div class="mb-3">
                        <label class="form-label">Định dạng</label>
                        <select class="form-select" name="format">
                            <option value="excel">Excel (.xlsx)</option>
                            <option value="csv">CSV (.csv)</option>
                            <option value="pdf">PDF (.pdf)</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Loại dữ liệu</label>
                        <select class="form-select" name="data_type">
                            <option value="all">Tất cả người dùng</option>
                            <option value="current">Kết quả tìm kiếm hiện tại</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" form="exportForm" class="btn btn-primary">Xuất dữ liệu</button>
            </div>
        </div>
    </div>
</div>

<script>
// Reset Password
document.querySelectorAll('.reset-password-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        const userId = this.getAttribute('data-user-id');
        const userName = this.getAttribute('data-user-name');
        
        document.getElementById('resetUserName').textContent = userName;
        document.getElementById('confirmResetPassword').setAttribute('data-user-id', userId);
        
        new bootstrap.Modal(document.getElementById('resetPasswordModal')).show();
    });
});

document.getElementById('confirmResetPassword').addEventListener('click', function() {
    const userId = this.getAttribute('data-user-id');
    
    // Gửi request reset password
    fetch('reset_password.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ user_id: userId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Reset mật khẩu thành công! Mật khẩu mới đã được gửi qua email.');
            bootstrap.Modal.getInstance(document.getElementById('resetPasswordModal')).hide();
        } else {
            alert('Lỗi: ' + data.message);
        }
    })
    .catch(error => {
        alert('Lỗi kết nối: ' + error);
    });
});

// Delete User
document.querySelectorAll('.delete-user-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        const userId = this.getAttribute('data-user-id');
        const userName = this.getAttribute('data-user-name');
        
        document.getElementById('deleteUserName').textContent = userName;
        document.getElementById('confirmDeleteUser').setAttribute('data-user-id', userId);
        
        new bootstrap.Modal(document.getElementById('deleteUserModal')).show();
    });
});

document.getElementById('confirmDeleteUser').addEventListener('click', function() {
    const userId = this.getAttribute('data-user-id');
    
    // Gửi request xóa user
    fetch('delete_user.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ user_id: userId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Xóa người dùng thành công!');
            location.reload();
        } else {
            alert('Lỗi: ' + data.message);
        }
    })
    .catch(error => {
        alert('Lỗi kết nối: ' + error);
    });
});
</script>

<?php require_once '../includes/footer.php'; ?>