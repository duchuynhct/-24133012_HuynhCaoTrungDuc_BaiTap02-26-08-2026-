<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quên Mật Khẩu</title>
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
    .forgot-card {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        width: 100%;
        max-width: 420px;
        padding: 35px 30px;
    }
</style>
</head>
<body>

<div class="forgot-card">
    <div class="text-center mb-4">
        <i class="bi bi-envelope-check-fill fs-1 text-primary"></i>
        <h3 class="fw-bold text-dark mt-2 mb-1">QUÊN MẬT KHẨU</h3>
        <p class="text-muted small">Nhập địa chỉ email đăng ký để nhận mã OTP khôi phục mật khẩu</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small" role="alert">
            <i class="bi bi-exclamation-circle-fill me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="needs-validation" novalidate id="forgotForm">
        <div class="mb-3">
            <label for="email" class="form-label fw-semibold small">Địa chỉ Email (*):</label>
            <div class="input-group has-validation">
                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                <input type="email" class="form-control" id="email" name="email" required 
                       pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                       value="${param.email}" placeholder="example@gmail.com" />
                <div class="invalid-feedback small">Vui lòng nhập địa chỉ email hợp lệ.</div>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mt-2">
            <i class="bi bi-send-check me-1"></i>Gửi Mã OTP Xác Nhận
        </button>
    </form>

    <div class="text-center mt-4 small">
        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-semibold">&larr; Quay lại trang đăng nhập</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
    'use strict';
    const form = document.getElementById('forgotForm');
    form.addEventListener('submit', event => {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    }, false);
})();
</script>

</body>
</html>