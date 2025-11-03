-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 30, 2025 at 09:33 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kpi`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `table_name`, `record_id`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 5, 'SUBMIT_KPI', 'Giảng viên Phạm Văn An đã nộp minh chứng KPI cho tiêu chí TEACH_001', 'lecturer_kpi_data', 1, '192.168.1.100', NULL, '2025-10-15 19:39:45'),
(2, 2, 'APPROVE_KPI', 'Trưởng khoa Trần Văn Khoa đã duyệt minh chứng KPI cho giảng viên Phạm Văn An', 'lecturer_kpi_data', 1, '192.168.1.50', NULL, '2025-10-15 19:39:45'),
(3, 6, 'SUBMIT_KPI', 'Giảng viên Lê Văn Bình đã nộp minh chứng KPI cho tiêu chí TEACH_001', 'lecturer_kpi_data', 4, '192.168.1.101', NULL, '2025-10-15 19:39:45'),
(4, 3, 'REJECT_KPI', 'Trưởng khoa Lê Thị Hương đã từ chối minh chứng KPI cho giảng viên Hoàng Văn Đức', 'lecturer_kpi_data', 10, '192.168.1.51', NULL, '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `class_sections`
--

CREATE TABLE `class_sections` (
  `id` int(11) NOT NULL,
  `class_code` varchar(50) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `school_year_id` int(11) NOT NULL,
  `semester_type` varchar(10) NOT NULL,
  `class_number` int(11) NOT NULL,
  `teaching_format` varchar(20) NOT NULL,
  `has_practice` tinyint(4) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ctdt`
--

CREATE TABLE `ctdt` (
  `id_ctdt` int(11) NOT NULL,
  `ten_nganh` varchar(100) NOT NULL,
  `ma_nganh` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `department_code` varchar(20) NOT NULL,
  `department_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `department_code`, `department_name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'CNTT', 'Công nghệ Thông tin', 'Khoa Công nghệ Thông tin - Đào tạo kỹ sư CNTT chất lượng cao', 1, '2025-10-15 19:39:44', '2025-10-15 19:39:44'),
(2, 'KT', 'Kế toán - Kiểm toán', 'Khoa Kế toán và Kiểm toán - Chuyên ngành kế toán doanh nghiệp', 1, '2025-10-15 19:39:44', '2025-10-15 19:39:44'),
(3, 'NN', 'Ngoại ngữ', 'Khoa Ngoại ngữ - Đào tạo tiếng Anh, Trung, Nhật', 1, '2025-10-15 19:39:44', '2025-10-15 19:39:44'),
(4, 'QTKD', 'Quản trị Kinh doanh', 'Khoa Quản trị Kinh doanh - Đào tạo cử nhân QTKD', 1, '2025-10-15 19:39:44', '2025-10-15 19:39:44'),
(5, 'CO_KHI', 'Cơ khí - Chế tạo', 'Khoa Cơ khí và Chế tạo máy', 1, '2025-10-15 19:39:44', '2025-10-15 19:39:44'),
(6, 'KHDL', 'Khoa học dữ liệu', 'Khoa học dữ liệu và nghiên cứu\r\n', 1, '2025-10-20 06:43:15', '2025-10-20 06:43:15'),
(7, 'TTDPT', 'Truyền thông đa phương tiện', 'Sáng tạo và phát triển nội dung', 1, '2025-10-20 06:44:42', '2025-10-20 06:44:42');

-- --------------------------------------------------------

--
-- Table structure for table `department_heads`
--

CREATE TABLE `department_heads` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department_heads`
--

INSERT INTO `department_heads` (`id`, `user_id`, `department_id`, `start_date`, `end_date`, `is_active`, `created_at`) VALUES
(1, 2, 1, '2023-01-01', '2025-12-31', 1, '2025-10-15 19:39:45'),
(2, 3, 2, '2023-01-01', '2025-12-31', 1, '2025-10-15 19:39:45'),
(3, 4, 3, '2023-01-01', '2025-12-31', 1, '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `department_kpis`
--

CREATE TABLE `department_kpis` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `kpi_indicator_id` int(11) NOT NULL,
  `custom_weight` float DEFAULT NULL,
  `custom_target` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_cycles`
--

