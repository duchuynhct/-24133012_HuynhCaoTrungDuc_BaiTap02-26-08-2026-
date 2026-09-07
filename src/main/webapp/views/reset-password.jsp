<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đặt Lại Mật Khẩu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        padding: 20px 15px;
    }
    .reset-card {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        width: 100%;
        max-width: 440px;
        padding: 35px 30px;
    }
    .otp-code-input {
        letter-spacing: 12px;
        font-size: 24px;
        font-weight: 700;
        text-align: center;
        font-family: monospace;
    }
</style>
</head>
<body>

<div class="reset-card">
    <div class="text-center mb-3">
        <i class="bi bi-key-fill fs-1 text-warning"></i>
        <h3 class="fw-bold text-dark mt-2 mb-1">ĐẶT LẠI MẬT KHẨU</h3>
        <p class="text-muted small">
            Nhập mã OTP đã gửi đến email:<br/>
            <strong class="text-primary">${email != null ? email : sessionScope.reset_email}</strong>
        </p>
    </div>

    <c:if test="${not empty sessionScope.demo_otp}">
        <div class="alert alert-info border border-primary border-2 p-3 mb-3 text-center">
            <div class="small fw-bold text-primary mb-1"><i class="bi bi-bell-fill me-1"></i>MÃ OTP KHÔI PHỤC TEST NHANH:</div>
            <div class="fs-2 fw-bold text-danger font-monospace letter-spacing-4">${sessionScope.demo_otp}</div>
            <button type="button" class="btn btn-sm btn-primary mt-2" onclick="document.getElementById('otp').value='${sessionScope.demo_otp}';">
                <i class="bi bi-clipboard-check me-1"></i>Tự động điền mã
            </button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small" role="alert">
            <i class="bi bi-exclamation-circle-fill me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post" class="needs-validation" novalidate id="resetForm">
        <input type="hidden" name="email" value="${email != null ? email : sessionScope.reset_email}" />

        <div class="mb-3">
            <label for="otp" class="form-label fw-semibold small">Mã OTP (6 chữ số) (*):</label>
            <input type="text" id="otp" name="otp" 
                   value="${not empty sessionScope.demo_otp ? sessionScope.demo_otp : ''}" 
                   class="form-control otp-code-input" maxlength="6" pattern="^[0-9]{6}$" 
                   placeholder="------" required autofocus />
            <div class="invalid-feedback small text-center">Mã OTP phải gồm 6 chữ số.</div>
        </div>

        <div class="mb-3">
            <label for="newPassword" class="form-label fw-semibold small">Mật khẩu mới (*):</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" 
                   minlength="6" required placeholder="Tối thiểu 6 ký tự" />
            <div class="invalid-feedback small">Mật khẩu mới phải có ít nhất 6 ký tự.</div>
        </div>

        <div class="mb-3">
            <label for="confirmPassword" class="form-label fw-semibold small">Xác nhận mật khẩu (*):</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                   required placeholder="Nhập lại mật khẩu mới" />
            <div class="invalid-feedback small" id="confirmFeedback">Mật khẩu xác nhận không khớp.</div>
        </div>

        <button type="submit" class="btn btn-warning w-100 py-2 fw-semibold mt-2 text-dark">
            <i class="bi bi-check-circle me-1"></i>Xác Nhận Đổi Mật Khẩu
        </button>
    </form>

    <div class="text-center mt-4 small">
        <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none">Gửi lại mã OTP</a>
        <span class="mx-1">•</span>
        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-semibold">Đăng nhập</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
    'use strict';
    const form = document.getElementById('resetForm');
    const pwd = document.getElementById('newPassword');
    const confirmPwd = document.getElementById('confirmPassword');

    form.addEventListener('submit', event => {
        if (pwd.value !== confirmPwd.value) {
            confirmPwd.setCustomValidity('Passwords must match');
        } else {
            confirmPwd.setCustomValidity('');
        }

        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    }, false);

    confirmPwd.addEventListener('input', () => {
        if (pwd.value !== confirmPwd.value) {
            confirmPwd.setCustomValidity('Passwords must match');
        } else {
            confirmPwd.setCustomValidity('');
        }
    });
})();
</script>

</body>
</html>