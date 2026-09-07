<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng Ký Tài Khoản</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        padding: 30px 15px;
    }
    .register-card {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        width: 100%;
        max-width: 480px;
        padding: 35px 30px;
    }
</style>
</head>
<body>

<div class="register-card">
    <div class="text-center mb-4">
        <i class="bi bi-person-plus-fill fs-1 text-primary"></i>
        <h3 class="fw-bold text-dark mt-2 mb-1">ĐĂNG KÝ TÀI KHOẢN</h3>
        <p class="text-muted small">Tạo tài khoản để mua sắm và quản lý đơn hàng</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small" role="alert">
            <i class="bi bi-exclamation-circle-fill me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate id="registerForm">
        <div class="mb-3">
            <label for="username" class="form-label fw-semibold small">Tên đăng nhập (*):</label>
            <input type="text" class="form-control" id="username" name="username" required 
                   minlength="4" maxlength="30" pattern="^[a-zA-Z0-9_]{4,30}$" 
                   value="${param.username}" placeholder="4-30 ký tự, không dấu, không cách">
            <div class="invalid-feedback small">Tên đăng nhập phải từ 4-30 ký tự, chỉ chứa chữ cái, số và gạch dưới.</div>
        </div>

        <div class="mb-3">
            <label for="fullname" class="form-label fw-semibold small">Họ và tên (*):</label>
            <input type="text" class="form-control" id="fullname" name="fullname" required 
                   minlength="2" maxlength="100" value="${param.fullname}" placeholder="Ví dụ: Huỳnh Cao Trung Đức">
            <div class="invalid-feedback small">Vui lòng nhập họ và tên (từ 2 ký tự trở lên).</div>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label fw-semibold small">Email nhận mã OTP (*):</label>
            <input type="email" class="form-control" id="email" name="email" required 
                   pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                   value="${param.email}" placeholder="example@gmail.com">
            <div class="invalid-feedback small">Vui lòng nhập địa chỉ email hợp lệ.</div>
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label fw-semibold small">Số điện thoại (*):</label>
            <input type="tel" class="form-control" id="phone" name="phone" required 
                   pattern="^(0[3|5|7|8|9])[0-9]{8}$"
                   value="${param.phone}" placeholder="Ví dụ: 0912345678">
            <div class="invalid-feedback small">Số điện thoại phải gồm 10 chữ số (bắt đầu bằng 03, 05, 07, 08, 09).</div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label fw-semibold small">Mật khẩu (*):</label>
            <input type="password" class="form-control" id="password" name="password" required 
                   minlength="6" placeholder="Tối thiểu 6 ký tự">
            <div class="invalid-feedback small">Mật khẩu phải chứa ít nhất 6 ký tự.</div>
        </div>

        <div class="mb-3">
            <label for="confirmPassword" class="form-label fw-semibold small">Xác nhận mật khẩu (*):</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required 
                   placeholder="Nhập lại mật khẩu trên">
            <div class="invalid-feedback small" id="confirmFeedback">Mật khẩu xác nhận không trùng khớp.</div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mt-3">
            <i class="bi bi-shield-check me-1"></i>Đăng Ký & Nhận Mã OTP
        </button>
    </form>

    <div class="text-center mt-4 small text-muted">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-semibold">Đăng nhập ngay</a> 
        <span class="mx-1">•</span> 
        <a href="${pageContext.request.contextPath}/home" class="text-decoration-none text-secondary">Về trang chủ</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
    'use strict';
    const form = document.getElementById('registerForm');
    const pwd = document.getElementById('password');
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