CREATE TABLE `evaluation_cycles` (
  `id` int(11) NOT NULL,
  `cycle_name` varchar(255) NOT NULL,
  `academic_year` varchar(20) NOT NULL,
  `semester` int(11) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `submission_deadline` date NOT NULL,
  `approval_deadline` date DEFAULT NULL,
  `status` enum('draft','active','closed','archived') DEFAULT 'draft',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluation_cycles`
--

INSERT INTO `evaluation_cycles` (`id`, `cycle_name`, `academic_year`, `semester`, `start_date`, `end_date`, `submission_deadline`, `approval_deadline`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Đánh giá HK1 2024', '2024-2025', 1, '2024-09-01', '2024-12-31', '2025-01-15', '2025-01-31', 'active', 1, '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(2, 'Đánh giá HK2 2024', '2024-2025', 2, '2025-01-01', '2025-05-31', '2025-06-15', '2025-06-30', 'draft', 1, '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(3, 'Đánh giá HK1 2023', '2023-2024', 1, '2023-09-01', '2023-12-31', '2024-01-15', '2024-01-31', 'closed', 1, '2025-10-15 19:39:45', '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `kpi_groups`
--

CREATE TABLE `kpi_groups` (
  `id` int(11) NOT NULL,
  `group_code` varchar(50) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `weight` float DEFAULT 0,
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kpi_groups`
--

INSERT INTO `kpi_groups` (`id`, `group_code`, `group_name`, `description`, `weight`, `display_order`, `is_active`, `created_at`) VALUES
(1, 'TEACHING', 'Giảng dạy', 'Các tiêu chí liên quan đến công tác giảng dạy', 0.4, 1, 1, '2025-10-15 19:39:45'),
(2, 'RESEARCH', 'Nghiên cứu khoa học', 'Các tiêu chí về nghiên cứu khoa học', 0.4, 2, 1, '2025-10-15 19:39:45'),
(3, 'SERVICE', 'Phục vụ', 'Các tiêu chí về phục vụ cộng đồng và nhà trường', 0.2, 3, 1, '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `kpi_indicators`
--

CREATE TABLE `kpi_indicators` (
  `id` int(11) NOT NULL,
  `indicator_code` varchar(50) NOT NULL,
  `indicator_name` varchar(500) NOT NULL,
  `description` text DEFAULT NULL,
  `kpi_group_id` int(11) NOT NULL,
  `measurement_unit` varchar(100) DEFAULT NULL,
  `target_value` decimal(10,2) DEFAULT NULL,
  `max_score` decimal(10,2) DEFAULT 100.00,
  `weight` float DEFAULT 1,
  `calculation_method` enum('auto','manual','formula') DEFAULT 'auto',
  `calculation_formula` text DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kpi_indicators`
--

INSERT INTO `kpi_indicators` (`id`, `indicator_code`, `indicator_name`, `description`, `kpi_group_id`, `measurement_unit`, `target_value`, `max_score`, `weight`, `calculation_method`, `calculation_formula`, `is_required`, `is_active`, `created_at`) VALUES
(1, 'TEACH_001', 'Số giờ giảng chuẩn', 'Tổng số giờ giảng chuẩn theo quy định', 1, 'giờ', 300.00, 100.00, 0.3, 'auto', 'IF(actual_value >= 300, 100, actual_value/300*100)', 1, 1, '2025-10-15 19:39:45'),
(2, 'TEACH_002', 'Chất lượng giảng dạy', 'Đánh giá từ sinh viên và đồng nghiệp', 1, 'điểm', 8.50, 100.00, 0.3, 'manual', NULL, 1, 1, '2025-10-15 19:39:45'),
(3, 'TEACH_003', 'Biên soạn giáo trình', 'Biên soạn, chỉnh sửa giáo trình, bài giảng', 1, 'bài/giáo trình', 1.00, 100.00, 0.2, 'auto', 'actual_value * 100', 0, 1, '2025-10-15 19:39:45'),
(4, 'TEACH_004', 'Hướng dẫn sinh viên', 'Hướng dẫn sinh viên nghiên cứu khoa học, đồ án', 1, 'sinh viên', 3.00, 100.00, 0.2, 'auto', 'IF(actual_value >= 3, 100, actual_value/3*100)', 1, 1, '2025-10-15 19:39:45'),
(5, 'RES_001', 'Bài báo khoa học', 'Bài báo đăng trên tạp chí chuyên ngành', 2, 'bài', 2.00, 100.00, 0.4, 'auto', 'actual_value * 50', 1, 1, '2025-10-15 19:39:45'),
(6, 'RES_002', 'Đề tài nghiên cứu', 'Chủ nhiệm hoặc tham gia đề tài NCKH', 2, 'đề tài', 1.00, 100.00, 0.3, 'auto', 'actual_value * 100', 1, 1, '2025-10-15 19:39:45'),
(7, 'RES_003', 'Báo cáo hội thảo', 'Báo cáo tại hội thảo trong nước và quốc tế', 2, 'báo cáo', 1.00, 100.00, 0.2, 'auto', 'actual_value * 100', 0, 1, '2025-10-15 19:39:45'),
(8, 'RES_004', 'Sách chuyên khảo', 'Xuất bản sách chuyên khảo, giáo trình', 2, 'cuốn', 0.50, 100.00, 0.1, 'auto', 'actual_value * 200', 0, 1, '2025-10-15 19:39:45'),
(9, 'SERV_001', 'Tham gia công tác Đảng, đoàn thể', 'Tham gia các hoạt động Đảng, đoàn thể', 3, 'lần', 5.00, 100.00, 0.3, 'auto', 'IF(actual_value >= 5, 100, actual_value/5*100)', 1, 1, '2025-10-15 19:39:45'),
(10, 'SERV_002', 'Công tác cố vấn học tập', 'Làm cố vấn học tập cho sinh viên', 3, 'lớp', 1.00, 100.00, 0.3, 'auto', 'actual_value * 100', 1, 1, '2025-10-15 19:39:45'),
(11, 'SERV_003', 'Tham gia hội đồng', 'Tham gia các hội đồng chuyên môn', 3, 'hội đồng', 2.00, 100.00, 0.2, 'auto', 'IF(actual_value >= 2, 100, actual_value/2*100)', 0, 1, '2025-10-15 19:39:45'),
(12, 'SERV_004', 'Hoạt động phong trào', 'Tham gia các hoạt động phong trào của trường', 3, 'hoạt động', 3.00, 100.00, 0.2, 'auto', 'IF(actual_value >= 3, 100, actual_value/3*100)', 0, 1, '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `kpi_summaries`
--

CREATE TABLE `kpi_summaries` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `evaluation_cycle_id` int(11) NOT NULL,
  `total_auto_score` decimal(10,2) DEFAULT 0.00,
  `total_final_score` decimal(10,2) DEFAULT 0.00,
  `teaching_score` decimal(10,2) DEFAULT 0.00,
  `research_score` decimal(10,2) DEFAULT 0.00,
  `service_score` decimal(10,2) DEFAULT 0.00,
  `ranking` int(11) DEFAULT NULL,
  `overall_rating` varchar(100) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `is_finalized` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kpi_summaries`
--

INSERT INTO `kpi_summaries` (`id`, `user_id`, `evaluation_cycle_id`, `total_auto_score`, `total_final_score`, `teaching_score`, `research_score`, `service_score`, `ranking`, `overall_rating`, `approved_by`, `approved_at`, `is_finalized`, `created_at`, `updated_at`) VALUES
(1, 5, 1, 345.00, 345.00, 195.00, 150.00, 0.00, 1, 'Xuất sắc', 2, NULL, 1, '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(2, 6, 1, 228.30, 228.30, 178.30, 50.00, 0.00, 2, 'Khá', 2, NULL, 1, '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(3, 7, 1, 203.30, NULL, 103.30, 100.00, 0.00, NULL, NULL, NULL, NULL, 0, '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(4, 8, 1, 116.70, NULL, 116.70, 0.00, 0.00, NULL, NULL, NULL, NULL, 0, '2025-10-15 19:39:45', '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_kpi_data`
--

CREATE TABLE `lecturer_kpi_data` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `kpi_indicator_id` int(11) NOT NULL,
  `evaluation_cycle_id` int(11) NOT NULL,
  `actual_value` decimal(15,4) DEFAULT NULL,
  `evidence_description` text DEFAULT NULL,
  `evidence_file_url` varchar(500) DEFAULT NULL,
  `auto_calculated_score` decimal(10,2) DEFAULT NULL,
  `final_score` decimal(10,2) DEFAULT NULL,
  `status` enum('draft','pending','approved','rejected','adjusted') DEFAULT 'draft',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lecturer_kpi_data`
--

INSERT INTO `lecturer_kpi_data` (`id`, `user_id`, `kpi_indicator_id`, `evaluation_cycle_id`, `actual_value`, `evidence_description`, `evidence_file_url`, `auto_calculated_score`, `final_score`, `status`, `submitted_at`, `approved_by`, `approved_at`, `rejection_reason`, `notes`, `created_at`, `updated_at`) VALUES
(1, 5, 1, 1, 320.0000, 'Đã giảng 320 giờ chuẩn theo phân công', '/uploads/evidence/gv1/teaching_hours.pdf', 100.00, 100.00, 'approved', '2025-01-10 02:30:00', 2, '2025-01-12 07:20:00', NULL, 'Hoàn thành tốt', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(2, 5, 2, 1, 8.7000, 'Điểm đánh giá từ sinh viên và đồng nghiệp', '/uploads/evidence/gv1/teaching_quality.pdf', NULL, 95.00, 'approved', '2025-01-10 02:30:00', 2, '2025-01-12 07:20:00', NULL, 'Chất lượng giảng dạy tốt', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(3, 5, 5, 1, 3.0000, '2 bài báo quốc tế, 1 bài báo trong nước', '/uploads/evidence/gv1/research_papers.zip', 150.00, 150.00, 'approved', '2025-01-10 02:30:00', 2, '2025-01-12 07:20:00', NULL, 'Vượt chỉ tiêu nghiên cứu', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(4, 6, 1, 1, 280.0000, 'Đã giảng 280 giờ chuẩn', '/uploads/evidence/gv2/teaching_hours.pdf', 93.30, 93.30, 'approved', '2025-01-11 03:15:00', 2, '2025-01-13 04:30:00', NULL, 'Đạt yêu cầu', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(5, 6, 2, 1, 8.2000, 'Điểm đánh giá từ sinh viên', '/uploads/evidence/gv2/teaching_quality.pdf', NULL, 85.00, 'approved', '2025-01-11 03:15:00', 2, '2025-01-13 04:30:00', NULL, 'Cần cải thiện phương pháp giảng dạy', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(6, 6, 5, 1, 1.0000, '1 bài báo trong nước', '/uploads/evidence/gv2/research_paper.pdf', 50.00, 50.00, 'approved', '2025-01-11 03:15:00', 2, '2025-01-13 04:30:00', NULL, 'Đạt mức tối thiểu', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(7, 7, 1, 1, 310.0000, 'Đã giảng 310 giờ chuẩn', '/uploads/evidence/gv3/teaching_hours.pdf', 103.30, NULL, 'pending', '2025-01-12 01:45:00', NULL, NULL, NULL, NULL, '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(8, 7, 5, 1, 2.0000, '2 bài báo quốc tế', '/uploads/evidence/gv3/research_papers.pdf', 100.00, NULL, 'pending', '2025-01-12 01:45:00', NULL, NULL, NULL, NULL, '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(9, 8, 1, 1, 350.0000, 'Số giờ giảng đã thực hiện', '/uploads/evidence/gv4/teaching_hours.pdf', 116.70, NULL, 'rejected', '2025-01-09 07:20:00', 3, '2025-01-11 09:45:00', 'File minh chứng không rõ ràng, không thấy xác nhận của phòng đào tạo', 'Vui lòng bổ sung minh chứng xác nhận từ phòng Đào tạo', '2025-10-15 19:39:45', '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `content` text NOT NULL,
  `notification_type` enum('system','approval','reminder','announcement') DEFAULT 'system',
  `sender_id` int(11) NOT NULL,
  `target_audience` enum('all','department','specific_users') DEFAULT 'all',
  `target_department_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT 0,
  `publish_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `title`, `content`, `notification_type`, `sender_id`, `target_audience`, `target_department_id`, `is_published`, `publish_at`, `created_at`) VALUES
(1, 'Thông báo hạn nộp minh chứng KPI HK1 2024', 'Kính gửi các thầy cô, hạn cuối nộp minh chứng KPI học kỳ 1 là ngày 15/01/2025. Các thầy cô vui lòng hoàn thành việc nhập liệu trước thời hạn.', 'reminder', 1, 'all', NULL, 1, '2025-01-01 01:00:00', '2025-10-15 19:39:45'),
(2, 'Kết quả đánh giá KPI học kỳ 1', 'Kết quả đánh giá KPI học kỳ 1 đã được duyệt. Các thầy cô có thể đăng nhập để xem kết quả chi tiết.', 'announcement', 2, 'department', 1, 1, '2025-02-01 02:00:00', '2025-10-15 19:39:45'),
(3, 'Họp tổng kết công tác giảng dạy', 'Mời các thầy cô khoa CNTT tham gia buổi họp tổng kết công tác giảng dạy học kỳ 1 vào lúc 14h00 ngày 05/02/2025 tại phòng họp A1.', 'announcement', 2, 'department', 1, 1, '2025-01-28 03:30:00', '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `notification_recipients`
--

CREATE TABLE `notification_recipients` (
  `id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `subject_name` varchar(255) NOT NULL,
  `credits` int(11) NOT NULL,
  `theory_hours` int(11) DEFAULT 0,
  `practice_hours` int(11) DEFAULT 0,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `subject_code`, `subject_name`, `credits`, `theory_hours`, `practice_hours`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'TH1201', 'Tin học cơ sở', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(2, 'TH1203', 'Toán rời rạc', 3, 45, 0, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(3, 'TH1219', 'Lập trình căn bản', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(4, 'TH1205', 'Cấu trúc máy tính', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(5, 'TH1206', 'Cấu trúc dữ liệu và giải thuật', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(6, 'TH1207', 'Cơ sở dữ liệu', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(7, 'TH1208', 'Hệ điều hành', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(8, 'TH1209', 'Lập trình hướng đối tượng', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(9, 'TH1227', 'Biên tập và soạn thảo văn bản', 2, 15, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(10, 'DT1283', 'Kỹ thuật số - CNTT', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(11, 'TH1212', 'Phân tích & thiết kế thuật toán', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(12, 'TH1216', 'Phần mềm mã nguồn mở', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(13, 'TH1214', 'Mạng máy tính', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(14, 'TH1217', 'An toàn và vệ sinh lao động trong lĩnh vực CNTT', 2, 30, 0, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(15, 'TH1507', 'Đồ án CNTT 1', 2, 0, 60, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(16, 'TH1521', 'Lắp ráp và cài đặt máy tính', 2, 15, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(17, 'TH1522', 'Tin học ứng dụng', 2, 15, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(18, 'TH1354', 'Anh văn chuyên ngành', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(19, 'TH1333', 'Trí tuệ nhân tạo', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(20, 'TH1359', 'Internet vạn vật', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(21, 'TH1335', 'Xử lý ảnh', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(22, 'TH1305', 'Phân tích thiết kế hệ thống thông tin', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(23, 'TH1324', 'Phân tích thiết kế hướng đối tượng', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(24, 'TH1336', 'Lập trình Web', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(25, 'TH1309', 'Lập trình Java', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(26, 'TH1397', 'Lập trình .NET', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(27, 'TH1338', 'Lập trình ứng dụng cho thiết bị di động', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(28, 'TH1376', 'Sensor và ứng dụng', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(29, 'TH1369', 'Phát triển ứng dụng IoT', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(30, 'TH1512', 'Đồ án CNTT 2', 2, 0, 60, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(31, 'TH1358', 'Bảo mật ứng dụng Web', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(32, 'TH1307', 'Hệ quản trị cơ sở dữ liệu', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(33, 'TH1339', 'Quản trị mạng máy tính', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(34, 'TH1341', 'An toàn và an ninh thông tin', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(35, 'TH1314', 'Lập trình mạng', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(36, 'TH1342', 'Công nghệ mạng không dây', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(37, 'TH1316', 'Thiết kế mạng máy tính', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(38, 'TH1370', 'Triển khai hệ thống mạng văn phòng', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(39, 'TH1526', 'Hệ thống thông tin quang', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(40, 'TH1353', 'Điện toán đám mây', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(41, 'TH1363', 'An toàn cơ sở dữ liệu', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(42, 'TH1364', 'An toàn mạng máy tính', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(43, 'TH1365', 'Tấn công mạng', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(44, 'TH1366', 'Kỹ thuật phân tích mã độc', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(45, 'TH1367', 'Quản lý rủi ro và an toàn thông tin trong doanh nghiệp', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(46, 'TH1368', 'An toàn điện toán đám mây', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(47, 'TH1355', 'Hệ thống nhúng', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(48, 'TH1356', 'Mạng trong IoT', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(49, 'TH1357', 'Phát triển ứng dụng IoT nâng cao', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(50, 'TH1377', 'Bảo mật trong IoT', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(51, 'TH1360', 'Phân tích dữ liệu lớn trong IoT', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(52, 'TH1361', 'Ứng dụng máy học trong IoT', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(53, 'TH1362', 'Ứng dụng điện toán đám mây trong IoT', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(54, 'TH1340', 'Hệ thống phân tán', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(55, 'TH1387', 'Hệ điều hành nguồn mở', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(56, 'TH1379', 'Công nghệ ảo hóa', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(57, 'TH1395', 'Điện toán đám mây', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(58, 'TH1378', 'Phát triển ứng dụng điện toán đám mây', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(59, 'TH1630', 'Thực tập tốt nghiệp', 4, 0, 120, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(60, 'TH1602', 'Khóa luận tốt nghiệp', 10, 0, 300, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(61, 'TH1606', 'Thương mại điện tử', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(62, 'TH1607', 'Cơ sở dữ liệu phân tán', 3, 30, 30, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(63, 'TH1608', 'Chuyên đề về công nghệ thông tin', 4, 30, 90, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(64, 'KT101', 'Nguyên lý kế toán', 3, 45, 0, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(65, 'KT102', 'Kế toán tài chính', 3, 45, 0, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(66, 'QT101', 'Quản trị học', 3, 45, 0, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(67, 'QT102', 'Marketing căn bản', 3, 45, 0, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(68, 'NN101', 'Ngữ pháp tiếng Anh', 3, 45, 0, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25'),
(69, 'NN102', 'Giao tiếp tiếng Anh', 3, 45, 0, NULL, 1, '2025-10-20 07:12:25', '2025-10-20 07:12:25');

-- --------------------------------------------------------

--
-- Table structure for table `subject_program`
--

CREATE TABLE `subject_program` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `program_code` varchar(20) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `is_compulsory` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject_program`
--

INSERT INTO `subject_program` (`id`, `subject_id`, `program_code`, `semester`, `is_compulsory`) VALUES
(1, 1, 'CNTT', 1, 1),
(2, 2, 'CNTT', 1, 1),
(3, 3, 'CNTT', 1, 1),
(4, 4, 'CNTT', 2, 1),
(5, 5, 'CNTT', 2, 1),
(6, 6, 'CNTT', 2, 1),
(7, 7, 'CNTT', 3, 1),
(8, 8, 'CNTT', 3, 1),
(9, 9, 'CNTT', 3, 0),
(10, 10, 'CNTT', 3, 1),
(11, 11, 'CNTT', 4, 1),
(12, 12, 'CNTT', 4, 1),
(13, 13, 'CNTT', 4, 1),
(14, 14, 'CNTT', 4, 1),
(15, 15, 'CNTT', 4, 1),
(16, 16, 'CNTT', 4, 0),
(17, 17, 'CNTT', 4, 0),
(18, 18, 'CNTT', 5, 1),
(19, 19, 'CNTT', 5, 1),
(20, 20, 'CNTT', 5, 1),
(21, 21, 'CNTT', 5, 0),
(22, 22, 'CNTT', 5, 1),
(23, 23, 'CNTT', 5, 1),
(24, 24, 'CNTT', 6, 1),
(25, 25, 'CNTT', 6, 1),
(26, 26, 'CNTT', 6, 1),
(27, 27, 'CNTT', 6, 1),
(28, 28, 'CNTT', 6, 1),
(29, 29, 'CNTT', 6, 1),
(30, 30, 'CNTT', 6, 1),
(31, 31, 'CNTT', 6, 0),
(32, 32, 'CNTT', 6, 1),
(33, 33, 'CNTT', 7, 0),
(34, 34, 'CNTT', 7, 0),
(35, 35, 'CNTT', 7, 0),
(36, 36, 'CNTT', 7, 0),
(37, 37, 'CNTT', 7, 0),
(38, 38, 'CNTT', 7, 0),
(39, 39, 'CNTT', 7, 0),
(40, 40, 'CNTT', 7, 0),
(41, 41, 'CNTT', 7, 0),
(42, 42, 'CNTT', 7, 0),
(43, 43, 'CNTT', 7, 0),
(44, 44, 'CNTT', 7, 0),
(45, 45, 'CNTT', 7, 0),
(46, 46, 'CNTT', 7, 0),
(47, 47, 'CNTT', 7, 0),
(48, 48, 'CNTT', 7, 0),
(49, 49, 'CNTT', 7, 0),
(50, 50, 'CNTT', 7, 0),
(51, 51, 'CNTT', 7, 0),
(52, 52, 'CNTT', 7, 0),
(53, 53, 'CNTT', 7, 0),
(54, 54, 'CNTT', 7, 0),
(55, 55, 'CNTT', 7, 0),
(56, 56, 'CNTT', 7, 0),
(57, 57, 'CNTT', 7, 0),
(58, 58, 'CNTT', 7, 0),
(59, 59, 'CNTT', 8, 1),
(60, 60, 'CNTT', 8, 0),
(61, 61, 'CNTT', 8, 0),
(62, 62, 'CNTT', 8, 0),
(63, 63, 'CNTT', 8, 0),
(64, 9, 'KT', 1, 1),
(65, 10, 'KT', 2, 1),
(66, 11, 'QTKD', 1, 1),
(67, 12, 'QTKD', 2, 1),
(68, 13, 'NN', 1, 1),
(69, 14, 'NN', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `subject_topics`
--

CREATE TABLE `subject_topics` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `topic_title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `type` tinyint(1) DEFAULT 0 COMMENT '0=Lý thuyết, 1=Thực hành'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject_topics`
--

INSERT INTO `subject_topics` (`id`, `subject_id`, `topic_title`, `content`, `created_at`, `updated_at`, `type`) VALUES
(1, 1, 'Tổng quan về máy tính và CNTT', 'Lịch sử phát triển máy tính, các thế hệ máy tính, vai trò của CNTT trong xã hội hiện đại', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(2, 1, 'Cấu trúc cơ bản của máy tính', 'CPU, bộ nhớ, thiết bị lưu trữ, thiết bị vào-ra, bus hệ thống', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(3, 1, 'Hệ điều hành Windows', 'Giao diện Windows, quản lý file và thư mục, Control Panel, Task Manager', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(4, 1, 'Hệ điều hành Linux cơ bản', 'Giới thiệu Linux, terminal, hệ thống file, lệnh cơ bản', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(5, 1, 'Microsoft Word - Soạn thảo cơ bản', 'Giao diện Word, nhập văn bản, định dạng font, paragraph, styles', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(6, 1, 'Microsoft Word - Tính năng nâng cao', 'Table, hình ảnh, SmartArt, mục lục tự động, header/footer', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(7, 1, 'Microsoft Excel - Nhập liệu và định dạng', 'Giao diện Excel, nhập dữ liệu, định dạng ô, worksheet', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(8, 1, 'Microsoft Excel - Công thức và hàm', 'Công thức cơ bản, hàm SUM, AVERAGE, IF, VLOOKUP, SUMIF', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(9, 1, 'Microsoft Excel - Phân tích dữ liệu', 'Sort, Filter, PivotTable, biểu đồ, Conditional Formatting', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(10, 1, 'Microsoft PowerPoint cơ bản', 'Tạo presentation, thiết kế slide, themes, template', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(11, 1, 'Microsoft PowerPoint nâng cao', 'Animation, transition, multimedia, slide master', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(12, 1, 'Internet và email', 'Trình duyệt web, tìm kiếm thông tin, email client, bảo mật cơ bản', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(13, 2, 'Logic mệnh đề', 'Mệnh đề, phép toán logic, bảng chân trị, các quy luật logic', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(14, 2, 'Logic vị từ', 'Vị từ, lượng từ, suy diễn trong logic vị từ', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(15, 2, 'Tập hợp và các phép toán', 'Tập hợp, tập con, các phép toán tập hợp, tập hợp bằng nhau', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(16, 2, 'Quan hệ và tính chất', 'Quan hệ hai ngôi, tính chất phản xạ, đối xứng, bắc cầu', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(17, 2, 'Quan hệ tương đương và thứ tự', 'Quan hệ tương đương, lớp tương đương, quan hệ thứ tự', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(18, 2, 'Hàm và ánh xạ', 'Định nghĩa hàm, hàm đơn ánh, toàn ánh, song ánh', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(19, 2, 'Đại số Bool và cổng logic', 'Đại số Bool, cổng logic, mạch logic, rút gọn biểu thức', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(20, 2, 'Lý thuyết đồ thị cơ bản', 'Định nghĩa đồ thị, đường đi, chu trình, đồ thị liên thông', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(21, 2, 'Đồ thị Euler và Hamilton', 'Đường đi Euler, chu trình Hamilton, điều kiện tồn tại', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(22, 2, 'Cây và ứng dụng', 'Cây, cây khung, cây nhị phân, duyệt cây', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(23, 3, 'Giới thiệu ngôn ngữ C và môi trường lập trình', 'Lịch sử ngôn ngữ C, IDE, compiler, linker, quy trình biên dịch', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(24, 3, 'Cấu trúc chương trình C cơ bản', 'Hello World, hàm main, cấu trúc chương trình, comments', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(25, 3, 'Kiểu dữ liệu và biến', 'Kiểu dữ liệu cơ bản, khai báo biến, hằng số, phạm vi biến', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(26, 3, 'Toán tử và biểu thức', 'Toán tử số học, quan hệ, logic, bitwise, ép kiểu', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(27, 3, 'Nhập xuất dữ liệu', 'printf, scanf, format specifiers, buffer input', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(28, 3, 'Cấu trúc điều khiển if-else', 'Câu lệnh if, if-else, if-else if, switch-case', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(29, 3, 'Vòng lặp for, while, do-while', 'Cú pháp vòng lặp, break, continue, vòng lặp lồng nhau', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(30, 3, 'Mảng một chiều', 'Khai báo mảng, truy cập phần tử, nhập xuất mảng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(31, 3, 'Mảng hai chiều', 'Ma trận, khai báo, truy cập, các thao tác cơ bản', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(32, 3, 'Chuỗi ký tự', 'Khai báo chuỗi, hàm xử lý chuỗi, mảng ký tự', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(33, 3, 'Hàm và tham số', 'Khai báo hàm, tham số, giá trị trả về, prototype', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(34, 3, 'Đệ quy', 'Khái niệm đệ quy, hàm đệ quy, bài toán kinh điển', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(35, 3, 'Con trỏ cơ bản', 'Khái niệm con trỏ, khai báo, toán tử con trỏ', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(36, 3, 'Con trỏ và mảng', 'Con trỏ trỏ đến mảng, con trỏ và chuỗi ký tự', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(37, 3, 'Cấp phát bộ nhớ động', 'malloc, calloc, realloc, free, quản lý bộ nhớ', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(38, 4, 'Tổng quan về kiến trúc máy tính', 'Lịch sử phát triển, phân loại kiến trúc, các thành phần cơ bản', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(39, 4, 'Hệ thống số và mã hóa', 'Hệ nhị phân, thập lục phân, số học máy tính, mã bù 2', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(40, 4, 'Biểu diễn dữ liệu trong máy tính', 'Số nguyên, số thực, ký tự, các phép toán số học', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(41, 4, 'Kiến trúc tập lệnh', 'Các loại lệnh, định dạng lệnh, addressing modes', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(42, 4, 'Bộ xử lý trung tâm (CPU)', 'Cấu trúc CPU, ALU, control unit, register file', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(43, 4, 'Pipeline và xử lý song song', 'Pipeline cơ bản, hazards, kỹ thuật xử lý song song', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(44, 4, 'Tổ chức bộ nhớ', 'Phân cấp bộ nhớ, cache memory, virtual memory', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(45, 4, 'Hệ thống vào-ra (I/O)', 'Các phương pháp I/O, interrupt, DMA, bus hệ thống', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(46, 4, 'Lập trình Assembly cơ bản', 'Cú pháp Assembly, các lệnh cơ bản, hệ thống lệnh', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(47, 4, 'Lập trình Assembly nâng cao', 'Lệnh nhảy, thủ tục, ngắt, lập trình hệ thống', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(48, 4, 'Kiến trúc RISC và CISC', 'So sánh RISC vs CISC, các bộ xử lý tiêu biểu', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(49, 4, 'Xu hướng phát triển kiến trúc máy tính', 'Multi-core, GPU computing, quantum computing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(50, 5, 'Độ phức tạp thuật toán', 'Ký hiệu O lớn, phân tích thời gian thực hiện, best/worst case', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(51, 5, 'Mảng và danh sách', 'Mảng động, danh sách đặc điểm, ứng dụng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(52, 5, 'Con trỏ và quản lý bộ nhớ', 'Con trỏ trong C++, cấp phát động, smart pointers', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(53, 5, 'Danh sách liên kết đơn', 'Cấu trúc node, thao tác thêm/xóa/tìm kiếm', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(54, 5, 'Danh sách liên kết đôi', 'Cấu trúc node đôi, ưu điểm so với danh sách đơn', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(55, 5, 'Stack và ứng dụng', 'Cài đặt stack, ứng dụng trong biểu thức, backtracking', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(56, 5, 'Queue và ứng dụng', 'Queue, circular queue, priority queue, ứng dụng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(57, 5, 'Cây nhị phân', 'Cấu trúc cây, các loại cây nhị phân, tính chất', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(58, 5, 'Cây nhị phân tìm kiếm', 'Tìm kiếm, chèn, xóa node, duyệt cây', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(59, 5, 'Cây cân bằng (AVL)', 'Cân bằng cây, các phép xoay, độ phức tạp', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(60, 5, 'Đống (Heap)', 'Max-heap, min-heap, heap sort, priority queue', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(61, 5, 'Bảng băm (Hash Table)', 'Hash function, collision resolution, applications', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(62, 5, 'Đồ thị và biểu diễn đồ thị', 'Ma trận kề, danh sách kề, các thuật ngữ đồ thị', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(63, 5, 'Duyệt đồ thị', 'BFS, DFS, ứng dụng trong tìm đường', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(64, 5, 'Cây khung và đường đi ngắn nhất', 'Prim, Kruskal, Dijkstra, ứng dụng thực tế', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(65, 6, 'Tổng quan về CSDL và HQTCSDL', 'Khái niệm CSDL, các mô hình CSDL, tính chất ACID', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(66, 6, 'Mô hình thực thể-quan hệ (ERD)', 'Thực thể, thuộc tính, quan hệ, cardinality, bản số', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(67, 6, 'Mô hình quan hệ', 'Quan hệ, thuộc tính, khóa, ràng buộc toàn vẹn', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(68, 6, 'Đại số quan hệ', 'Các phép toán đại số quan hệ, biểu thức đại số', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(69, 6, 'SQL cơ bản - DDL', 'CREATE, ALTER, DROP TABLE, các kiểu dữ liệu', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(70, 6, 'SQL cơ bản - DML', 'SELECT, INSERT, UPDATE, DELETE, WHERE clause', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(71, 6, 'Truy vấn nâng cao', 'JOIN, SUBQUERY, GROUP BY, HAVING, UNION', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(72, 6, 'Khóa và ràng buộc', 'Primary key, Foreign key, Unique, Check constraint', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(73, 6, 'Chuẩn hóa CSDL - 1NF, 2NF', 'Dạng chuẩn 1, dạng chuẩn 2, các vấn đề khi không chuẩn hóa', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(74, 6, 'Chuẩn hóa CSDL - 3NF, BCNF', 'Dạng chuẩn 3, BCNF, phân rã bảo toàn thông tin', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(75, 6, 'Giao dịch và điều khiển tương tranh', 'Transaction, lock, deadlock, isolation levels', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(76, 6, 'Bảo mật và quyền truy cập', 'User management, privileges, roles, views', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(77, 7, 'Tổng quan về hệ điều hành', 'Chức năng, phân loại, lịch sử phát triển, các thành phần', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(78, 7, 'Cấu trúc hệ điều hành', 'Kernel, system calls, monolithic vs microkernel', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(79, 7, 'Quản lý tiến trình', 'Process, PCB, trạng thái tiến trình, context switch', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(80, 7, 'Điều phối CPU', 'Các thuật toán điều phối FCFS, SJF, Round Robin, Priority', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(81, 7, 'Đồng bộ hóa tiến trình', 'Critical section, semaphore, mutex, monitor', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(82, 7, 'Deadlock', 'Điều kiện xảy ra deadlock, prevention, avoidance, detection', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(83, 7, 'Quản lý bộ nhớ', 'Phân trang, phân đoạn, bảng trang, TLB', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(84, 7, 'Bộ nhớ ảo', 'Demand paging, page replacement algorithms, thrashing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(85, 7, 'Hệ thống file', 'Tổ chức file, directory structure, file allocation methods', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(86, 7, 'Bảo mật và bảo vệ', 'Authentication, authorization, access control lists', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(87, 8, 'Giới thiệu OOP và C++', 'Các nguyên lý OOP, so sánh với procedural programming', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(88, 8, 'Lớp và đối tượng', 'Khai báo lớp, tạo đối tượng, access modifiers', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(89, 8, 'Constructor và Destructor', 'Default constructor, parameterized constructor, copy constructor', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(90, 8, 'Tính đóng gói', 'Private members, public interface, getter/setter methods', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(91, 8, 'Tính kế thừa', 'Single inheritance, access specifiers, method overriding', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(92, 8, 'Đa kế thừa và virtual inheritance', 'Multiple inheritance, diamond problem, virtual base class', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(93, 8, 'Tính đa hình', 'Function overloading, operator overloading, virtual functions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(94, 8, 'Abstract class và Interface', 'Pure virtual functions, abstract base class, interface design', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(95, 8, 'Template và Generic Programming', 'Function template, class template, STL introduction', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(96, 8, 'Xử lý ngoại lệ', 'Try-catch block, exception hierarchy, custom exceptions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(97, 8, 'Smart Pointers', 'Unique_ptr, shared_ptr, weak_ptr, memory management', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(98, 8, 'STL Containers', 'Vector, list, map, set, algorithms', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(99, 8, 'Design Patterns cơ bản', 'Singleton, Factory, Observer pattern', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(100, 8, 'UML và thiết kế hướng đối tượng', 'Class diagram, sequence diagram, use case diagram', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(101, 8, 'Refactoring và code quality', 'Code smells, refactoring techniques, unit testing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(102, 9, 'Nguyên tắc soạn thảo văn bản', 'Quy tắc trình bày văn bản, font chữ, căn lề, khoảng cách', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(103, 9, 'Văn bản hành chính thông dụng', 'Công văn, quyết định, báo cáo, tờ trình, biên bản', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(104, 9, 'Định dạng văn bản chuyên nghiệp', 'Styles, templates, themes, document formatting', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(105, 9, 'Làm việc với bảng biểu', 'Tạo bảng, định dạng bảng, formulas trong bảng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(106, 9, 'Chèn đối tượng và hình ảnh', 'Hình ảnh, SmartArt, Chart, Equation, Symbol', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(107, 9, 'Mục lục và trích dẫn', 'Table of contents, footnotes, endnotes, bibliography', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(108, 9, 'Trộn thư và tự động hóa', 'Mail merge, fields, automation với Macro', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(109, 9, 'Bảo vệ và chia sẻ tài liệu', 'Password protection, track changes, comments, version control', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(110, 10, 'Hệ thống số và chuyển đổi', 'Binary, octal, hexadecimal, chuyển đổi giữa các hệ', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(111, 10, 'Số học máy tính', 'Số có dấu, số bù 1, bù 2, các phép toán số học', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(112, 10, 'Mã hóa dữ liệu', 'BCD, Gray code, ASCII, Unicode, parity check', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(113, 10, 'Đại số Boolean', 'Các định lý, luật De Morgan, rút gọn biểu thức', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(114, 10, 'Cổng logic cơ bản', 'AND, OR, NOT, NAND, NOR, XOR, XNOR, truth tables', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(115, 10, 'Mạch tổ hợp', 'Bộ giải mã, mã hóa, cộng, so sánh, ALU cơ bản', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(116, 10, 'Flip-flop và thanh ghi', 'SR flip-flop, D flip-flop, JK flip-flop, register', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(117, 10, 'Mạch tuần tự', 'Bộ đếm, thanh ghi dịch, finite state machines', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(118, 10, 'Bộ nhớ bán dẫn', 'ROM, RAM, SRAM, DRAM, memory organization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(119, 10, 'Giới thiệu VHDL/Verilog', 'Cú pháp cơ bản, mô tả mạch tổ hợp và tuần tự', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(120, 11, 'Phân tích độ phức tạp thuật toán', 'Big O, Omega, Theta notation, phân tích trường hợp xấu nhất', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(121, 11, 'Phương pháp chia để trị', 'Nguyên lý, Merge Sort, Quick Sort, Strassen algorithm', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(122, 11, 'Sắp xếp và tìm kiếm nâng cao', 'Heap Sort, Counting Sort, Radix Sort, interpolation search', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(123, 11, 'Cấu trúc dữ liệu nâng cao', 'Balanced trees, skip lists, bloom filters', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(124, 11, 'Thuật toán tham lam', 'Nguyên lý greedy, Huffman coding, activity selection', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(125, 11, 'Quy hoạch động', 'Nguyên lý optimal substructure, Fibonacci, knapsack problem', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(126, 11, 'Quy hoạch động nâng cao', 'Longest common subsequence, matrix chain multiplication', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(127, 11, 'Backtracking', 'N-Queens problem, graph coloring, Hamiltonian cycle', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(128, 11, 'Thuật toán đồ thị', 'Minimum spanning tree, shortest path, network flow', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(129, 11, 'Thuật toán xử lý chuỗi', 'String matching, KMP algorithm, Rabin-Karp', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(130, 11, 'NP-Complete và tính khó', 'P vs NP, reduction, NP-complete problems', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(131, 11, 'Thuật toán xấp xỉ', 'Approximation algorithms, performance guarantee', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(132, 12, 'Tổng quan về phần mềm mã nguồn mở', 'Lịch sử, triết lý, so sánh với phần mềm thương mại', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(133, 12, 'Các giấy phép mã nguồn mở', 'GPL, LGPL, MIT, Apache, BSD, so sánh và lựa chọn', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(134, 12, 'Hệ điều hành Linux', 'Distributions, kernel, shell, file system hierarchy', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(135, 12, 'Dòng lệnh Linux cơ bản', 'File operations, process management, text processing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(136, 12, 'Shell scripting', 'Bash scripting, variables, control structures, functions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(137, 12, 'Quản trị hệ thống Linux', 'User management, permissions, package management', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(138, 12, 'Môi trường desktop Linux', 'GNOME, KDE, XFCE, ứng dụng văn phòng mã nguồn mở', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(139, 12, 'Phần mềm máy chủ mã nguồn mở', 'Apache, Nginx, MySQL, PostgreSQL', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(140, 12, 'Ngôn ngữ lập trình mã nguồn mở', 'Python, PHP, Ruby, so sánh và ứng dụng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(141, 12, 'Phát triển phần mềm mã nguồn mở', 'Git, GitHub, đóng góp cho dự án mã nguồn mở', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(142, 13, 'Tổng quan về mạng máy tính', 'Lịch sử phát triển, phân loại mạng, topologies, ứng dụng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(143, 13, 'Mô hình OSI và TCP/IP', '7 layers OSI, 4 layers TCP/IP, so sánh và ứng dụng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(144, 13, 'Tầng vật lý', 'Tín hiệu, mã hóa, truyền dẫn, phương tiện truyền dẫn', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(145, 13, 'Tầng liên kết dữ liệu', 'Framing, error detection, flow control, HDLC, PPP', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(146, 13, 'Mạng LAN và Ethernet', 'CSMA/CD, Ethernet frame, switches, VLAN', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(147, 13, 'Tầng mạng - IP', 'Địa chỉ IPv4, subnetting, CIDR, packet forwarding', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(148, 13, 'Tầng mạng - Routing', 'Routing algorithms, RIP, OSPF, BGP', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(149, 13, 'Tầng giao vận - TCP', 'TCP connection, flow control, congestion control', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(150, 13, 'Tầng giao vận - UDP', 'UDP datagram, applications, so sánh với TCP', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(151, 13, 'Tầng ứng dụng', 'HTTP, DNS, SMTP, FTP, ứng dụng mạng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(152, 13, 'Network Address Translation', 'NAT, PAT, ứng dụng trong mạng doanh nghiệp', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(153, 13, 'IPv6', 'Địa chỉ IPv6, header format, migration từ IPv4', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(154, 13, 'Wireless Networking', 'Wi-Fi standards, security, access points', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(155, 13, 'Network Security Fundamentals', 'Firewalls, VPN, basic security concepts', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(156, 13, 'Network Troubleshooting', 'Tools, methodologies, common network problems', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(157, 14, 'Tổng quan về an toàn lao động', 'Khái niệm, tầm quan trọng, các văn bản pháp luật liên quan', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(158, 14, 'Các yếu tố nguy hiểm trong môi trường CNTT', 'Điện, nhiệt, bức xạ, tư thế làm việc, căng thẳng mắt', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(159, 14, 'An toàn điện trong phòng máy', 'Tiếp đất, chống sét, UPS, thiết bị bảo vệ', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(160, 14, 'Vệ sinh lao động và ergonomics', 'Bàn ghế ergonomic, ánh sáng, tiếng ồn, nhiệt độ', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(161, 14, 'Phòng cháy chữa cháy', 'Nguyên nhân cháy, thiết bị PCCC, thoát hiểm', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(162, 14, 'Sức khỏe nghề nghiệp trong CNTT', 'Hội chứng ống cổ tay, mỏi mắt, stress, giải pháp', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(163, 14, 'An toàn trong lắp đặt và bảo trì', 'Quy trình an toàn, thiết bị bảo hộ, xử lý sự cố', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(164, 14, 'Hệ thống quản lý an toàn lao động', 'Đánh giá rủi ro, biện pháp phòng ngừa, đào tạo', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(165, 15, 'Giới thiệu về đồ án CNTT', 'Mục tiêu, yêu cầu, quy trình thực hiện đồ án', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(166, 15, 'Lựa chọn đề tài và xác định phạm vi', 'Tiêu chí lựa chọn đề tài, xác định yêu cầu, phạm vi dự án', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(167, 15, 'Phân tích yêu cầu hệ thống', 'Thu thập yêu cầu, phân tích functional và non-functional requirements', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(168, 15, 'Thiết kế hệ thống', 'Kiến trúc hệ thống, thiết kế database, thiết kế giao diện', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(169, 15, 'Lập kế hoạch dự án', 'Work breakdown structure, timeline, resource allocation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(170, 15, 'Công nghệ và công cụ phát triển', 'Lựa chọn công nghệ, IDE, version control, project management tools', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(171, 15, 'Phát triển prototype', 'Xây dựng prototype, iterative development, user feedback', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(172, 15, 'Kiểm thử và đánh giá', 'Test cases, unit testing, integration testing, user acceptance testing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(173, 15, 'Viết tài liệu kỹ thuật', 'Technical documentation, user manual, installation guide', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(174, 15, 'Báo cáo và bảo vệ đồ án', 'Presentation skills, demo sản phẩm, Q&A session', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(175, 16, 'Tổng quan về phần cứng máy tính', 'Các thành phần cơ bản, chức năng, tương thích', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(176, 16, 'Mainboard và CPU', 'Các loại socket, chipset, bus speed, compatibility', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(177, 16, 'Bộ nhớ RAM', 'Types of RAM, speeds, capacities, dual/triple channel', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(178, 16, 'Ổ cứng và thiết bị lưu trữ', 'HDD vs SSD, NVMe, RAID configurations', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(179, 16, 'Card màn hình và xử lý đồ họa', 'GPU, VRAM, gaming vs professional graphics cards', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(180, 16, 'Nguồn và hệ thống làm mát', 'Power supply ratings, cooling solutions, thermal paste', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(181, 16, 'Quy trình lắp ráp máy tính', 'Step-by-step assembly, safety precautions, cable management', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(182, 16, 'Cài đặt hệ điều hành Windows', 'Boot sequence, partitioning, driver installation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(183, 16, 'Cài đặt hệ điều hành Linux', 'Dual boot, partitioning schemes, package management', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(184, 16, 'Cấu hình BIOS/UEFI', 'Boot order, virtualization, security settings', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(185, 16, 'Cài đặt và cấu hình driver', 'Device drivers, firmware updates, compatibility issues', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(186, 16, 'Bảo trì và xử lý sự cố', 'Preventive maintenance, troubleshooting common problems', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(187, 17, 'Microsoft Office nâng cao', 'Advanced features in Word, Excel, PowerPoint integration', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(188, 17, 'Google Workspace', 'Google Docs, Sheets, Slides, Drive, collaboration features', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(189, 17, 'Xử lý dữ liệu với Excel nâng cao', 'Power Query, Power Pivot, advanced formulas, data analysis', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(190, 17, 'Automation với Macro', 'Excel VBA, Word VBA, automation scenarios', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(191, 17, 'Công cụ quản lý dự án', 'Microsoft Project, Trello, Asana, Gantt charts', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(192, 17, 'Công cụ thiết kế cơ bản', 'Canva, Figma, basic graphic design principles', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(193, 17, 'Công cụ giao tiếp và cộng tác', 'Slack, Microsoft Teams, Zoom, virtual meetings', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(194, 17, 'Quản lý thông tin cá nhân', 'Note-taking apps, password managers, cloud storage', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(195, 17, 'Bảo mật thông tin cá nhân', 'Antivirus, firewall, phishing protection, data backup', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(196, 17, 'Productivity và time management', 'Pomodoro technique, task management, digital tools', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(197, 18, 'Technical vocabulary building', 'Common IT terms, abbreviations, technical terminology', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(198, 18, 'Reading technical documentation', 'API documentation, technical manuals, specifications', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(199, 18, 'Writing technical emails', 'Professional email structure, technical communication', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(200, 18, 'Technical presentations', 'Structuring technical presentations, delivery techniques', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(201, 18, 'Software documentation writing', 'User manuals, technical guides, API documentation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(202, 18, 'IT project proposals', 'Writing project proposals, technical specifications', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(203, 18, 'IT support communication', 'Troubleshooting guides, customer support scenarios', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(204, 18, 'Academic writing in IT', 'Research papers, technical reports, citations', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(205, 18, 'IT job interviews', 'Interview preparation, technical questions, CV writing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(206, 18, 'Cross-cultural communication', 'Working in global teams, cultural differences', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(207, 18, 'IT ethics and professional conduct', 'Code of ethics, professional standards', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(208, 18, 'Emerging technologies vocabulary', 'AI, cloud computing, blockchain terminology', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(209, 19, 'Tổng quan về trí tuệ nhân tạo', 'Lịch sử AI, các lĩnh vực con, ứng dụng thực tế', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(210, 19, 'Tác tử thông minh', 'Intelligent agents, PEAS description, environment types', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(211, 19, 'Giải quyết vấn đề bằng tìm kiếm', 'Problem formulation, search strategies, state space', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(212, 19, 'Tìm kiếm không thông tin', 'BFS, DFS, UCS, depth-limited search, iterative deepening', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(213, 19, 'Tìm kiếm thông tin', 'Greedy search, A* algorithm, heuristic functions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(214, 19, 'Tìm kiếm đối kháng', 'Minimax algorithm, alpha-beta pruning, game playing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(215, 19, 'Logic mệnh đề', 'Knowledge representation, inference, resolution', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(216, 19, 'Logic vị từ bậc nhất', 'First-order logic, unification, forward/backward chaining', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(217, 19, 'Lập kế hoạch', 'Planning domains, STRIPS, partial-order planning', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(218, 19, 'Học máy cơ bản', 'Supervised vs unsupervised learning, training/testing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(219, 19, 'Cây quyết định và Random Forest', 'Decision trees, ensemble methods, feature importance', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(220, 19, 'Mạng neural nhân tạo', 'Perceptron, multilayer networks, backpropagation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(221, 19, 'Xử lý ngôn ngữ tự nhiên', 'Tokenization, POS tagging, sentiment analysis', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(222, 19, 'Computer vision cơ bản', 'Image processing, object detection, CNN introduction', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(223, 19, 'Ứng dụng AI trong thực tế', 'Recommendation systems, chatbots, autonomous systems', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(224, 20, 'Tổng quan về IoT', 'Khái niệm, lịch sử, kiến trúc hệ thống IoT, ứng dụng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(225, 20, 'Cảm biến và thiết bị IoT', 'Types of sensors, actuators, embedded devices, specifications', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(226, 20, 'Vi điều khiển cho IoT', 'Arduino, ESP32, Raspberry Pi, programming microcontrollers', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(227, 20, 'Giao thức truyền thông IoT', 'MQTT, CoAP, HTTP REST, Bluetooth Low Energy, Zigbee', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(228, 20, 'Mạng không dây cho IoT', 'Wi-Fi, LoRaWAN, NB-IoT, Sigfox, network selection criteria', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(229, 20, 'Thu thập và xử lý dữ liệu IoT', 'Data acquisition, preprocessing, edge computing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(230, 20, 'Cloud platforms for IoT', 'AWS IoT, Azure IoT, Google Cloud IoT, platform comparison', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(231, 20, 'IoT data analytics', 'Time series analysis, real-time processing, visualization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(232, 20, 'Bảo mật trong IoT', 'Security challenges, encryption, authentication, secure boot', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(233, 20, 'IoT protocols and standards', 'IEEE 802.15.4, 6LoWPAN, Thread, industry standards', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(234, 20, 'Smart home applications', 'Home automation, energy management, security systems', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(235, 20, 'Industrial IoT (IIoT)', 'Smart manufacturing, predictive maintenance, industrial applications', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(236, 21, 'Tổng quan về xử lý ảnh', 'Ứng dụng, các lĩnh vực con, quy trình xử lý ảnh', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(237, 21, 'Cơ sở toán học', 'Vector, matrix operations, convolution, Fourier transform', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(238, 21, 'Biểu diễn ảnh số', 'Digital image representation, color models, image formats', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(239, 21, 'Cải thiện chất lượng ảnh', 'Histogram equalization, contrast enhancement, filtering', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(240, 21, 'Lọc ảnh trong miền không gian', 'Smoothing filters, sharpening filters, median filter', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(241, 21, 'Lọc ảnh trong miền tần số', 'Fourier transform, frequency domain filtering', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(242, 21, 'Phân tích màu sắc', 'Color spaces, color-based segmentation, color constancy', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(243, 21, 'Phân vùng ảnh', 'Thresholding, region growing, edge-based segmentation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(244, 21, 'Phát hiện biên ảnh', 'Sobel, Prewitt, Canny edge detection, edge linking', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(245, 21, 'Morphological operations', 'Dilation, erosion, opening, closing, applications', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(246, 21, 'Biến đổi hình học ảnh', 'Scaling, rotation, affine transformation, warping', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(247, 21, 'Nhận dạng mẫu cơ bản', 'Template matching, feature extraction, classification', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(248, 21, 'Texture analysis', 'Texture features, Gabor filters, texture classification', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(249, 21, 'Image compression', 'Lossless vs lossy compression, JPEG, PNG, MPEG', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(250, 21, 'Ứng dụng thực tế', 'Medical imaging, facial recognition, autonomous vehicles', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(251, 22, 'Tổng quan về hệ thống thông tin', 'Khái niệm, phân loại, vai trò trong tổ chức', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(252, 22, 'Các mô hình phát triển hệ thống', 'Waterfall, iterative, agile, RAD, prototyping', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(253, 22, 'Thu thập yêu cầu', 'Interviewing, questionnaires, observation, JAD sessions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(254, 22, 'Mô hình hóa nghiệp vụ', 'Business process modeling, BPMN, workflow diagrams', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(255, 22, 'Mô hình hóa dữ liệu', 'Entity-Relationship diagrams, data dictionary, normalization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(256, 22, 'Mô hình hóa xử lý', 'Data flow diagrams, process specifications, decision tables', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(257, 22, 'Thiết kế kiến trúc hệ thống', 'Client-server, n-tier, microservices architecture', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(258, 22, 'Thiết kế giao diện người dùng', 'HCI principles, UI design patterns, usability testing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(259, 22, 'Thiết kế cơ sở dữ liệu', 'Logical design, physical design, indexing, optimization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(260, 22, 'Quản lý dự án hệ thống thông tin', 'Project planning, risk management, quality assurance', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(261, 22, 'Triển khai và bảo trì hệ thống', 'Implementation strategies, change management, maintenance', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(262, 22, 'Đánh giá và cải tiến hệ thống', 'System evaluation, performance monitoring, continuous improvement', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(263, 23, 'Giới thiệu phân tích thiết kế hướng đối tượng', 'Khái niệm, lợi ích, quy trình phát triển OO', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(264, 23, 'Ngôn ngữ mô hình hóa thống nhất UML', 'Giới thiệu UML, các loại diagram, ứng dụng', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(265, 23, 'Use Case Diagram', 'Actors, use cases, relationships, scenario specification', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(266, 23, 'Class Diagram', 'Classes, attributes, operations, relationships, multiplicity', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(267, 23, 'Sequence Diagram', 'Objects, messages, activation bars, interaction fragments', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(268, 23, 'Activity Diagram', 'Activities, decisions, forks, joins, swimlanes', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(269, 23, 'State Machine Diagram', 'States, transitions, events, actions, composite states', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(270, 23, 'Component và Deployment Diagram', 'Components, interfaces, nodes, deployment architecture', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(271, 23, 'Phân tích yêu cầu hướng đối tượng', 'Identifying objects, use case analysis, domain modeling', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(272, 23, 'Thiết kế kiến trúc hướng đối tượng', 'Architectural patterns, layer design, package organization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(273, 23, 'Thiết kế lớp và đối tượng', 'Class responsibilities, collaboration design, interface design', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(274, 23, 'Design Patterns cơ bản', 'Creational, structural, behavioral patterns', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(275, 23, 'Design Patterns nâng cao', 'Enterprise patterns, concurrency patterns', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(276, 23, 'Mô hình hóa cơ sở dữ liệu hướng đối tượng', 'Object-relational mapping, OODBMS', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(277, 23, 'Kiểm thử hướng đối tượng', 'Unit testing, integration testing, test-driven development', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(278, 24, 'Tổng quan về lập trình web', 'Client-server architecture, HTTP protocol, web development stack', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(279, 24, 'HTML5 cơ bản', 'Document structure, semantic elements, forms, multimedia', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(280, 24, 'HTML5 nâng cao', 'Canvas, SVG, web storage, geolocation, web workers', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(281, 24, 'CSS3 cơ bản', 'Selectors, box model, positioning, typography, colors', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(282, 24, 'CSS3 nâng cao', 'Flexbox, Grid, animations, transitions, responsive design', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(283, 24, 'JavaScript cơ bản', 'Variables, data types, operators, control structures, functions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(284, 24, 'JavaScript nâng cao', 'Objects, arrays, DOM manipulation, event handling', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(285, 24, 'ES6+ Features', 'Arrow functions, classes, modules, promises, async/await', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(286, 24, 'jQuery và AJAX', 'DOM manipulation with jQuery, asynchronous requests', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(287, 24, 'Frontend frameworks giới thiệu', 'React, Angular, Vue.js comparison and basic concepts', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(288, 24, 'PHP cơ bản', 'Syntax, variables, control structures, functions, forms', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(289, 24, 'PHP nâng cao', 'Object-oriented PHP, MySQL integration, sessions, cookies', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(290, 24, 'Node.js và Express', 'Server-side JavaScript, RESTful APIs, middleware', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(291, 24, 'Database integration', 'MySQL, MongoDB, ORM, database design for web apps', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(292, 24, 'Deployment và bảo mật', 'Web hosting, SSL, security best practices, performance optimization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(293, 25, 'Giới thiệu ngôn ngữ Java', 'Lịch sử Java, JVM, JDK, JRE, đặc điểm của Java', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(294, 25, 'Cấu trúc chương trình Java', 'Class structure, main method, packages, comments', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(295, 25, 'Biến và kiểu dữ liệu', 'Primitive types, reference types, type conversion, arrays', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(296, 25, 'Toán tử và biểu thức', 'Arithmetic, relational, logical, bitwise operators', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(297, 25, 'Cấu trúc điều khiển', 'If-else, switch, for, while, do-while loops', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(298, 25, 'Lập trình hướng đối tượng trong Java', 'Classes, objects, constructors, method overloading', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(299, 25, 'Tính kế thừa và đa hình', 'Inheritance, method overriding, abstract classes, interfaces', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(300, 25, 'Gói và phạm vi truy cập', 'Packages, import statements, access modifiers', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(301, 25, 'Xử lý ngoại lệ', 'Try-catch-finally, custom exceptions, exception hierarchy', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(302, 25, 'Collection Framework', 'List, Set, Map, ArrayList, HashMap, iteration', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(303, 25, 'Generics', 'Generic classes, methods, wildcards, type erasure', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(304, 25, 'Lambda expressions và Stream API', 'Functional interfaces, lambda syntax, stream operations', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(305, 25, 'Input/Output', 'File I/O, serialization, NIO package', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(306, 25, 'Multithreading', 'Thread class, Runnable interface, synchronization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(307, 25, 'Java Database Connectivity (JDBC)', 'Database connection, CRUD operations, connection pooling', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(308, 26, 'Giới thiệu .NET Framework', 'CLR, CTS, CLS, .NET architecture, versions comparison', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(309, 26, 'C# cơ bản', 'Syntax, variables, data types, operators, control structures', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(310, 26, 'Lập trình hướng đối tượng với C#', 'Classes, objects, inheritance, polymorphism, interfaces', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(311, 26, 'Advanced C# Features', 'Delegates, events, attributes, reflection, LINQ', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(312, 27, 'ASP.NET Web Forms', 'Page lifecycle, server controls, view state, master pages', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(313, 27, 'ASP.NET MVC', 'Model-View-Controller pattern, routing, controllers, views', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(314, 27, 'Entity Framework', 'ORM concepts, code first, database first, LINQ to Entities', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(315, 27, 'Web API Development', 'RESTful services, HTTP methods, JSON serialization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(316, 27, 'Windows Forms Applications', 'Form design, controls, event handling, data binding', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(317, 27, 'WPF Applications', 'XAML, data binding, styles, templates, MVVM pattern', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(318, 27, 'Dependency Injection', 'IoC containers, service lifetime, configuration', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(319, 27, 'Testing trong .NET', 'Unit testing, mocking, test-driven development', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(320, 27, 'Security in .NET Applications', 'Authentication, authorization, cryptography', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(321, 27, 'Performance Optimization', 'Caching, profiling, async programming', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(322, 27, 'Deployment và DevOps', 'Publishing, CI/CD, Azure deployment', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(323, 27, 'Tổng quan về lập trình di động', 'Native vs hybrid apps, platform comparison, market trends', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(324, 27, 'Android development environment', 'Android Studio, SDK, emulator, device setup', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(325, 27, 'Android application components', 'Activities, services, broadcast receivers, content providers', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(326, 27, 'Android user interface', 'Layouts, views, resources, responsive design', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(327, 27, 'Activity lifecycle và state management', 'Lifecycle callbacks, savedInstanceState, configuration changes', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(328, 27, 'Intents và navigation', 'Explicit vs implicit intents, intent filters, navigation patterns', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(329, 27, 'Data storage trong Android', 'SharedPreferences, files, SQLite, Room database', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(330, 27, 'Networking và web services', 'HTTP requests, REST APIs, JSON parsing, Retrofit', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(331, 27, 'Background processing', 'Services, WorkManager, JobScheduler, threads', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(332, 27, 'Notifications', 'Local notifications, push notifications, notification channels', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(333, 27, 'Location và maps', 'GPS, network location, Google Maps API', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(334, 27, 'Camera và media', 'Camera API, image capture, video recording, media playback', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(335, 27, 'Material Design', 'Design principles, components, theming', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(336, 27, 'Testing mobile applications', 'Unit tests, instrumentation tests, UI testing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(337, 27, 'Publishing ứng dụng', 'Google Play Store, app signing, release management', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(338, 28, 'Tổng quan về cảm biến', 'Phân loại cảm biến, nguyên lý hoạt động, thông số kỹ thuật', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(339, 28, 'Cảm biến nhiệt độ và độ ẩm', 'Thermocouples, RTD, thermistors, humidity sensors', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(340, 28, 'Cảm biến ánh sáng và màu sắc', 'Photodiodes, LDR, RGB sensors, ambient light sensors', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(341, 28, 'Cảm biến chuyển động và gia tốc', 'Accelerometers, gyroscopes, IMU, motion detection', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(342, 28, 'Cảm biến tiệm cận và khoảng cách', 'Ultrasonic, infrared, LiDAR, proximity sensors', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(343, 28, 'Cảm biến áp suất và lực', 'Strain gauges, pressure transducers, load cells', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(344, 28, 'Cảm biến âm thanh', 'Microphones, sound sensors, noise level measurement', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(345, 28, 'Cảm biến từ trường và la bàn', 'Hall effect sensors, magnetometers, compass applications', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(346, 28, 'Giao tiếp cảm biến', 'Analog vs digital, I2C, SPI, UART protocols', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(347, 28, 'Xử lý tín hiệu cảm biến', 'Signal conditioning, filtering, calibration, accuracy', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(348, 28, 'Ứng dụng cảm biến trong IoT', 'Smart home, industrial monitoring, environmental sensing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(349, 28, 'Thiết kế hệ thống cảm biến', 'Sensor networks, power management, data acquisition', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(350, 29, 'Kiến trúc hệ thống IoT', 'End-to-end architecture, edge computing, cloud integration', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(351, 29, 'Lựa chọn phần cứng IoT', 'Microcontrollers, single-board computers, sensor selection', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(352, 29, 'Lập trình embedded systems', 'C/C++ for embedded, real-time operating systems', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(353, 29, 'Giao thức IoT - MQTT', 'Publish-subscribe model, QoS levels, broker configuration', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(354, 29, 'Giao thức IoT - CoAP và HTTP', 'RESTful APIs for IoT, constrained application protocol', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(355, 29, 'Wireless communication technologies', 'Wi-Fi, Bluetooth, LoRa, Zigbee, cellular IoT', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(356, 29, 'Edge computing và fog computing', 'Local processing, edge analytics, distributed intelligence', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(357, 29, 'Cloud platforms for IoT', 'AWS IoT Core, Azure IoT Hub, Google Cloud IoT comparison', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(358, 29, 'IoT data processing và analytics', 'Time series data, stream processing, machine learning', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(359, 29, 'IoT security best practices', 'Device authentication, data encryption, secure updates', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(360, 29, 'Power management', 'Battery optimization, solar power, energy harvesting', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0);
INSERT INTO `subject_topics` (`id`, `subject_id`, `topic_title`, `content`, `created_at`, `updated_at`, `type`) VALUES
(361, 29, 'Firmware development', 'OTA updates, version control, testing strategies', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(362, 29, 'IoT device management', 'Provisioning, monitoring, remote configuration', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(363, 29, 'Real-world IoT applications', 'Smart agriculture, industrial IoT, smart cities', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(364, 29, 'IoT project development lifecycle', 'From concept to deployment, scalability considerations', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(365, 30, 'Advanced project planning', 'Agile methodologies, sprint planning, risk assessment', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(366, 30, 'System architecture design', 'Microservices, cloud architecture, scalability design', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(367, 30, 'Database design and optimization', 'Advanced normalization, indexing strategies, query optimization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(368, 30, 'API design and development', 'RESTful principles, API documentation, versioning', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(369, 30, 'Frontend development', 'Modern frameworks, state management, responsive design', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(370, 30, 'Backend development', 'Server-side programming, authentication, authorization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(371, 30, 'Testing strategies', 'Automated testing, performance testing, security testing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(372, 30, 'DevOps and deployment', 'CI/CD pipelines, containerization, cloud deployment', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(373, 30, 'Project documentation', 'Technical specifications, API docs, deployment guides', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(374, 30, 'Project presentation and demonstration', 'Stakeholder presentation, demo preparation, Q&A sessions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(375, 31, 'Tổng quan về bảo mật web', 'Các mối đe dọa phổ biến, OWASP Top 10, security principles', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(376, 31, 'Injection attacks', 'SQL injection, NoSQL injection, command injection prevention', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(377, 31, 'Cross-Site Scripting (XSS)', 'Reflected XSS, stored XSS, DOM-based XSS, prevention techniques', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(378, 31, 'Cross-Site Request Forgery (CSRF)', 'CSRF attacks, token-based protection, same-site cookies', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(379, 31, 'Authentication vulnerabilities', 'Weak passwords, session management, multi-factor authentication', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(380, 31, 'Authorization bypasses', 'Privilege escalation, insecure direct object references', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(381, 31, 'Security misconfiguration', 'Server hardening, default credentials, unnecessary services', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(382, 31, 'Insecure deserialization', 'Serialization risks, remote code execution prevention', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(383, 31, 'Using components with known vulnerabilities', 'Dependency scanning, patch management, SCA tools', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(384, 31, 'Insufficient logging and monitoring', 'Security logging, intrusion detection, incident response', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(385, 31, 'API security', 'API authentication, rate limiting, input validation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(386, 31, 'Secure coding practices', 'Input validation, output encoding, error handling', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(387, 31, 'Web application firewalls', 'WAF configuration, rule management, false positives', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(388, 31, 'Security testing methodologies', 'Penetration testing, vulnerability assessment, code review', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(389, 31, 'Security headers và HTTPS', 'Content Security Policy, HSTS, TLS configuration', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(390, 32, 'Tổng quan về HQTCSDL', 'Kiến trúc DBMS, các thành phần, nhiệm vụ của DBMS', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(391, 32, 'Transaction management', 'ACID properties, transaction states, concurrency control', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(392, 32, 'Concurrency control', 'Lock-based protocols, timestamp-based protocols, isolation levels', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(393, 32, 'Database recovery', 'Log-based recovery, checkpoints, ARIES algorithm', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(394, 32, 'Query processing', 'Query optimization, execution plans, cost estimation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(395, 32, 'Indexing and hashing', 'B+ trees, hash indexes, bitmap indexes, covering indexes', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(396, 32, 'Database tuning', 'Performance monitoring, index tuning, query optimization', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(397, 32, 'Distributed databases', 'Fragmentation, replication, distributed transactions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(398, 32, 'NoSQL databases', 'Document stores, key-value stores, column-family databases', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(399, 32, 'Database security', 'Access control, encryption, auditing, masking', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(400, 32, 'Backup and recovery strategies', 'Full/incremental backup, point-in-time recovery', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(401, 32, 'Database administration', 'User management, space management, maintenance tasks', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(402, 33, 'Tổng quan về quản trị mạng', 'Vai trò quản trị mạng, các nhiệm vụ chính, best practices', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(403, 33, 'Network monitoring tools', 'SNMP, NetFlow, Wireshark, network monitoring systems', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(404, 33, 'IP address management', 'DHCP configuration, DNS management, IPAM tools', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(405, 33, 'Switch and router configuration', 'VLANs, trunking, routing protocols, access control lists', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(406, 33, 'Wireless network administration', 'WLAN configuration, security, site surveys, troubleshooting', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(407, 33, 'Network security fundamentals', 'Firewalls, VPNs, intrusion detection/prevention systems', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(408, 33, 'User and group management', 'Active Directory, LDAP, authentication services', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(409, 33, 'File and print services', 'Shared resources, permissions, quota management', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(410, 33, 'Backup and disaster recovery', 'Backup strategies, recovery procedures, business continuity', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(411, 33, 'Performance monitoring and optimization', 'Baseline establishment, performance tuning, capacity planning', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(412, 33, 'Network documentation', 'Network diagrams, inventory management, change documentation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(413, 33, 'Troubleshooting methodologies', 'Systematic approach, common network problems, tools', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(414, 33, 'Virtualization in networking', 'Virtual switches, network virtualization, SDN', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(415, 33, 'Cloud networking', 'VPC, cloud load balancers, hybrid network connectivity', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(416, 33, 'Network automation', 'Scripting, configuration management, DevOps for networking', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(417, 34, 'Tổng quan về an ninh thông tin', 'CIA triad, risk management, security governance', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(418, 34, 'Cryptography fundamentals', 'Symmetric encryption, asymmetric encryption, hash functions', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(419, 34, 'Public Key Infrastructure (PKI)', 'Digital certificates, certificate authorities, PKI hierarchy', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(420, 34, 'Network security protocols', 'SSL/TLS, IPsec, SSH, security at different layers', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(421, 34, 'Access control systems', 'DAC, MAC, RBAC, ABAC, authentication methods', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(422, 34, 'Security assessment and testing', 'Vulnerability assessment, penetration testing, security audits', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(423, 34, 'Incident response and handling', 'Incident classification, response procedures, forensics', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(424, 34, 'Security policies and procedures', 'Policy development, security awareness training, compliance', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(425, 34, 'Physical security', 'Access control systems, surveillance, environmental controls', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(426, 34, 'Business continuity planning', 'Disaster recovery, backup strategies, RTO/RPO', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(427, 34, 'Legal and ethical aspects', 'Cyber laws, regulations, ethical hacking principles', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(428, 34, 'Web application security', 'OWASP Top 10, secure coding, web application firewalls', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(429, 34, 'Mobile security', 'Mobile device management, app security, BYOD policies', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(430, 34, 'Cloud security', 'Shared responsibility model, cloud security controls', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(431, 34, 'Emerging security threats', 'APT, ransomware, IoT security, AI in cybersecurity', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(432, 35, 'Socket programming fundamentals', 'Berkeley sockets, TCP vs UDP sockets, socket API', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(433, 35, 'TCP client-server programming', 'Connection-oriented communication, stream sockets', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(434, 35, 'UDP programming', 'Connectionless communication, datagram sockets', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(435, 35, 'Concurrent server design', 'Multi-threaded servers, thread pools, asynchronous I/O', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(436, 35, 'Network protocols implementation', 'Implementing custom protocols, protocol design', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(437, 35, 'HTTP programming', 'HTTP clients, REST API consumption, web scraping', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(438, 35, 'Email protocols', 'SMTP, POP3, IMAP implementation', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(439, 35, 'Network security programming', 'SSL/TLS programming, secure communication', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(440, 35, 'Multicast programming', 'IP multicast, multicast groups, applications', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(441, 35, 'Network monitoring programming', 'Packet capture, network scanning, monitoring tools', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(442, 35, 'Distributed systems programming', 'RPC, message queues, distributed computing', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(443, 35, 'Real-time communication', 'WebSockets, real-time data streaming', '2025-10-28 03:43:23', '2025-10-28 03:43:23', 0),
(444, 36, 'Tổng quan về mạng không dây', 'Lịch sử phát triển, phân loại, ứng dụng, xu hướng', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(445, 36, 'Wireless transmission fundamentals', 'Radio frequency, modulation, spread spectrum, capacity', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(446, 36, 'Wi-Fi standards (802.11)', '802.11a/b/g/n/ac/ax, comparison, deployment considerations', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(447, 36, 'Wireless LAN architecture', 'Access points, controllers, mesh networks, enterprise WLAN', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(448, 36, 'Wireless security', 'WEP, WPA, WPA2, WPA3, authentication methods', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(449, 36, 'Wireless network design', 'Site survey, coverage planning, capacity planning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(450, 36, 'Cellular networks', '4G LTE, 5G, architecture, applications', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(451, 36, 'Wireless PAN technologies', 'Bluetooth, Zigbee, NFC, applications', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(452, 36, 'Wireless WAN technologies', 'Satellite communications, microwave, WiMAX', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(453, 36, 'Emerging wireless technologies', '6G, Li-Fi, quantum communications', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(454, 37, 'Network design principles', 'Scalability, reliability, availability, security, cost', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(455, 37, 'Requirements analysis', 'Business requirements, technical requirements, constraints', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(456, 37, 'Network topology design', 'Hierarchical design, collapsed core, spine-leaf', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(457, 37, 'IP addressing design', 'Subnetting, VLSM, IPv6 addressing plan', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(458, 37, 'Routing design', 'Routing protocol selection, route redistribution, filtering', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(459, 37, 'Switching design', 'VLAN design, spanning tree, link aggregation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(460, 37, 'Network security design', 'Security zones, firewall placement, IDS/IPS deployment', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(461, 37, 'Wireless network design', 'WLAN design, coverage, capacity, roaming', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(462, 37, 'Network management design', 'Monitoring, management network, logging', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(463, 37, 'Data center network design', 'Data center architectures, storage networking', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(464, 37, 'Cloud network design', 'Hybrid cloud, connectivity options, security', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(465, 37, 'Network documentation', 'Design documentation, implementation plan, testing plan', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(466, 38, 'Assessment of office requirements', 'User needs, application requirements, growth projections', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(467, 38, 'Structured cabling', 'Cable types, standards, installation best practices', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(468, 38, 'Network equipment selection', 'Switches, routers, firewalls, wireless access points', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(469, 38, 'Server infrastructure', 'File servers, print servers, application servers', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(470, 38, 'Wireless deployment', 'Site survey, AP placement, channel planning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(471, 38, 'Network services implementation', 'DHCP, DNS, Active Directory, file sharing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(472, 38, 'Security implementation', 'Firewall rules, VPN, access controls, antivirus', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(473, 38, 'VoIP deployment', 'IP telephony, QoS configuration, unified communications', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(474, 38, 'Testing and validation', 'Performance testing, security testing, user acceptance', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(475, 38, 'Documentation and handover', 'Network diagrams, configuration docs, user training', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(476, 39, 'Tổng quan về thông tin quang', 'Lịch sử, ưu điểm, ứng dụng, xu hướng phát triển', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(477, 39, 'Nguyên lý truyền dẫn quang', 'Đặc tính ánh sáng, sợi quang, truyền dẫn trong sợi quang', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(478, 39, 'Cấu trúc sợi quang', 'Step-index fiber, graded-index fiber, single-mode vs multi-mode', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(479, 39, 'Suy hao và tán sắc', 'Các loại suy hao, tán sắc mode, tán sắc vật liệu', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(480, 39, 'Thiết bị phát quang', 'LED, laser diodes, modulation techniques', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(481, 39, 'Thiết bị thu quang', 'Photodiodes, receivers, noise considerations', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(482, 39, 'Bộ khuếch đại quang', 'EDFA, Raman amplification, semiconductor optical amplifiers', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(483, 39, 'Hệ thống WDM', 'DWDM, CWDM, multiplexers, demultiplexers', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(484, 39, 'Mạng quang', 'SONET/SDH, OTN, optical switching', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(485, 39, 'FTTx technologies', 'FTTH, FTTB, FTTC, deployment considerations', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(486, 39, 'Optical network security', 'Eavesdropping risks, protection methods', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(487, 39, 'Emerging optical technologies', 'Coherent optics, space division multiplexing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(488, 40, 'Tổng quan về điện toán đám mây', 'Định nghĩa, đặc điểm, lợi ích, mô hình dịch vụ', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(489, 40, 'Cloud deployment models', 'Public cloud, private cloud, hybrid cloud, community cloud', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(490, 40, 'Cloud service models', 'IaaS, PaaS, SaaS, comparisons and use cases', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(491, 40, 'Virtualization technologies', 'Hypervisors, containerization, virtual machines', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(492, 40, 'Amazon Web Services (AWS)', 'EC2, S3, VPC, IAM, core services overview', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(493, 40, 'Microsoft Azure', 'Virtual machines, storage, networking, Azure AD', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(494, 40, 'Google Cloud Platform', 'Compute Engine, Cloud Storage, BigQuery, services overview', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(495, 40, 'Cloud storage', 'Object storage, block storage, file storage, data lifecycle', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(496, 40, 'Cloud networking', 'VPC, load balancing, CDN, DNS services', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(497, 40, 'Cloud security', 'Shared responsibility model, security services, compliance', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(498, 40, 'Cloud migration strategies', 'Assessment, planning, migration approaches', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(499, 40, 'Cloud cost management', 'Pricing models, cost optimization, monitoring tools', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(500, 40, 'Containerization với Docker', 'Docker basics, images, containers, Dockerfile', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(501, 40, 'Orchestration với Kubernetes', 'Pods, services, deployments, scaling', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(502, 40, 'Serverless computing', 'AWS Lambda, Azure Functions, use cases, benefits', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(503, 41, 'Database security fundamentals', 'Threats to databases, security objectives, principles', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(504, 41, 'Authentication and authorization', 'Database users, roles, privileges, access control', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(505, 41, 'Database encryption', 'Transparent data encryption, column-level encryption', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(506, 41, 'Database auditing', 'Audit policies, monitoring, compliance reporting', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(507, 41, 'SQL injection prevention', 'Parameterized queries, input validation, ORM security', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(508, 41, 'Data masking và anonymization', 'Techniques for protecting sensitive data', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(509, 41, 'Database activity monitoring', 'Real-time monitoring, alerting, blocking suspicious activities', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(510, 41, 'Backup security', 'Encrypted backups, secure storage, recovery testing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(511, 41, 'Database hardening', 'Security configuration, patch management, vulnerability assessment', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(512, 41, 'Regulatory compliance', 'GDPR, HIPAA, PCI DSS requirements for databases', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(513, 41, 'NoSQL database security', 'Security considerations for non-relational databases', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(514, 41, 'Cloud database security', 'Security in cloud database services, shared responsibility', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(515, 42, 'Network security fundamentals', 'Defense in depth, security layers, network threats', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(516, 42, 'Firewalls và network segmentation', 'Packet filtering, stateful inspection, application firewalls', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(517, 42, 'Intrusion Detection/Prevention Systems', 'Signature-based, anomaly-based, hybrid detection', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(518, 42, 'Virtual Private Networks (VPNs)', 'IPsec, SSL VPN, remote access, site-to-site VPN', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(519, 42, 'Wireless security', 'WPA3, 802.1X, wireless intrusion prevention', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(520, 42, 'Network Access Control (NAC)', '802.1X, posture assessment, guest access', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(521, 42, 'DDoS protection', 'Mitigation techniques, scrubbing centers, CDN protection', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(522, 42, 'Email security', 'SPAM filtering, anti-phishing, DKIM, DMARC', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(523, 42, 'Web security gateways', 'URL filtering, content inspection, malware protection', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(524, 42, 'Network monitoring for security', 'SIEM, netflow analysis, security analytics', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(525, 42, 'Network forensics', 'Packet analysis, incident investigation, evidence collection', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(526, 42, 'Secure network protocols', 'DNSSEC, secure routing protocols, management protocols', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(527, 42, 'Software Defined Networking security', 'SDN architecture, security applications, challenges', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(528, 42, 'Zero Trust networking', 'Principles, implementation, micro-segmentation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(529, 42, 'Emerging network security trends', 'AI in network security, quantum networking security', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(530, 43, 'Ethical hacking principles', 'Legal aspects, scope definition, reporting', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(531, 43, 'Footprinting and reconnaissance', 'Information gathering, OSINT, network scanning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(532, 43, 'Vulnerability assessment', 'Vulnerability scanning, analysis, prioritization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(533, 43, 'Network-based attacks', 'Sniffing, spoofing, MITM attacks, DoS attacks', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(534, 43, 'Web application attacks', 'OWASP Top 10 exploitation, business logic flaws', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(535, 43, 'Wireless attacks', 'Rogue access points, evil twin, wireless cracking', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(536, 43, 'Social engineering', 'Phishing, pretexting, baiting, tailgating', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(537, 43, 'Privilege escalation', 'Local and remote privilege escalation techniques', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(538, 43, 'Post-exploitation techniques', 'Persistence, lateral movement, data exfiltration', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(539, 43, 'Metasploit framework', 'Exploitation, payloads, meterpreter, automation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(540, 43, 'Penetration testing methodologies', 'Planning, execution, reporting, remediation verification', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(541, 43, 'Red team exercises', 'Advanced persistent threat simulation, purple teaming', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(542, 44, 'Malware classification', 'Viruses, worms, trojans, ransomware, spyware', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(543, 44, 'Static analysis techniques', 'File fingerprinting, strings analysis, disassembly', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(544, 44, 'Dynamic analysis techniques', 'Sandbox analysis, behavioral analysis, network analysis', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(545, 44, 'Reverse engineering fundamentals', 'Disassemblers, debuggers, decompilers', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(546, 44, 'Windows internals for malware analysis', 'PE format, API hooking, process injection', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(547, 44, 'Linux malware analysis', 'ELF format, system calls, Linux-specific techniques', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(548, 44, 'Mobile malware analysis', 'Android APK analysis, iOS app analysis', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(549, 44, 'Document-based malware', 'Macro viruses, PDF exploits, Office document analysis', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(550, 44, 'Anti-analysis techniques', 'Packing, obfuscation, anti-debugging, anti-VM', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(551, 44, 'Malware analysis tools', 'IDA Pro, OllyDbg, Wireshark, Volatility', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(552, 45, 'Risk management framework', 'NIST RMF, ISO 27005, risk assessment process', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(553, 45, 'Risk identification', 'Asset identification, threat identification, vulnerability assessment', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(554, 45, 'Risk analysis', 'Qualitative vs quantitative analysis, impact assessment', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(555, 45, 'Risk evaluation và treatment', 'Risk mitigation, transfer, acceptance, avoidance', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(556, 45, 'Information security management system', 'ISO 27001, ISMS implementation, continuous improvement', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(557, 45, 'Security governance', 'Policies, standards, procedures, guidelines', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(558, 45, 'Compliance management', 'Regulatory requirements, audits, certification', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(559, 45, 'Business impact analysis', 'Critical business functions, recovery objectives', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(560, 45, 'Third-party risk management', 'Vendor assessment, contract security, monitoring', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(561, 45, 'Security metrics and reporting', 'KPIs, KRIs, dashboarding, executive reporting', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(562, 45, 'Security awareness program', 'Training development, phishing simulation, culture building', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(563, 45, 'Incident response planning', 'IR plan development, tabletop exercises, lessons learned', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(564, 46, 'Cloud security architecture', 'Shared responsibility model, cloud security controls', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(565, 46, 'Identity and access management in cloud', 'Cloud IAM, federation, privileged access management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(566, 46, 'Data protection in cloud', 'Encryption, key management, data loss prevention', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(567, 46, 'Cloud network security', 'Security groups, NACLs, web application firewalls', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(568, 46, 'Cloud security monitoring', 'Cloud trail, monitoring services, alerting', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(569, 46, 'Compliance in cloud', 'Cloud compliance frameworks, audit, certification', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(570, 46, 'Container security', 'Docker security, Kubernetes security, image scanning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(571, 46, 'Serverless security', 'Function security, event security, API security', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(572, 46, 'Cloud security assessment', 'CSPM, CWPP, cloud penetration testing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(573, 46, 'Cloud incident response', 'IR in cloud environment, forensics, recovery', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(574, 47, 'Tổng quan về hệ thống nhúng', 'Đặc điểm, phân loại, ứng dụng, thiết kế hệ thống nhúng', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(575, 47, 'Vi điều khiển và vi xử lý', 'Architecture, instruction set, memory organization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(576, 47, 'Embedded C programming', 'Language extensions, hardware access, optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(577, 47, 'Input/Output interfacing', 'GPIO, analog I/O, communication interfaces', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(578, 47, 'Timers và interrupts', 'Timer programming, interrupt service routines', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(579, 47, 'Communication protocols', 'UART, SPI, I2C, CAN, Ethernet', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(580, 47, 'Real-time operating systems', 'Task management, scheduling, inter-task communication', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(581, 47, 'Memory management', 'Flash memory, EEPROM, external memory interfaces', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(582, 47, 'Power management', 'Low-power modes, power optimization techniques', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(583, 47, 'Sensor interfacing', 'Analog sensors, digital sensors, signal conditioning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(584, 47, 'Actuator control', 'Motor control, relay driving, power electronics', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(585, 47, 'Embedded networking', 'TCP/IP stack, wireless connectivity', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(586, 47, 'Firmware development', 'Development process, testing, debugging', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(587, 47, 'Hardware/software co-design', 'Partitioning, optimization, verification', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(588, 47, 'Safety and reliability', 'Fault tolerance, safety standards, certification', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(589, 48, 'IoT network architecture', 'Protocol stack, gateway architecture, edge computing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(590, 48, 'Short-range wireless protocols', 'Bluetooth Low Energy, Zigbee, Z-Wave, Thread', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(591, 48, 'LPWAN technologies', 'LoRaWAN, Sigfox, NB-IoT, LTE-M', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(592, 48, 'IP-based IoT protocols', '6LoWPAN, adaptation layer, header compression', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(593, 48, 'IoT application protocols', 'MQTT, CoAP, AMQP, HTTP/2', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(594, 48, 'IoT gateway design', 'Protocol translation, data aggregation, security', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(595, 48, 'Network management for IoT', 'Device management, monitoring, firmware updates', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(596, 48, 'Quality of Service in IoT', 'Reliability, latency, throughput requirements', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(597, 48, 'IoT network security', 'Device authentication, network encryption, key management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(598, 48, 'Mesh networking', 'Routing protocols, self-healing, scalability', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(599, 48, '5G for IoT', 'Network slicing, massive IoT, critical IoT', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(600, 48, 'IoT network simulation', 'Network simulators, performance evaluation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(601, 49, 'Advanced embedded programming', 'Real-time programming, low-level optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(602, 49, 'Edge computing architectures', 'Fog computing, edge analytics, distributed intelligence', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(603, 49, 'IoT data processing', 'Stream processing, complex event processing, analytics', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(604, 49, 'Machine learning at the edge', 'TinyML, model optimization, on-device inference', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(605, 49, 'IoT security frameworks', 'Security by design, threat modeling, secure development', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(606, 49, 'IoT platform integration', 'Multi-cloud integration, hybrid architectures', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(607, 49, 'Digital twins', 'Concept, implementation, applications in IoT', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(608, 49, 'IoT in industrial systems', 'IIoT protocols, SCADA integration, industrial automation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(609, 49, 'Smart city applications', 'Urban IoT, smart infrastructure, public services', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(610, 49, 'Healthcare IoT', 'Medical devices, patient monitoring, regulatory aspects', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(611, 49, 'Agricultural IoT', 'Precision agriculture, environmental monitoring', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(612, 49, 'Energy management IoT', 'Smart grid, renewable energy, consumption optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(613, 49, 'IoT interoperability', 'Standards, semantic interoperability, ontologies', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(614, 49, 'IoT scalability', 'Massive deployment, management at scale, automation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(615, 49, 'IoT project management', 'Agile for IoT, risk management, deployment strategies', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(616, 50, 'IoT security challenges', 'Unique aspects of IoT security, attack surfaces', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(617, 50, 'Device security', 'Secure boot, hardware security modules, tamper resistance', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(618, 50, 'Network security in IoT', 'Protocol security, encryption, secure communication', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(619, 50, 'Cloud security for IoT', 'Data protection, access control, API security', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(620, 50, 'Privacy in IoT', 'Data privacy, anonymization, regulatory requirements', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(621, 50, 'IoT security standards', 'Industry standards, certification, compliance', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(622, 50, 'Security testing for IoT', 'Penetration testing, vulnerability assessment', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(623, 50, 'Incident response for IoT', 'Detection, analysis, containment, recovery', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(624, 50, 'Supply chain security', 'Secure development lifecycle, third-party components', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(625, 50, 'Firmware security', 'Secure updates, code signing, integrity verification', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(626, 50, 'IoT security monitoring', 'Threat detection, anomaly detection, security analytics', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(627, 50, 'Future trends in IoT security', 'Blockchain, AI, quantum-resistant cryptography', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(628, 51, 'Big data characteristics in IoT', 'Volume, velocity, variety, veracity of IoT data', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(629, 51, 'Data ingestion for IoT', 'Data collection, streaming ingestion, batch ingestion', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(630, 51, 'Data storage solutions', 'Time series databases, data lakes, distributed storage', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(631, 51, 'Stream processing frameworks', 'Apache Kafka, Apache Flink, Spark Streaming', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(632, 51, 'Batch processing for IoT data', 'MapReduce, Spark, data processing pipelines', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(633, 51, 'Time series analysis', 'Pattern recognition, anomaly detection, forecasting', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(634, 51, 'Real-time analytics', 'Complex event processing, real-time decision making', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(635, 51, 'Machine learning for IoT data', 'Predictive maintenance, pattern recognition, clustering', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(636, 51, 'Visualization of IoT data', 'Dashboards, real-time visualization, geospatial analysis', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(637, 51, 'Data governance for IoT', 'Data quality, metadata management, data lifecycle', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(638, 52, 'Machine learning overview for IoT', 'Supervised, unsupervised, reinforcement learning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(639, 52, 'Feature engineering for IoT data', 'Time series features, sensor fusion, dimensionality reduction', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(640, 52, 'Anomaly detection', 'Statistical methods, ML-based anomaly detection', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(641, 52, 'Predictive maintenance', 'Failure prediction, remaining useful life estimation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(642, 52, 'Computer vision in IoT', 'Image recognition, object detection, edge AI', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(643, 52, 'Natural language processing for IoT', 'Voice interfaces, text analysis, chatbots', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(644, 52, 'Reinforcement learning for control', 'Autonomous systems, adaptive control, optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(645, 52, 'TinyML and edge AI', 'Model optimization, on-device inference, frameworks', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(646, 52, 'Federated learning', 'Privacy-preserving ML, distributed model training', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(647, 52, 'MLOps for IoT', 'Model deployment, monitoring, retraining pipelines', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(648, 52, 'Case studies', 'Smart home, industrial IoT, healthcare applications', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(649, 52, 'Ethical considerations', 'Bias, fairness, transparency in IoT AI', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(650, 53, 'Cloud IoT platforms comparison', 'AWS IoT vs Azure IoT vs Google Cloud IoT', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(651, 53, 'Device management in cloud', 'Provisioning, monitoring, remote management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(652, 53, 'Cloud data services for IoT', 'Time series databases, data lakes, analytics services', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(653, 53, 'Serverless computing for IoT', 'Event-driven processing, serverless architectures', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(654, 53, 'Microservices for IoT', 'Containerization, service mesh, API management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(655, 53, 'Edge-cloud coordination', 'Hybrid architectures, data synchronization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(656, 53, 'AI/ML services in cloud for IoT', 'Pre-trained models, custom model training, inference', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(657, 53, 'Cost optimization', 'Pricing models, resource optimization, monitoring', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(658, 53, 'Multi-cloud strategies', 'Vendor selection, interoperability, migration', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(659, 53, 'Case studies', 'Large-scale IoT deployments, industry solutions', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(660, 54, 'Tổng quan về hệ thống phân tán', 'Đặc điểm, lợi ích, thách thức, kiến trúc', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(661, 54, 'Processes and threads', 'Distributed processes, thread models, concurrency', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(662, 54, 'Communication in distributed systems', 'Remote procedure call, message passing, web services', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(663, 54, 'Naming and discovery', 'Naming services, service discovery, DNS', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(664, 54, 'Synchronization', 'Clock synchronization, logical clocks, mutual exclusion', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(665, 54, 'Consistency and replication', 'Data consistency models, replication strategies', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(666, 54, 'Fault tolerance', 'Failure models, redundancy, recovery techniques', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(667, 54, 'Distributed file systems', 'Architecture, consistency, performance optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(668, 54, 'Distributed transactions', 'Two-phase commit, three-phase commit, distributed locking', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(669, 54, 'Distributed algorithms', 'Election algorithms, consensus protocols', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(670, 54, 'Peer-to-peer systems', 'Structured and unstructured P2P, DHT', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(671, 54, 'Distributed security', 'Authentication, authorization, secure communication', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(672, 54, 'Cloud computing as distributed systems', 'Cloud architectures, virtualization, resource management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(673, 54, 'Edge computing', 'Edge architectures, fog computing, applications', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(674, 54, 'Case studies', 'Google File System, Amazon Dynamo, Apache Hadoop', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(675, 55, 'Linux kernel architecture', 'Monolithic vs microkernel, kernel modules, system calls', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(676, 55, 'Process management in Linux', 'Process scheduling, context switching, process states', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(677, 55, 'Memory management in Linux', 'Virtual memory, paging, swapping, memory allocation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(678, 55, 'File systems', 'Ext4, XFS, Btrfs, virtual file system layer', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(679, 55, 'Device drivers', 'Character devices, block devices, network devices', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(680, 55, 'Interprocess communication', 'Pipes, signals, message queues, shared memory', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(681, 55, 'Network stack', 'TCP/IP implementation, socket interface, protocols', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(682, 55, 'Kernel programming', 'Module programming, kernel APIs, debugging', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(683, 55, 'System initialization', 'Boot process, init systems, systemd', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(684, 55, 'Performance monitoring', 'System monitoring tools, performance tuning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(685, 55, 'Security features', 'SELinux, AppArmor, capabilities, namespaces', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(686, 55, 'Container technologies', 'cgroups, namespaces, Docker, Kubernetes', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(687, 56, 'Virtualization fundamentals', 'Benefits, types of virtualization, hypervisors', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(688, 56, 'CPU virtualization', 'Binary translation, paravirtualization, hardware support', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(689, 56, 'Memory virtualization', 'Shadow page tables, extended page tables', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(690, 56, 'I/O virtualization', 'Device emulation, paravirtualized drivers, SR-IOV', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(691, 56, 'Storage virtualization', 'Block-level vs file-level, SAN, NAS', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(692, 56, 'Network virtualization', 'Virtual switches, VLAN, VXLAN, NFV', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(693, 56, 'Container virtualization', 'Docker, container orchestration, microservices', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(694, 56, 'Virtualization management', 'vCenter, OpenStack, management tools', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(695, 56, 'Performance and optimization', 'Resource allocation, performance monitoring', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(696, 56, 'Security in virtualized environments', 'Hypervisor security, VM isolation, compliance', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(697, 57, 'Cloud computing economics', 'Business models, cost-benefit analysis, ROI', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(698, 57, 'Cloud architecture patterns', 'Multi-tier, microservices, serverless, event-driven', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(699, 57, 'Cloud storage services', 'Object storage, block storage, file storage, databases', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(700, 57, 'Cloud computing services', 'Virtual machines, containers, serverless computing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(701, 57, 'Cloud networking services', 'VPC, load balancing, CDN, DNS, VPN', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(702, 57, 'Cloud security services', 'Identity management, encryption, security monitoring', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(703, 57, 'Cloud management and monitoring', 'Resource management, cost monitoring, automation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(704, 57, 'Cloud migration strategies', 'Assessment, planning, execution, optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(705, 57, 'Multi-cloud and hybrid cloud', 'Strategy, implementation, management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(706, 57, 'Cloud-native development', 'Twelve-factor app, DevOps, CI/CD in cloud', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(707, 57, 'Serverless architectures', 'Function as a Service, event-driven programming', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(708, 57, 'Emerging cloud technologies', 'Edge computing, quantum computing, AI services', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(709, 58, 'Cloud application design principles', 'Scalability, reliability, cost optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(710, 58, 'Microservices architecture', 'Design patterns, communication, data management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(711, 58, 'API design and management', 'RESTful APIs, GraphQL, API gateways', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(712, 58, 'Serverless application development', 'AWS Lambda, Azure Functions, use cases', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(713, 58, 'Container-based development', 'Docker, Kubernetes, Helm charts', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(714, 58, 'Database services in cloud', 'Relational, NoSQL, in-memory databases', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(715, 58, 'Message queues and event streaming', 'SQS, Kafka, event-driven architectures', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(716, 58, 'Identity and access management', 'Authentication, authorization, federation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(717, 58, 'Application monitoring and logging', 'CloudWatch, Application Insights, logging strategies', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(718, 58, 'Performance optimization', 'Caching, CDN, database optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(719, 58, 'Security best practices', 'Secure coding, vulnerability management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(720, 58, 'Disaster recovery and backup', 'Backup strategies, recovery procedures', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(721, 58, 'Cost optimization techniques', 'Resource right-sizing, spot instances, monitoring', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0);
INSERT INTO `subject_topics` (`id`, `subject_id`, `topic_title`, `content`, `created_at`, `updated_at`, `type`) VALUES
(722, 58, 'CI/CD for cloud applications', 'Pipeline design, automation, blue-green deployment', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(723, 58, 'Case study: Building a cloud-native application', 'End-to-end development example', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(724, 59, 'Internship preparation', 'Resume writing, interview skills, company research', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(725, 59, 'Professional workplace conduct', 'Ethics, communication, time management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(726, 59, 'Project planning and execution', 'Requirements analysis, task breakdown, execution', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(727, 59, 'Technical skills application', 'Applying academic knowledge to real-world problems', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(728, 59, 'Team collaboration', 'Working in teams, conflict resolution, communication', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(729, 59, 'Documentation and reporting', 'Progress reports, technical documentation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(730, 59, 'Presentation skills', 'Presenting work to stakeholders, demonstration', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(731, 59, 'Career development', 'Networking, professional growth, future planning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(732, 60, 'Research proposal development', 'Topic selection, problem statement, research questions', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(733, 60, 'Literature review', 'Research methodology, source evaluation, synthesis', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(734, 60, 'Research methodology', 'Quantitative vs qualitative methods, data collection', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(735, 60, 'System design and architecture', 'Technical design, technology selection, architecture', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(736, 60, 'Implementation planning', 'Development approach, tools, testing strategy', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(737, 60, 'Data analysis and interpretation', 'Statistical analysis, result interpretation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(738, 60, 'Thesis writing', 'Structure, academic writing style, citation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(739, 60, 'Results validation', 'Testing, validation methods, performance evaluation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(740, 60, 'Ethical considerations', 'Research ethics, privacy, intellectual property', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(741, 60, 'Thesis defense preparation', 'Presentation, Q&A preparation, demonstration', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(742, 61, 'Tổng quan về thương mại điện tử', 'Lịch sử, mô hình, xu hướng, tác động kinh tế', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(743, 61, 'E-commerce business models', 'B2B, B2C, C2C, B2G, emerging models', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(744, 61, 'E-commerce platform technologies', 'Shopping carts, payment gateways, CRM systems', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(745, 61, 'Digital marketing for e-commerce', 'SEO, SEM, social media marketing, email marketing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(746, 61, 'E-commerce payment systems', 'Payment processing, security, mobile payments', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(747, 61, 'Supply chain management', 'Inventory management, logistics, fulfillment', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(748, 61, 'E-commerce security', 'SSL, PCI DSS, fraud prevention, data protection', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(749, 61, 'Mobile commerce', 'Mobile apps, responsive design, mobile payments', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(750, 61, 'E-commerce analytics', 'Web analytics, customer behavior, conversion optimization', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(751, 61, 'Social commerce', 'Social media integration, influencer marketing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(752, 61, 'International e-commerce', 'Cross-border trade, localization, compliance', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(753, 61, 'Emerging trends', 'AI in e-commerce, AR/VR, voice commerce', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(754, 62, 'Distributed database architecture', 'Client-server, peer-to-peer, federated databases', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(755, 62, 'Distributed database design', 'Fragmentation, allocation, replication', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(756, 62, 'Distributed query processing', 'Query decomposition, optimization, execution', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(757, 62, 'Distributed transaction management', 'Concurrency control, recovery, two-phase commit', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(758, 62, 'Data replication', 'Synchronous vs asynchronous, consistency models', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(759, 62, 'Distributed database security', 'Access control, encryption, auditing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(760, 62, 'NoSQL distributed databases', 'MongoDB, Cassandra, distributed characteristics', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(761, 62, 'NewSQL databases', 'Distributed SQL databases, Spanner, CockroachDB', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(762, 62, 'Big data distributed systems', 'Hadoop, Spark, distributed processing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(763, 62, 'Case studies', 'Google Spanner, Amazon DynamoDB, Apache Cassandra', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(764, 63, 'Emerging technology trends', 'AI, blockchain, quantum computing, IoT', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(765, 63, 'Digital transformation', 'Strategy, implementation, case studies', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(766, 63, 'IT project management advanced', 'Agile at scale, risk management, stakeholder management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(767, 63, 'Enterprise architecture', 'TOGAF, Zachman Framework, implementation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(768, 63, 'IT governance and compliance', 'COBIT, ITIL, regulatory compliance', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(769, 63, 'Cybersecurity leadership', 'CISO role, security program management', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(770, 63, 'Data science and analytics', 'Advanced analytics, machine learning, big data', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(771, 63, 'Cloud strategy and architecture', 'Multi-cloud, hybrid cloud, cloud economics', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(772, 63, 'Software engineering trends', 'DevOps, microservices, low-code platforms', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(773, 63, 'Human-computer interaction', 'UX design, usability testing, accessibility', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(774, 63, 'IT ethics and social impact', 'Privacy, algorithmic bias, digital divide', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(775, 63, 'Research methods in IT', 'Academic research, industry research', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(776, 63, 'Technology innovation management', 'Innovation process, technology adoption', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(777, 63, 'IT consulting skills', 'Client management, solution design, presentation', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(778, 63, 'Career development in IT', 'Specialization, certification, lifelong learning', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(779, 64, 'Tổng quan về kế toán', 'Vai trò, đối tượng, nguyên tắc kế toán', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(780, 64, 'Bảng cân đối kế toán', 'Tài sản, nợ phải trả, vốn chủ sở hữu', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(781, 64, 'Báo cáo kết quả hoạt động kinh doanh', 'Doanh thu, chi phí, lợi nhuận', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(782, 64, 'Tài khoản và ghi sổ kép', 'Hệ thống tài khoản, định khoản kế toán', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(783, 64, 'Chu trình kế toán', 'Từ chứng từ đến báo cáo tài chính', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(784, 64, 'Kế toán tiền và các khoản phải thu', 'Tiền mặt, tiền gửi ngân hàng, phải thu khách hàng', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(785, 64, 'Kế toán hàng tồn kho', 'Phương pháp tính giá hàng tồn kho', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(786, 64, 'Kế toán tài sản cố định', 'Khấu hao, thanh lý, nhượng bán TSCĐ', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(787, 64, 'Kế toán nợ phải trả', 'Vay ngắn hạn, dài hạn, phải trả người bán', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(788, 64, 'Kế toán vốn chủ sở hữu', 'Vốn góp, lợi nhuận chưa phân phối', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(789, 64, 'Báo cáo lưu chuyển tiền tệ', 'Phương pháp lập, ý nghĩa', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(790, 64, 'Phân tích báo cáo tài chính', 'Các tỷ số tài chính, đánh giá tình hình tài chính', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(791, 65, 'Kế toán doanh thu và chi phí', 'Ghi nhận doanh thu, xác định kết quả kinh doanh', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(792, 65, 'Kế toán thuế', 'Thuế GTGT, thuế TNDN, thuế TNCN', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(793, 65, 'Kế toán các khoản đầu tư tài chính', 'Đầu tư chứng khoán, góp vốn liên doanh', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(794, 65, 'Kế toán ngoại tệ', 'Giao dịch ngoại tệ, chênh lệch tỷ giá', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(795, 65, 'Kế toán hợp nhất kinh doanh', 'Tập đoàn, công ty mẹ - con', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(796, 65, 'Báo cáo tài chính hợp nhất', 'Lập và trình bày báo cáo tài chính hợp nhất', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(797, 65, 'Kế toán cho vay và đi vay', 'Lãi suất, chi phí đi vay', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(798, 65, 'Kế toán thuê tài sản', 'Thuê hoạt động, thuê tài chính', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(799, 65, 'Kế toán các khoản dự phòng', 'Dự phòng phải thu, dự phòng giảm giá hàng tồn kho', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(800, 65, 'Chuẩn mực kế toán Việt Nam', 'Các chuẩn mực kế toán cơ bản, áp dụng', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(801, 66, 'Tổng quan về quản trị', 'Khái niệm, chức năng, vai trò của nhà quản trị', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(802, 66, 'Lịch sử phát triển các lý thuyết quản trị', 'Cổ điển, tâm lý xã hội, hiện đại', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(803, 66, 'Môi trường quản trị', 'Môi trường vĩ mô, vi mô, phân tích SWOT', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(804, 66, 'Ra quyết định quản trị', 'Quy trình, phương pháp, kỹ thuật ra quyết định', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(805, 66, 'Hoạch định', 'Chiến lược, kế hoạch, mục tiêu', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(806, 66, 'Tổ chức', 'Cơ cấu tổ chức, phân quyền, ủy quyền', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(807, 66, 'Lãnh đạo', 'Phong cách lãnh đạo, động viên, tạo ảnh hưởng', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(808, 66, 'Kiểm soát', 'Quy trình kiểm soát, các loại kiểm soát', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(809, 66, 'Quản trị nguồn nhân lực', 'Tuyển dụng, đào tạo, đánh giá nhân viên', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(810, 66, 'Quản trị thay đổi', 'Quản trị xung đột, đổi mới, phát triển tổ chức', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(811, 66, 'Đạo đức kinh doanh', 'Trách nhiệm xã hội, đạo đức quản trị', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(812, 66, 'Kỹ năng quản trị', 'Kỹ năng kỹ thuật, nhân sự, tư duy', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(813, 67, 'Tổng quan về marketing', 'Khái niệm, vai trò, sự phát triển của marketing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(814, 67, 'Môi trường marketing', 'Vi mô, vĩ mô, phân tích môi trường', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(815, 67, 'Hành vi người tiêu dùng', 'Quyết định mua, các yếu tố ảnh hưởng', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(816, 67, 'Nghiên cứu marketing', 'Quy trình, phương pháp nghiên cứu thị trường', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(817, 67, 'Chiến lược marketing', 'STP (Phân khúc, lựa chọn thị trường mục tiêu, định vị)', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(818, 67, 'Marketing-mix: Sản phẩm', 'Chiến lược sản phẩm, vòng đời sản phẩm', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(819, 67, 'Marketing-mix: Giá', 'Các phương pháp định giá, chiến lược giá', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(820, 67, 'Marketing-mix: Phân phối', 'Kênh phân phối, quản trị kênh', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(821, 67, 'Marketing-mix: Xúc tiến', 'Quảng cáo, PR, khuyến mãi, bán hàng cá nhân', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(822, 67, 'Marketing trong kỷ nguyên số', 'Digital marketing, social media marketing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(823, 68, 'English sentence structure', 'Parts of speech, sentence patterns, word order', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(824, 68, 'Tenses and aspects', 'Present, past, future tenses; simple, continuous, perfect', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(825, 68, 'Modal verbs', 'Can, could, may, might, must, should, would', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(826, 68, 'Conditional sentences', 'Zero, first, second, third conditionals; mixed conditionals', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(827, 68, 'Passive voice', 'Formation, usage, passive with different tenses', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(828, 68, 'Reported speech', 'Direct and indirect speech, tense changes', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(829, 68, 'Relative clauses', 'Defining and non-defining relative clauses', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(830, 68, 'Articles and determiners', 'A, an, the; some, any, no, each, every', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(831, 68, 'Prepositions', 'Time, place, movement prepositions; phrasal verbs', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(832, 68, 'Adjectives and adverbs', 'Comparative and superlative forms; adverb placement', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(833, 68, 'Conjunctions and connectors', 'Coordinating, subordinating conjunctions; linking words', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(834, 68, 'Noun phrases', 'Countable and uncountable nouns; quantifiers', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(835, 68, 'Verb patterns', 'Gerunds and infinitives; verb + object + complement', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(836, 68, 'Question formation', 'Yes/no questions, wh-questions, tag questions', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(837, 68, 'Punctuation and capitalization', 'Rules for punctuation, capitalization in English', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(838, 69, 'Everyday conversations', 'Greetings, introductions, small talk, farewells', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(839, 69, 'Social communication', 'Making requests, offers, invitations; apologizing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(840, 69, 'Professional communication', 'Meetings, presentations, negotiations', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(841, 69, 'Telephone skills', 'Making and receiving calls, taking messages', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(842, 69, 'Email writing', 'Formal and informal emails; structure and style', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(843, 69, 'Presentation skills', 'Structuring presentations, delivery techniques', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(844, 69, 'Meeting participation', 'Expressing opinions, agreeing, disagreeing', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(845, 69, 'Cross-cultural communication', 'Cultural differences, avoiding misunderstandings', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(846, 69, 'Active listening skills', 'Comprehension, clarification, response techniques', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(847, 69, 'Non-verbal communication', 'Body language, eye contact, gestures', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(848, 69, 'Building vocabulary', 'Topic-specific vocabulary, collocations, idioms', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0),
(849, 69, 'Pronunciation and intonation', 'Sounds, stress, rhythm, intonation patterns', '2025-10-28 03:43:24', '2025-10-28 03:43:24', 0);

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(255) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` enum('string','number','boolean','json') DEFAULT 'string',
  `description` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `setting_type`, `description`, `updated_by`, `updated_at`) VALUES
(1, 'MAX_FILE_SIZE', '10485760', 'number', 'Kích thước file tải lên tối đa (bytes)', 1, '2025-10-15 19:39:45'),
(2, 'ALLOWED_FILE_TYPES', '[\"pdf\", \"doc\", \"docx\", \"xls\", \"xlsx\", \"jpg\", \"png\", \"zip\"]', 'json', 'Các loại file được phép tải lên', 1, '2025-10-15 19:39:45'),
(3, 'ACADEMIC_YEAR', '2024-2025', 'string', 'Năm học hiện tại', 1, '2025-10-15 19:39:45'),
(4, 'KPI_THRESHOLD_EXCELLENT', '90', 'number', 'Ngưỡng điểm KPI xuất sắc', 1, '2025-10-15 19:39:45'),
(5, 'KPI_THRESHOLD_GOOD', '75', 'number', 'Ngưỡng điểm KPI tốt', 1, '2025-10-15 19:39:45'),
(6, 'KPI_THRESHOLD_AVERAGE', '60', 'number', 'Ngưỡng điểm KPI trung bình', 1, '2025-10-15 19:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `thoigian_hocky`
--

CREATE TABLE `thoigian_hocky` (
  `id_nhhk` int(11) NOT NULL,
  `nam_hocky` varchar(100) NOT NULL,
  `start_date` date NOT NULL DEFAULT current_timestamp(),
  `end_date` date DEFAULT NULL,
  `short_code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thoigian_hocky`
--

INSERT INTO `thoigian_hocky` (`id_nhhk`, `nam_hocky`, `start_date`, `end_date`, `short_code`) VALUES
(3, '2025-2026, học kỳ 1', '2025-10-20', '2025-10-20', '1'),
(4, '2025-2026, học kỳ 2', '2025-10-20', '2025-10-20', '2'),
(5, '2025-2026, học kỳ hè', '2025-06-01', '2025-08-31', 'H');

-- --------------------------------------------------------

--
-- Table structure for table `training_programs`
--

CREATE TABLE `training_programs` (
  `program_code` varchar(20) NOT NULL,
  `program_name` varchar(255) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `training_programs`
--

INSERT INTO `training_programs` (`program_code`, `program_name`, `department_id`, `duration`, `description`, `created_at`, `updated_at`) VALUES
('CNTT', 'Công nghệ thông tin', 1, 4, NULL, '2025-10-20 06:52:16', '2025-10-20 06:52:16'),
('KHDL', 'Khoa học dữ liệu', 6, 4, NULL, '2025-10-20 06:52:16', '2025-10-20 06:52:16'),
('KT', 'Kế toán', 2, 4, NULL, '2025-10-20 06:52:16', '2025-10-20 06:52:16'),
('NN', 'Ngôn ngữ Anh', 3, 4, NULL, '2025-10-20 06:52:16', '2025-10-20 06:52:16'),
('QTKD', 'Quản trị kinh doanh', 4, 4, NULL, '2025-10-20 06:52:16', '2025-10-20 06:52:16'),
('TTDPT', 'Truyền thông đa phương tiện', 7, 4, NULL, '2025-10-20 06:52:16', '2025-10-20 06:52:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `user_type` enum('admin','truongkhoa','giangvien') NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `avatar_url` varchar(500) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `full_name`, `user_type`, `department_id`, `is_active`, `avatar_url`, `phone_number`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin123', 'admin@university.edu', 'Nguyễn Văn Admin', 'admin', NULL, 1, NULL, '0901111111', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(2, 'khoacntt', 'khoacntt', 'truongkhoacntt@university.edu', 'PGS.TS Trần Văn Khoa', 'truongkhoa', 1, 1, NULL, '0902222222', '2025-10-15 19:39:45', '2025-10-27 11:30:05'),
(3, 'khoakt', 'khoakt', 'truongkhoakt@university.edu', 'TS. Lê Thị Hương', 'truongkhoa', 2, 1, NULL, '0903333333', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(4, 'khoann', 'khoann', 'khoangoai ngu@university.edu', 'TS. Nguyễn Thị Lan', 'truongkhoa', 3, 1, NULL, '0904444444', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(5, 'gv1.cntt', 'gv1cntt', 'giangvien1@university.edu', 'ThS. Phạm Văn An', 'giangvien', 1, 1, NULL, '0905555555', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(6, 'gv2.cntt', 'gv2cntt', 'giangvien2@university.edu', 'TS. Lê Văn Bình', 'giangvien', 1, 1, NULL, '0906666666', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(7, 'gv3.cntt', 'gv3cntt', 'giangvien3@university.edu', 'ThS. Trần Thị Châu', 'giangvien', 1, 1, NULL, '0907777777', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(8, 'gv1.kt', 'gv1kt', 'giangvienkt1@university.edu', 'ThS. Hoàng Văn Đức', 'giangvien', 2, 1, NULL, '0908888888', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(9, 'gv2.kt', 'gv2kt', 'giangvienkt2@university.edu', 'TS. Nguyễn Thị Hồng', 'giangvien', 2, 1, NULL, '0909999999', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(10, 'gv1.nn', 'gv1nn', 'giangviennn1@university.edu', 'ThS. John Smith', 'giangvien', 3, 1, NULL, '0911111111', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
(11, 'gv2.nn', 'gv2nn', 'giangviennn2@university.edu', 'ThS. Trần Thị Liên', 'giangvien', 3, 1, NULL, '0912222222', '2025-10-15 19:39:45', '2025-10-15 19:39:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `class_sections`
--
ALTER TABLE `class_sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `class_code` (`class_code`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `school_year_id` (`school_year_id`);

--
-- Indexes for table `ctdt`
--
ALTER TABLE `ctdt`
  ADD PRIMARY KEY (`id_ctdt`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `department_code` (`department_code`);

--
-- Indexes for table `department_heads`
--
ALTER TABLE `department_heads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_active_department` (`department_id`,`is_active`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `department_kpis`
--
ALTER TABLE `department_kpis`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_department_kpi` (`department_id`,`kpi_indicator_id`),
  ADD KEY `kpi_indicator_id` (`kpi_indicator_id`);

--
-- Indexes for table `evaluation_cycles`
--
ALTER TABLE `evaluation_cycles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `kpi_groups`
--
ALTER TABLE `kpi_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kpi_indicators`
--
ALTER TABLE `kpi_indicators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kpi_group_id` (`kpi_group_id`);

--
-- Indexes for table `kpi_summaries`
--
ALTER TABLE `kpi_summaries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_evaluation` (`user_id`,`evaluation_cycle_id`),
  ADD KEY `evaluation_cycle_id` (`evaluation_cycle_id`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `lecturer_kpi_data`
--
ALTER TABLE `lecturer_kpi_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_lecturer_kpi` (`user_id`,`kpi_indicator_id`,`evaluation_cycle_id`),
  ADD KEY `kpi_indicator_id` (`kpi_indicator_id`),
  ADD KEY `evaluation_cycle_id` (`evaluation_cycle_id`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `target_department_id` (`target_department_id`);

--
-- Indexes for table `notification_recipients`
--
ALTER TABLE `notification_recipients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_notification_recipient` (`notification_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subject_code` (`subject_code`);

--
-- Indexes for table `subject_program`
--
ALTER TABLE `subject_program`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_subject_program` (`subject_id`,`program_code`),
  ADD KEY `program_code` (`program_code`);

--
-- Indexes for table `subject_topics`
--
ALTER TABLE `subject_topics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `thoigian_hocky`
--
ALTER TABLE `thoigian_hocky`
  ADD PRIMARY KEY (`id_nhhk`);

--
-- Indexes for table `training_programs`
--
ALTER TABLE `training_programs`
  ADD PRIMARY KEY (`program_code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `department_id` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `class_sections`
--
ALTER TABLE `class_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ctdt`
--
ALTER TABLE `ctdt`
  MODIFY `id_ctdt` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `department_heads`
--
ALTER TABLE `department_heads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `department_kpis`
--
ALTER TABLE `department_kpis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `evaluation_cycles`
--
ALTER TABLE `evaluation_cycles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kpi_groups`
--
ALTER TABLE `kpi_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kpi_indicators`
--
ALTER TABLE `kpi_indicators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `kpi_summaries`
--
ALTER TABLE `kpi_summaries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lecturer_kpi_data`
--
ALTER TABLE `lecturer_kpi_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notification_recipients`
--
ALTER TABLE `notification_recipients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `subject_program`
--
ALTER TABLE `subject_program`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `subject_topics`
--
ALTER TABLE `subject_topics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=850;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `thoigian_hocky`
--
ALTER TABLE `thoigian_hocky`
  MODIFY `id_nhhk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `class_sections`
--
ALTER TABLE `class_sections`
  ADD CONSTRAINT `class_sections_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  ADD CONSTRAINT `class_sections_ibfk_2` FOREIGN KEY (`school_year_id`) REFERENCES `thoigian_hocky` (`id_nhhk`);

--
-- Constraints for table `department_heads`
--
ALTER TABLE `department_heads`
  ADD CONSTRAINT `department_heads_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `department_heads_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Constraints for table `department_kpis`
--
ALTER TABLE `department_kpis`
  ADD CONSTRAINT `department_kpis_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `department_kpis_ibfk_2` FOREIGN KEY (`kpi_indicator_id`) REFERENCES `kpi_indicators` (`id`);

--
-- Constraints for table `evaluation_cycles`
--
ALTER TABLE `evaluation_cycles`
  ADD CONSTRAINT `evaluation_cycles_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `kpi_indicators`
--
ALTER TABLE `kpi_indicators`
  ADD CONSTRAINT `kpi_indicators_ibfk_1` FOREIGN KEY (`kpi_group_id`) REFERENCES `kpi_groups` (`id`);

--
-- Constraints for table `kpi_summaries`
--
ALTER TABLE `kpi_summaries`
  ADD CONSTRAINT `kpi_summaries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `kpi_summaries_ibfk_2` FOREIGN KEY (`evaluation_cycle_id`) REFERENCES `evaluation_cycles` (`id`),
  ADD CONSTRAINT `kpi_summaries_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `lecturer_kpi_data`
--
ALTER TABLE `lecturer_kpi_data`
  ADD CONSTRAINT `lecturer_kpi_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `lecturer_kpi_data_ibfk_2` FOREIGN KEY (`kpi_indicator_id`) REFERENCES `kpi_indicators` (`id`),
  ADD CONSTRAINT `lecturer_kpi_data_ibfk_3` FOREIGN KEY (`evaluation_cycle_id`) REFERENCES `evaluation_cycles` (`id`),
  ADD CONSTRAINT `lecturer_kpi_data_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`target_department_id`) REFERENCES `departments` (`id`);

--
-- Constraints for table `notification_recipients`
--
ALTER TABLE `notification_recipients`
  ADD CONSTRAINT `notification_recipients_ibfk_1` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notification_recipients_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `subject_program`
--
ALTER TABLE `subject_program`
  ADD CONSTRAINT `subject_program_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subject_program_ibfk_2` FOREIGN KEY (`program_code`) REFERENCES `training_programs` (`program_code`) ON DELETE CASCADE;

--
-- Constraints for table `subject_topics`
--
ALTER TABLE `subject_topics`
  ADD CONSTRAINT `subject_topics_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`);

--
-- Constraints for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD CONSTRAINT `system_settings_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
