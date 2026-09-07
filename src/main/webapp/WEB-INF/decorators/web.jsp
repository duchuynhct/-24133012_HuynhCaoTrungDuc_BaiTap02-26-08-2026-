<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; color: #333; }
        .navbar {
            background: #ffffff;
            padding: 12px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .brand { font-size: 22px; font-weight: bold; color: #1a73e8; text-decoration: none; }
        .nav-menu { display: flex; align-items: center; gap: 20px; }
        .nav-menu a { text-decoration: none; color: #555; font-weight: 600; font-size: 15px; transition: color 0.2s; }
        .nav-menu a:hover { color: #1a73e8; }
        .user-nav-box { display: flex; align-items: center; gap: 10px; background: #e8f0fe; padding: 4px 14px; border-radius: 20px; text-decoration: none; }
        .nav-avatar { width: 32px; height: 32px; border-radius: 50%; object-fit: cover; border: 1.5px solid #1a73e8; }
        .nav-username { color: #1a73e8; font-weight: 600; font-size: 14px; }
        .footer { background: #263238; color: #cfd8dc; text-align: center; padding: 25px; margin-top: 50px; font-size: 14px; }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="brand">SHOP ONLINE</a>
    <div class="nav-menu">
        <a href="${pageContext.request.contextPath}/home">Trang Chủ</a>
        <a href="${pageContext.request.contextPath}/product">Sản Phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/products">Trang Quản Trị</a>

        <c:choose>
            <c:when test="${not empty sessionScope.account}">
                <a href="${pageContext.request.contextPath}/profile" class="user-nav-box" title="Xem hồ sơ cá nhân">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account.images}">
                            <img src="${pageContext.request.contextPath}/uploads/${sessionScope.account.images}" 
                                 class="nav-avatar" alt="Avatar"
                                 onerror="this.onerror=null;this.src='https://placehold.co/32x32?text=U';"/>
                        </c:when>
                        <c:otherwise>
                            <img src="https://placehold.co/32x32?text=U" class="nav-avatar" alt="Avatar"/>
                        </c:otherwise>
                    </c:choose>
                    <span class="nav-username">${sessionScope.account.fullname}</span>
                </a>
                <a href="${pageContext.request.contextPath}/profile" style="color: #1a73e8;">Hồ sơ</a>
                <a href="${pageContext.request.contextPath}/logout" style="color: #dc3545;">Đăng xuất</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Nội dung động của từng trang JSP cụ thể được SiteMesh chèn vào đây -->
<sitemesh:write property="body"/>

<div class="footer">
    &copy; 2026 Bài Tập Lập Trình Web - Sinh viên: Huỳnh Cao Trung Đức - MSSV: 24133012
</div>

</body>
</html>

