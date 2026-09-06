<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Nhập Hệ Thống</title>
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
        max-width: 400px;
    }
    h2 {
        margin-top: 0;
        margin-bottom: 25px;
        color: #1a73e8;
        text-align: center;
        font-size: 24px;
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
    .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    .links-box {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
        font-size: 14px;
    }
    .links-box a {
        color: #1a73e8;
        text-decoration: none;
        font-weight: 600;
    }
    .home-link {
        text-align: center;
        margin-top: 15px;
        font-size: 13px;
    }
    .home-link a {
        color: #666;
        text-decoration: none;
    }
</style>
</head>
<body>

<div class="card">
    <h2>ĐĂNG NHẬP</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required value="${param.username}" />
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required />
        </div>

        <button type="submit" class="btn-submit">Đăng Nhập</button>
    </form>

    <div class="links-box">
        <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
        <a href="${pageContext.request.contextPath}/register">Đăng ký mới</a>
    </div>

    <div class="home-link">
        <a href="${pageContext.request.contextPath}/home">&larr; Về trang chủ</a>
    </div>
</div>

</body>
</html>