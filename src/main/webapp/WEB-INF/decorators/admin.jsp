<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/> - Quản Trị Hệ Thống</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; min-height: 100vh; display: flex; flex-direction: column; }
        .admin-sidebar { min-height: calc(100vh - 56px); background-color: #212529; }
        .admin-sidebar .nav-link { color: #adb5bd; padding: 12px 20px; font-weight: 500; border-radius: 6px; margin: 4px 10px; transition: all 0.2s; }
        .admin-sidebar .nav-link:hover, .admin-sidebar .nav-link.active { color: #fff; background-color: #0d6efd; }
        .admin-content { flex: 1; }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

<!-- Admin Topbar -->
<nav class="navbar navbar-dark bg-dark sticky-top px-3 shadow">
    <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/admin/products">
        <i class="bi bi-shield-lock-fill text-warning fs-4"></i>
        <span>BẢNG QUẢN TRỊ ADMIN</span>
    </a>
    <div class="d-flex align-items-center gap-3">
        <a href="${pageContext.request.contextPath}/home" target="_blank" class="btn btn-outline-info btn-sm">
            <i class="bi bi-globe me-1"></i>Xem Website
        </a>
        <span class="text-white-50 small d-none d-md-inline">Xin chào, <strong class="text-white">${sessionScope.account.fullname}</strong></span>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">
            <i class="bi bi-box-arrow-right me-1"></i>Đăng Xuất
        </a>
    </div>
</nav>

<!-- Admin Layout Body (Sidebar + Content) -->
<div class="container-fluid flex-grow-1">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block admin-sidebar py-3">
            <div class="text-secondary small fw-bold px-3 mb-2 text-uppercase">Menu Quản Trị</div>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                        <i class="bi bi-folder-fill me-2 text-warning"></i>Quản lý Danh mục
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/products">
                        <i class="bi bi-box-seam-fill me-2 text-info"></i>Quản lý Sản phẩm
                    </a>
                </li>
                <li class="nav-item mt-3">
                    <hr class="text-secondary my-2">
                    <div class="text-secondary small fw-bold px-3 mb-2 text-uppercase">Tài Khoản</div>
                    <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                        <i class="bi bi-person-lines-fill me-2 text-success"></i>Hồ sơ Cá nhân
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main Content Area -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 admin-content">
            <div class="card shadow-sm border-0 p-4 bg-white rounded-3">
                <sitemesh:write property="body"/>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
