<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt Lại Mật Khẩu</title>
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
    }
    h2 {
        margin-top: 0;
        margin-bottom: 12px;
        color: #1a73e8;
        text-align: center;
        font-size: 24px;
    }
    .sub-text {
        font-size: 14px;
        color: #666;
        text-align: center;
        margin-bottom: 25px;
        line-height: 1.4;
    }
    .email-highlight {
        font-weight: bold;
        color: #1a73e8;
    }
    .form-group {
        margin-bottom: 16px;
    }
    .form-group label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        color: #333;
        font-size: 14px;
    }
    .form-group input {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
        box-sizing: border-box;
    }
    .form-group input:focus {
        border-color: #1a73e8;
        outline: none;
    }
    .otp-input {
        font-size: 20px;
        font-weight: bold;
        letter-spacing: 5px;
        text-align: center;
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
        margin-top: 10px;
    }
    .btn-submit:hover {
        background-color: #218838;
    }
    .alert {
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 20px;
        font-size: 14px;
    }
    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    .back-link {
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
    }
    .back-link a {
        color: #1a73e8;
        text-decoration: none;
        font-weight: 600;
    }
</style>
</head>
<body>

<div class="card">
    <h2>ĐẶT LẠI MẬT KHẨU</h2>
    <p class="sub-text">
        Mã OTP đã được gửi đến email: <br/>
        <span class="email-highlight">${email != null ? email : sessionScope.reset_email}</span>
    </p>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <input type="hidden" name="email" value="${email != null ? email : sessionScope.reset_email}" />

        <div class="form-group">
            <label for="otp">Mã OTP (6 chữ số):</label>
            <input type="text" id="otp" name="otp" class="otp-input" maxlength="6" pattern="\d{6}" placeholder="------" required autofocus />
        </div>

        <div class="form-group">
            <label for="newPassword">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required />
        </div>

        <div class="form-group">
            <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required />
        </div>

        <button type="submit" class="btn-submit">Xác Nhận Đổi Mật Khẩu</button>
    </form>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/forgot-password">&larr; Gửi lại mã OTP</a> | <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </div>
</div>

</body>
</html>