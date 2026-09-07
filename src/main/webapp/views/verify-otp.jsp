<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Xác Thực Mã OTP</title>
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
    .otp-card {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        width: 100%;
        max-width: 440px;
        padding: 35px 30px;
        text-align: center;
    }
    .otp-code-input {
        letter-spacing: 12px;
        font-size: 28px;
        font-weight: 700;
        text-align: center;
        font-family: monospace;
    }
</style>
</head>
<body>

<div class="otp-card">
    <div class="mb-3">
        <i class="bi bi-patch-check-fill fs-1 text-success"></i>
        <h3 class="fw-bold text-dark mt-2 mb-1">XÁC THỰC MÃ OTP</h3>
        <p class="text-muted small">
            Mã OTP đã được gửi đến email:<br/>
            <strong class="text-primary">${email != null ? email : sessionScope.otp_email}</strong>
        </p>
    </div>

    <c:if test="${not empty sessionScope.demo_otp}">
        <div class="alert alert-info border border-primary border-2 p-3 mb-3 text-center">
            <div class="small fw-bold text-primary mb-1"><i class="bi bi-bell-fill me-1"></i>MÃ OTP KÍCH HOẠT TEST NHANH:</div>
            <div class="fs-2 fw-bold text-danger font-monospace letter-spacing-4">${sessionScope.demo_otp}</div>
            <button type="button" class="btn btn-sm btn-primary mt-2" onclick="document.getElementById('otpInput').value='${sessionScope.demo_otp}';">
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
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show small" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="needs-validation" novalidate id="otpForm">
        <input type="hidden" name="email" value="${email != null ? email : sessionScope.otp_email}" />

        <div class="mb-3 text-start">
            <label for="otpInput" class="form-label fw-semibold small text-center d-block">Nhập mã OTP (6 chữ số):</label>
            <input type="text" id="otpInput" name="otp" 
                   value="${not empty sessionScope.demo_otp ? sessionScope.demo_otp : ''}" 
                   class="form-control otp-code-input" maxlength="6" pattern="^[0-9]{6}$" 
                   placeholder="------" autofocus required />
            <div class="invalid-feedback small text-center">Vui lòng nhập đúng 6 chữ số OTP.</div>
            <div class="form-text small text-center text-muted">Mã gồm 6 chữ số và có hiệu lực trong vòng 5 phút.</div>
        </div>

        <button type="submit" class="btn btn-success w-100 py-2 fw-semibold mt-2">
            <i class="bi bi-check2-circle me-1"></i>KÍCH HOẠT TÀI KHOẢN
        </button>
    </form>

    <div class="mt-4 pt-2 border-top small text-muted">
        Chưa nhận được mã?<br/>
        <a href="${pageContext.request.contextPath}/resend-otp?email=${email != null ? email : sessionScope.otp_email}" class="text-decoration-none fw-semibold">Gửi lại mã OTP mới</a>
    </div>

    <div class="mt-3 small">
        <a href="${pageContext.request.contextPath}/register" class="text-secondary text-decoration-none">&larr; Quay lại trang đăng ký</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
    'use strict';
    const form = document.getElementById('otpForm');
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