<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/> - Cửa Hàng Trực Tuyến</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body { min-height: 100vh; display: flex; flex-direction: column; background-color: #f8f9fa; }
        .main-content { flex: 1 0 auto; }
        .navbar-brand { font-weight: 700; letter-spacing: 0.5px; }
        .nav-avatar-img { width: 34px; height: 34px; object-fit: cover; border-radius: 50%; border: 2px solid #0d6efd; }
        footer { flex-shrink: 0; background-color: #212529; color: #adb5bd; }
        .hover-shadow { transition: transform 0.2s, box-shadow 0.2s; }
        .hover-shadow:hover { transform: translateY(-4px); box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important; }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

<!-- Header / Navigation Bar Bootstrap -->
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-shop fs-3 text-primary"></i>
                <span class="text-white">SHOP<span class="text-primary">ONLINE</span></span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarMain">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door me-1"></i>Trang Chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/product"><i class="bi bi-grid me-1"></i>Sản Phẩm</a>
                    </li>
                    <c:if test="${not empty sessionScope.account && sessionScope.account.roleid == 1}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/products">
                                <i class="bi bi-speedometer2 me-1"></i>Trang Quản Trị
                            </a>
                        </li>
                    </c:if>
                </ul>

                <!-- User Session Menu -->
                <div class="d-flex align-items-center gap-2">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <div class="dropdown">
                                <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle gap-2 py-1 px-2 rounded" data-bs-toggle="dropdown" aria-expanded="false">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.account.images}">
                                            <img src="${pageContext.request.contextPath}/uploads/${sessionScope.account.images}" class="nav-avatar-img" alt="Avatar" onerror="this.onerror=null;this.src='https://placehold.co/34x34?text=U';"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://placehold.co/34x34?text=U" class="nav-avatar-img" alt="Avatar"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="fw-semibold">${sessionScope.account.fullname}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <li><h6 class="dropdown-header">Xin chào, ${sessionScope.account.username}!</h6></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="bi bi-person-circle me-2"></i>Hồ Sơ Cá Nhân</a></li>
                                    <c:if test="${sessionScope.account.roleid == 1}">
                                        <li><a class="dropdown-item text-primary" href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-gear-fill me-2"></i>Khu Vực Admin</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng Xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm me-1"><i class="bi bi-box-arrow-in-right me-1"></i>Đăng Nhập</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm"><i class="bi bi-person-plus me-1"></i>Đăng Ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>

<!-- Main Body Injected by SiteMesh -->
<main class="main-content container my-4">
    <sitemesh:write property="body"/>
</main>

<!-- Footer Bootstrap -->
<footer class="py-4 mt-auto">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-6">
                <h5 class="text-white"><i class="bi bi-shop text-primary me-2"></i>Cửa Hàng Trực Tuyến</h5>
                <p class="small">Hệ thống ứng dụng thương mại điện tử xây dựng trên nền tảng Jakarta Servlet 6.0, JPA Hibernate & SiteMesh Decorator 3.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <h6 class="text-white">Thông Tin Sinh Viên</h6>
                <p class="small mb-1">Họ tên: <strong>Huỳnh Cao Trung Đức</strong></p>
                <p class="small mb-1">MSSV: <strong>24133012</strong></p>
                <p class="small text-muted">&copy; 2026 Bản quyền thuộc về đồ án môn Lập Trình Web.</p>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
    'use strict';
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();
</script>
</body>
</html>
