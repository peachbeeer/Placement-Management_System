// Placement Management System - main.js

// Confirm before delete
function confirmDelete(url) {
    if (confirm('Are you sure you want to delete this record?')) {
        window.location.href = url;
    }
}

// Auto-hide alerts after 3 seconds
document.addEventListener('DOMContentLoaded', function () {
    const alerts = document.querySelectorAll('.alert');
    if (alerts.length > 0) {
        setTimeout(() => {
            alerts.forEach(a => {
                a.style.transition = 'opacity 0.4s';
                a.style.opacity = '0';
                setTimeout(() => a.remove(), 400);
            });
        }, 3000);
    }

    // Mark active nav link
    const currentPath = window.location.pathname;
    document.querySelectorAll('.sidebar a').forEach(link => {
        if (link.getAttribute('href') && currentPath.includes(link.getAttribute('href').split('?')[0])) {
            link.classList.add('active');
        }
    });
});

// Result form: auto-calculate percentage
function calcPercentage() {
    const obtained = parseFloat(document.getElementById('marks_obtained').value) || 0;
    const total = parseFloat(document.getElementById('total_marks').value) || 0;
    if (total > 0) {
        const pct = ((obtained / total) * 100).toFixed(2);
        const statusEl = document.getElementById('result_preview');
        if (statusEl) {
            statusEl.textContent = pct + '% — ' + (pct > 40 ? 'PASS ✓' : 'FAIL ✗');
            statusEl.className = pct > 40 ? 'badge badge-success' : 'badge badge-danger';
        }
    }
}
