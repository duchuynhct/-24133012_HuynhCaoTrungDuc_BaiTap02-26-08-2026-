<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang Chủ - Cửa Hàng Trực Tuyến</title>
<style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; color: #333; }
    .navbar {
        background: #ffffff;
        padding: 15px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        position: sticky;
        top: 0;
        z-index: 100;
    }
    .brand { font-size: 22px; font-weight: bold; color: #1a73e8; text-decoration: none; }
    .nav-menu a {
        margin-left: 20px;
        text-decoration: none;
        color: #555;
        font-weight: 600;
        font-size: 15px;
        transition: color 0.2s;
    }
    .nav-menu a:hover, .nav-menu a.active { color: #1a73e8; }
    .hero {
        background: linear-gradient(135deg, #1a73e8 0%, #0d47a1 100%);
        color: white;
        text-align: center;
        padding: 50px 20px;
    }
    .hero h1 { margin: 0 0 10px 0; font-size: 36px; }
    .hero p { margin: 0; font-size: 18px; opacity: 0.9; }
    .container { max-width: 1200px; margin: 35px auto; padding: 0 20px; }
    .section-title {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        border-bottom: 2px solid #e0e0e0;
        padding-bottom: 10px;
    }
    .section-title h2 { margin: 0; font-size: 24px; color: #2c3e50; }
    .section-title a { color: #1a73e8; text-decoration: none; font-weight: 600; font-size: 15px; }
    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap: 25px;
    }
    .product-card {
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        transition: transform 0.2s, box-shadow 0.2s;
        display: flex;
        flex-direction: column;
    }
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 16px rgba(0,0,0,0.12);
    }
    .product-card a { text-decoration: none; color: inherit; }
    .product-img-wrap {
        width: 100%;
        height: 180px;
        background: #f0f0f0;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }
    .product-img { width: 100%; height: 100%; object-fit: cover; }
    .product-body { padding: 15px; flex: 1; display: flex; flex-direction: column; }
    .badge {
        display: inline-block;
        background: #e3f2fd;
        color: #1976d2;
        font-size: 11px;
        font-weight: bold;
        padding: 3px 8px;
        border-radius: 4px;
        margin-bottom: 8px;
        align-self: flex-start;
    }
    .product-name {
        font-size: 16px;
        font-weight: 600;
        margin: 0 0 10px 0;
        color: #333;
        line-height: 1.3;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        min-height: 40px;
    }
    .product-price {
        font-size: 18px;
        font-weight: bold;
        color: #e53935;
        margin-top: auto;
        margin-bottom: 12px;
    }
    .btn-detail {
        display: block;
        text-align: center;
        background: #1a73e8;
        color: white;
        padding: 8px;
        border-radius: 4px;
        font-weight: 600;
        font-size: 14px;
        transition: background 0.2s;
    }
    .btn-detail:hover { background: #1557b0; }
    .footer {
        background: #263238;
        color: #cfd8dc;
        text-align: center;
        padding: 25px;
        margin-top: 50px;
        font-size: 14px;
    }
</style>
</head>
<body>

<div class="hero">
    <h1>CHÀO MỪNG ĐẾN VỚI HỆ THỐNG CỬA HÀNG</h1>
    <p>Khám phá các sản phẩm công nghệ và phụ kiện mới nhất với giá tốt nhất</p>
</div>

<div class="container">
    <div class="section-title">
        <h2>🔥 10 SẢN PHẨM MỚI NHẤT</h2>
        <a href="${pageContext.request.contextPath}/product">Xem tất cả sản phẩm &rarr;</a>
    </div>

    <div class="product-grid">
        <c:forEach items="${top10Products}" var="p">
            <div class="product-card">
                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                    <div class="product-img-wrap">
                        <c:choose>
                            <c:when test="${not empty p.images}">
                                <img src="${pageContext.request.contextPath}/uploads/${p.images}" class="product-img" alt="${p.productName}"
                                     onerror="this.onerror=null;this.src='https://placehold.co/220x180?text=San+Pham';" />
                            </c:when>
                            <c:otherwise>
                                <img src="https://placehold.co/220x180?text=San+Pham" class="product-img" alt="${p.productName}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </a>
                <div class="product-body">
                    <span class="badge">${p.category != null ? p.category.categoryname : 'Sản phẩm'}</span>
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                        <h3 class="product-name" title="${p.productName}">${p.productName}</h3>
                    </a>
                    <div class="product-price">
                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                    </div>
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn-detail">Xem chi tiết</a>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty top10Products}">
        <div style="text-align: center; padding: 40px; color: #888;">
            <p>Hiện chưa có sản phẩm nào trong hệ thống.</p>
            <a href="${pageContext.request.contextPath}/admin/product/add" style="color: #1a73e8; font-weight: 600;">+ Thêm sản phẩm ngay tại trang Quản trị</a>
        </div>
    </c:if>
</div>

</body>
</html>