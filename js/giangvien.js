// giangvien.js - Interactive Features for Lecturer Dashboard

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all dashboard features
    initDashboard();
    initCharts();
    initNotifications();
    initQuickActions();
    initProgressBars();
});

// Main dashboard initialization
function initDashboard() {
    console.log('KPI Lecturer Dashboard initialized');
    
    // Add loading animation to stats cards
    animateStats();
    
    // Initialize tooltips
    initTooltips();
    
    // Add real-time updates
    startRealTimeUpdates();
}

// Animate stats numbers on scroll
function animateStats() {
    const statsGrid = document.querySelector('.stats-grid');
    if (!statsGrid) return;

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateStatNumbers();
                observer.unobserve(entry.target);
            }
        });
    });

    observer.observe(statsGrid);
}

// Animate statistic numbers counting up
function animateStatNumbers() {
    const statNumbers = document.querySelectorAll('.stat-number');
    
    statNumbers.forEach(stat => {
        const target = parseInt(stat.textContent);
        const duration = 2000; // 2 seconds
        const step = target / (duration / 16); // 60fps
        let current = 0;
        
        const timer = setInterval(() => {
            current += step;
            if (current >= target) {
                stat.textContent = target;
                clearInterval(timer);
            } else {
                stat.textContent = Math.floor(current);
            }
        }, 16);
    });
}

// Initialize progress bar animations
function initProgressBars() {
    const progressBars = document.querySelectorAll('.progress-fill');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const progressFill = entry.target;
                const width = progressFill.style.width;
                progressFill.style.width = '0%';
                
                setTimeout(() => {
                    progressFill.style.transition = 'width 1.5s ease-in-out';
                    progressFill.style.width = width;
                }, 300);
                
                observer.unobserve(progressFill);
            }
        });
    });

    progressBars.forEach(bar => observer.observe(bar));
}

// Initialize tooltips
function initTooltips() {
    const tooltipTriggers = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    if (typeof bootstrap !== 'undefined') {
        tooltipTriggers.forEach(trigger => {
            new bootstrap.Tooltip(trigger);
        });
    }
}

// Initialize chart functionality (placeholder for real charts)
function initCharts() {
    // This would integrate with Chart.js or similar library
    console.log('📊 Charts initialized - Ready for data visualization');
    
    // Example: Create simple progress chart
    createProgressChart();
}

// Create progress chart (simplified version)
function createProgressChart() {
    const progressData = {
        teaching: 90,
        research: 88,
        service: 120
    };

    // Animate progress bars with delay
    Object.keys(progressData).forEach((type, index) => {
        setTimeout(() => {
            const bar = document.querySelector(`.progress-fill.${type}`);
            if (bar) {
                bar.style.width = progressData[type] + '%';
            }
        }, index * 500);
    });
}

// Notification system
function initNotifications() {
    const notificationItems = document.querySelectorAll('.notification-item');
    
    notificationItems.forEach(item => {
        item.addEventListener('click', function() {
            markAsRead(this);
        });
        
        // Add context menu for notifications
        item.addEventListener('contextmenu', function(e) {
            e.preventDefault();
            showNotificationContextMenu(e, this);
        });
    });
    
    // Mark all as read functionality
    const markAllReadBtn = document.querySelector('.card-link[href="#"]');
    if (markAllReadBtn) {
        markAllReadBtn.addEventListener('click', function(e) {
            e.preventDefault();
            markAllAsRead();
        });
    }
}

// Mark notification as read
function markAsRead(notificationElement) {
    if (notificationElement.classList.contains('unread')) {
        notificationElement.classList.remove('unread');
        
        // Update notification count in stats
        updateNotificationCount(-1);
        
        // Show confirmation
        showToast('Đã đánh dấu là đã đọc', 'success');
    }
}

// Mark all notifications as read
function markAllAsRead() {
    const unreadNotifications = document.querySelectorAll('.notification-item.unread');
    
    unreadNotifications.forEach(notification => {
        notification.classList.remove('unread');
    });
    
    // Update notification count
    updateNotificationCount(-unreadNotifications.length);
    
    showToast(`Đã đánh dấu ${unreadNotifications.length} thông báo là đã đọc`, 'success');
}

// Update notification count in stats
function updateNotificationCount(change) {
    const notificationStat = document.querySelector('.stat-card.warning .stat-number');
    if (notificationStat) {
        const currentCount = parseInt(notificationStat.textContent);
        const newCount = Math.max(0, currentCount + change);
        notificationStat.textContent = newCount;
        
        // Update trend text
        const trendElement = notificationStat.closest('.stat-content').querySelector('.stat-trend');
        if (trendElement) {
            if (change < 0) {
                trendElement.innerHTML = '<i class="fas fa-arrow-down me-1"></i> Đã cập nhật';
                trendElement.className = 'stat-trend trend-down';
            }
        }
    }
}

