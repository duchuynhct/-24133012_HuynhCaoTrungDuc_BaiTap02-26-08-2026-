<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng Nhập Hệ Thống</title>
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
    .login-card {
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

<div class="login-card">
    <div class="text-center mb-4">
        <i class="bi bi-shield-lock-fill fs-1 text-primary"></i>
        <h3 class="fw-bold text-dark mt-2 mb-1">ĐĂNG NHẬP</h3>
        <p class="text-muted small">Chào mừng bạn quay trở lại với Shop Online</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small" role="alert">
            <i class="bi bi-exclamation-circle-fill me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show small" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate id="loginForm">
        <div class="mb-3">
            <label for="username" class="form-label fw-semibold small">Tên đăng nhập (*):</label>
            <div class="input-group has-validation">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input type="text" class="form-control" id="username" name="username" required 
                       minlength="3" placeholder="Nhập tên tài khoản" value="${param.username}" />
                <div class="invalid-feedback small">Vui lòng nhập tên đăng nhập (tối thiểu 3 ký tự).</div>
            </div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label fw-semibold small">Mật khẩu (*):</label>
            <div class="input-group has-validation">
                <span class="input-group-text"><i class="bi bi-key"></i></span>
                <input type="password" class="form-control" id="password" name="password" required 
                       minlength="6" placeholder="Nhập mật khẩu" />
                <div class="invalid-feedback small">Vui lòng nhập mật khẩu (tối thiểu 6 ký tự).</div>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mt-3">
            <i class="bi bi-box-arrow-in-right me-1"></i>Đăng Nhập
        </button>
    </form>

    <div class="d-flex justify-content-between align-items-center mt-3 pt-2 border-top small">
        <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none">Quên mật khẩu?</a>
        <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-semibold">Đăng ký mới</a>
    </div>

    <div class="text-center mt-3 small">
        <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none">&larr; Về trang chủ</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
    'use strict';
    const form = document.getElementById('loginForm');
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