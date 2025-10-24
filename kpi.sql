-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2025 at 10:53 AM
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
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thoigian_hocky`
--

INSERT INTO `thoigian_hocky` (`id_nhhk`, `nam_hocky`, `start_date`, `end_date`) VALUES
(3, '2025-2026, học kỳ 1', '2025-10-20', '2025-10-20'),
(4, '2025-2026, học kỳ 2', '2025-10-20', '2025-10-20');

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
(2, 'khoacntt', 'khoacntt', 'trungkhoacntt@university.edu', 'PGS.TS Trần Văn Khoa', 'truongkhoa', 1, 1, NULL, '0902222222', '2025-10-15 19:39:45', '2025-10-15 19:39:45'),
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
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `thoigian_hocky`
--
ALTER TABLE `thoigian_hocky`
  MODIFY `id_nhhk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