// Quick actions functionality
function initQuickActions() {
    const actionButtons = document.querySelectorAll('.action-btn');
    
    actionButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            // Add click animation
            this.style.transform = 'scale(0.95)';
            setTimeout(() => {
                this.style.transform = '';
            }, 150);
            
            // Track action in analytics (placeholder)
            trackAction(this.querySelector('.action-title').textContent);
        });
    });
}

// Track user actions (placeholder for analytics)
function trackAction(actionName) {
    console.log(`📈 Action tracked: ${actionName}`);
    // Here you would integrate with Google Analytics or similar
}

// Real-time updates simulation
function startRealTimeUpdates() {
    // Simulate real-time KPI updates
    setInterval(() => {
        simulateKPIUpdate();
    }, 30000); // Update every 30 seconds
    
    // Simulate new notifications
    setInterval(() => {
        simulateNewNotification();
    }, 60000); // Check every minute
}

// Simulate KPI data updates
function simulateKPIUpdate() {
    const kpiItems = document.querySelectorAll('.kpi-item');
    if (kpiItems.length > 0) {
        const randomKPI = kpiItems[Math.floor(Math.random() * kpiItems.length)];
        const statusBadge = randomKPI.querySelector('.status-badge');
        
        if (statusBadge && statusBadge.classList.contains('status-pending')) {
            // Simulate status change
            const newStatus = Math.random() > 0.5 ? 'approved' : 'rejected';
            updateKPIStatus(statusBadge, newStatus);
        }
    }
}

// Update KPI status with animation
function updateKPIStatus(statusBadge, newStatus) {
    const statusMap = {
        'approved': { class: 'status-approved', text: 'Đã duyệt' },
        'rejected': { class: 'status-rejected', text: 'Từ chối' },
        'pending': { class: 'status-pending', text: 'Chờ duyệt' }
    };
    
    const oldStatus = statusBadge.className;
    const newStatusData = statusMap[newStatus];
    
    // Add update animation
    statusBadge.style.transform = 'scale(0.8)';
    statusBadge.style.opacity = '0.6';
    
    setTimeout(() => {
        statusBadge.className = `status-badge ${newStatusData.class}`;
        statusBadge.textContent = newStatusData.text;
        statusBadge.style.transform = 'scale(1)';
        statusBadge.style.opacity = '1';
    }, 300);
    
    // Show update notification
    showToast(`Trạng thái KPI đã được cập nhật: ${newStatusData.text}`, 'info');
}

// Simulate new notification
function simulateNewNotification() {
    // Only simulate if user is active (tab visible)
    if (document.hidden) return;
    
    const shouldAddNotification = Math.random() > 0.7; // 30% chance
    
    if (shouldAddNotification) {
        const notificationsList = document.querySelector('.notifications-list');
        if (notificationsList) {
            const newNotification = createNotificationElement();
            notificationsList.insertBefore(newNotification, notificationsList.firstChild);
            
            // Update notification count
            updateNotificationCount(1);
            
            // Show desktop notification
            showDesktopNotification('Thông báo mới từ hệ thống KPI');
        }
    }
}

// Create new notification element
function createNotificationElement() {
    const notifications = [
        {
            icon: 'fas fa-check-circle text-success',
            title: 'KPI mới được duyệt',
            desc: 'Tiêu chí nghiên cứu khoa học đã được phê duyệt',
            time: 'Vừa xong'
        },
        {
            icon: 'fas fa-exclamation-triangle text-warning',
            title: 'Nhắc nhở hạn nộp',
            desc: 'Còn 3 ngày để hoàn thành KPI học kỳ',
            time: '2 phút trước'
        },
        {
            icon: 'fas fa-info-circle text-info',
            title: 'Cập nhật hệ thống',
            desc: 'Hệ thống vừa được cập nhật phiên bản mới',
            time: '5 phút trước'
        }
    ];
    
    const randomNotif = notifications[Math.floor(Math.random() * notifications.length)];
    
    const notificationElement = document.createElement('div');
    notificationElement.className = 'notification-item unread';
    notificationElement.innerHTML = `
        <div class="notification-icon">
            <i class="${randomNotif.icon}"></i>
        </div>
        <div class="notification-content">
            <div class="notification-title">${randomNotif.title}</div>
            <div class="notification-desc">${randomNotif.desc}</div>
            <div class="notification-time">${randomNotif.time}</div>
        </div>
    `;
    
    // Add click event
    notificationElement.addEventListener('click', function() {
        markAsRead(this);
    });
    
    return notificationElement;
}

// Show desktop notification
function showDesktopNotification(message) {
    if ('Notification' in window && Notification.permission === 'granted') {
        new Notification('Hệ thống KPI', {
            body: message,
            icon: '/assets/images/logo.png'
        });
    }
}

