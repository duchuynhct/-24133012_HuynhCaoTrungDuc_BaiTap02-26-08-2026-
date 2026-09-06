<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác Thực Mã OTP</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }
    .card {
        background: #ffffff;
        padding: 35px 40px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 440px;
        text-align: center;
    }
    h2 {
        margin-top: 0;
        margin-bottom: 15px;
        color: #1a73e8;
        font-size: 24px;
    }
    .desc {
        color: #555;
        font-size: 14px;
        line-height: 1.5;
        margin-bottom: 25px;
    }
    .email-highlight {
        font-weight: bold;
        color: #1a73e8;
    }
    .otp-input {
        width: 80%;
        padding: 12px;
        font-size: 28px;
        font-weight: bold;
        letter-spacing: 8px;
        text-align: center;
        border: 2px solid #ccc;
        border-radius: 8px;
        box-sizing: border-box;
    }
    .otp-input:focus {
        border-color: #1a73e8;
        outline: none;
    }
    .btn-submit {
        width: 100%;
        padding: 12px;
        background-color: #28a745;
        border: none;
        border-radius: 6px;
        color: white;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 20px;
    }
    .btn-submit:hover {
        background-color: #218838;
    }
    .alert {
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 20px;
        font-size: 14px;
        text-align: left;
    }
    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    .resend-box {
        margin-top: 25px;
        font-size: 14px;
        color: #666;
    }
    .resend-box a {
        color: #1a73e8;
        text-decoration: none;
        font-weight: 600;
    }
</style>
</head>
<body>

<div class="card">
    <h2>XÁC THỰC MÃ OTP</h2>
    
    <p class="desc">
        Mã OTP kích hoạt tài khoản đã được gửi đến email:<br/>
        <span class="email-highlight">${email != null ? email : sessionScope.otp_email}</span>
    </p>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <input type="hidden" name="email" value="${email != null ? email : sessionScope.otp_email}" />
        
        <div>
            <input type="text" name="otp" class="otp-input" maxlength="6" pattern="\d{6}" placeholder="------" autofocus required />
            <div style="font-size: 12px; color: #888; margin-top: 8px;">(Mã gồm 6 chữ số, hiệu lực trong vòng 5 phút)</div>
        </div>

        <button type="submit" class="btn-submit">KÍCH HOẠT TÀI KHOẢN</button>
    </form>

    <div class="resend-box">
        Không nhận được mã hoặc mã đã hết hạn?<br/>
        <a href="${pageContext.request.contextPath}/resend-otp?email=${email != null ? email : sessionScope.otp_email}">Gửi lại mã OTP mới</a>
    </div>

    <div style="margin-top: 15px;">
        <a href="${pageContext.request.contextPath}/register" style="color: #888; font-size: 13px; text-decoration: none;">&larr; Quay lại trang đăng ký</a>
    </div>
</div>

</body>
</html>