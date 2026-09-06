<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên Mật Khẩu</title>
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
        max-width: 420px;
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
    .form-group {
        margin-bottom: 18px;
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
    .btn-submit {
        width: 100%;
        padding: 12px;
        background-color: #1a73e8;
        border: none;
        border-radius: 6px;
        color: white;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
    }
    .btn-submit:hover {
        background-color: #1557b0;
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
    <h2>QUÊN MẬT KHẨU</h2>
    <p class="sub-text">Nhập địa chỉ email đăng ký tài khoản của bạn để nhận mã OTP xác thực khôi phục mật khẩu.</p>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="form-group">
            <label for="email">Email tài khoản:</label>
            <input type="email" id="email" name="email" placeholder="example@gmail.com" required value="${param.email}" />
        </div>

        <button type="submit" class="btn-submit">Gửi Mã OTP Xác Nhận</button>
    </form>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/login">&larr; Quay lại trang đăng nhập</a>
    </div>
</div>

</body>
</html>