// Request notification permission
function requestNotificationPermission() {
    if ('Notification' in window && Notification.permission === 'default') {
        Notification.requestPermission().then(permission => {
            if (permission === 'granted') {
                console.log('🔔 Notification permission granted');
            }
        });
    }
}

// Toast notification system
function showToast(message, type = 'info') {
    // Create toast container if it doesn't exist
    let toastContainer = document.getElementById('toast-container');
    if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.id = 'toast-container';
        toastContainer.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1055;
            max-width: 350px;
        `;
        document.body.appendChild(toastContainer);
    }
    
    const toastId = 'toast-' + Date.now();
    const typeIcons = {
        success: 'fas fa-check-circle',
        error: 'fas fa-exclamation-circle',
        warning: 'fas fa-exclamation-triangle',
        info: 'fas fa-info-circle'
    };
    
    const toastHTML = `
        <div id="${toastId}" class="toast show" role="alert">
            <div class="toast-header">
                <i class="${typeIcons[type] || typeIcons.info} text-${type} me-2"></i>
                <strong class="me-auto">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                ${message}
            </div>
        </div>
    `;
    
    toastContainer.insertAdjacentHTML('beforeend', toastHTML);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        const toast = document.getElementById(toastId);
        if (toast) {
            toast.remove();
        }
    }, 5000);
}

// Context menu for notifications
function showNotificationContextMenu(event, element) {
    event.preventDefault();
    
    // Remove existing context menu
    const existingMenu = document.getElementById('notification-context-menu');
    if (existingMenu) {
        existingMenu.remove();
    }
    
    const contextMenu = document.createElement('div');
    contextMenu.id = 'notification-context-menu';
    contextMenu.style.cssText = `
        position: fixed;
        left: ${event.pageX}px;
        top: ${event.pageY}px;
        background: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        z-index: 1060;
        min-width: 180px;
    `;
    
    contextMenu.innerHTML = `
        <div class="context-menu-item" data-action="mark-read">
            <i class="fas fa-check me-2"></i>Đánh dấu đã đọc
        </div>
        <div class="context-menu-item" data-action="pin">
            <i class="fas fa-thumbtack me-2"></i>Ghim thông báo
        </div>
        <hr class="my-1">
        <div class="context-menu-item text-danger" data-action="delete">
            <i class="fas fa-trash me-2"></i>Xóa thông báo
        </div>
    `;
    
    document.body.appendChild(contextMenu);
    
    // Add event listeners to context menu items
    contextMenu.querySelectorAll('.context-menu-item').forEach(item => {
        item.style.cssText = `
            padding: 8px 12px;
            cursor: pointer;
            transition: background 0.2s;
        `;
        
        item.addEventListener('mouseenter', function() {
            this.style.background = '#f8f9fa';
        });
        
        item.addEventListener('mouseleave', function() {
            this.style.background = '';
        });
        
        item.addEventListener('click', function() {
            const action = this.getAttribute('data-action');
            handleContextMenuAction(action, element);
            contextMenu.remove();
        });
    });
    
    // Close context menu when clicking outside
    setTimeout(() => {
        document.addEventListener('click', function closeContextMenu() {
            contextMenu.remove();
            document.removeEventListener('click', closeContextMenu);
        });
    });
}

// Handle context menu actions
function handleContextMenuAction(action, element) {
    switch (action) {
        case 'mark-read':
            markAsRead(element);
            break;
        case 'pin':
            element.style.borderLeft = '4px solid #ffc107';
            showToast('Đã ghim thông báo', 'warning');
            break;
        case 'delete':
            element.style.opacity = '0';
            setTimeout(() => {
                element.remove();
                showToast('Đã xóa thông báo', 'error');
            }, 300);
            break;
    }
}

// Keyboard shortcuts
document.addEventListener('keydown', function(e) {
    // Ctrl + N: Focus on new KPI button
    if (e.ctrlKey && e.key === 'n') {
        e.preventDefault();
        const newKpiBtn = document.querySelector('.btn-primary');
        if (newKpiBtn) newKpiBtn.focus();
    }
    
    // Ctrl + 1: Quick actions - Nhập KPI
    if (e.ctrlKey && e.key === '1') {
        e.preventDefault();
        const nhapKpiBtn = document.querySelector('.action-btn.primary');
        if (nhapKpiBtn) nhapKpiBtn.click();
    }
    
    // Ctrl + 2: Quick actions - Xem báo cáo
    if (e.ctrlKey && e.key === '2') {
        e.preventDefault();
        const xemBaoCaoBtn = document.querySelector('.action-btn.success');
        if (xemBaoCaoBtn) xemBaoCaoBtn.click();
    }
});

// Export functions for global access (if needed)
window.GiangVienDashboard = {
    initDashboard,
    showToast,
    markAllAsRead,
    updateNotificationCount
};

// Initialize when page loads
initDashboard();