<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Danh Sách Sản Phẩm (Phân trang 6 sp/trang)</title>
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
    .container { max-width: 1200px; margin: 35px auto; padding: 0 20px; }
    .page-header {
        margin-bottom: 25px;
        border-bottom: 2px solid #e0e0e0;
        padding-bottom: 12px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .page-header h2 { margin: 0; color: #2c3e50; font-size: 24px; }
    .page-header span { color: #666; font-size: 14px; }
    .product-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 25px;
    }
    @media (max-width: 900px) {
        .product-grid { grid-template-columns: repeat(2, 1fr); }
    }
    @media (max-width: 600px) {
        .product-grid { grid-template-columns: 1fr; }
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
        height: 220px;
        background: #f0f0f0;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }
    .product-img { width: 100%; height: 100%; object-fit: cover; }
    .product-body { padding: 18px; flex: 1; display: flex; flex-direction: column; }
    .badge {
        display: inline-block;
        background: #e3f2fd;
        color: #1976d2;
        font-size: 12px;
        font-weight: bold;
        padding: 3px 8px;
        border-radius: 4px;
        margin-bottom: 8px;
        align-self: flex-start;
    }
    .product-name {
        font-size: 17px;
        font-weight: 600;
        margin: 0 0 10px 0;
        color: #333;
        line-height: 1.3;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        min-height: 44px;
    }
    .product-price {
        font-size: 20px;
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
        padding: 10px;
        border-radius: 4px;
        font-weight: 600;
        font-size: 14px;
        transition: background 0.2s;
    }
    .btn-detail:hover { background: #1557b0; }
    
    /* Pagination styling */
    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin: 40px 0 20px 0;
    }
    .page-btn {
        padding: 8px 16px;
        border: 1px solid #ccc;
        background: white;
        color: #333;
        text-decoration: none;
        border-radius: 4px;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.2s;
    }
    .page-btn:hover {
        background: #f0f0f0;
        border-color: #999;
    }
    .page-btn.active {
        background: #1a73e8;
        color: white;
        border-color: #1a73e8;
    }
    .page-btn.disabled {
        opacity: 0.5;
        pointer-events: none;
    }
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

<div class="container">
    <div class="page-header">
        <h2>📦 TẤT CẢ SẢN PHẨM</h2>
        <span>Hiển thị 6 sản phẩm/trang | Tổng: <strong>${totalProducts}</strong> sản phẩm</span>
    </div>

    <div class="product-grid">
        <c:forEach items="${listProducts}" var="p">
            <div class="product-card">
                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                    <div class="product-img-wrap">
                        <c:choose>
                            <c:when test="${not empty p.images}">
                                <img src="${pageContext.request.contextPath}/uploads/${p.images}" class="product-img" alt="${p.productName}"
                                     onerror="this.onerror=null;this.src='https://placehold.co/300x220?text=San+Pham';" />
                            </c:when>
                            <c:otherwise>
                                <img src="https://placehold.co/300x220?text=San+Pham" class="product-img" alt="${p.productName}" />
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

    <c:if test="${empty listProducts}">
        <div style="text-align: center; padding: 40px; color: #888;">
            <p>Không có sản phẩm nào trên trang này.</p>
        </div>
    </c:if>

    <!-- Phân trang 6 sp / trang -->
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}" 
               class="page-btn ${currentPage <= 1 ? 'disabled' : ''}">&laquo; Trước</a>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="${pageContext.request.contextPath}/product?page=${i}" 
                   class="page-btn ${currentPage == i ? 'active' : ''}">${i}</a>
            </c:forEach>

            <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}" 
               class="page-btn ${currentPage >= totalPages ? 'disabled' : ''}">Sau &raquo;</a>
        </div>
    </c:if>
</div>

</body>
</html>