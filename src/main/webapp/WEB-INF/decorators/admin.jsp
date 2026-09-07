<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f4f6f9; color: #333; }
        .admin-header { background: #2c3e50; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .admin-header a { color: white; text-decoration: none; font-weight: 600; margin-left: 15px; }
        .admin-nav { background: #34495e; padding: 12px 30px; display: flex; gap: 20px; }
        .admin-nav a { color: #ecf0f1; text-decoration: none; font-weight: 500; font-size: 14px; padding: 6px 12px; border-radius: 4px; transition: background 0.2s; }
        .admin-nav a:hover { background: #1a73e8; color: white; }
        .admin-container { padding: 25px 30px; min-height: 500px; }
        .admin-footer { text-align: center; padding: 20px; color: #7f8c8d; font-size: 13px; margin-top: 40px; border-top: 1px solid #e0e0e0; background: #fff; }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

<div class="admin-header">
    <div style="font-size: 20px; font-weight: bold;">TRANG QUẢN TRỊ HỆ THỐNG</div>
    <div>
        <a href="${pageContext.request.contextPath}/home" target="_blank">🌐 Xem Website</a>
        <a href="${pageContext.request.contextPath}/logout" style="color: #e74c3c;">🚪 Đăng xuất</a>
    </div>
</div>

<div class="admin-nav">
    <a href="${pageContext.request.contextPath}/admin/categories">📁 Quản lý Danh mục</a>
    <a href="${pageContext.request.contextPath}/admin/products">📦 Quản lý Sản phẩm</a>
</div>

<div class="admin-container">
    <sitemesh:write property="body"/>
</div>

<div class="admin-footer">
    &copy; 2026 Admin Dashboard - Huỳnh Cao Trung Đức - MSSV: 24133012
</div>

</body>
</html>

