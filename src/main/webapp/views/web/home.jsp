<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ - Cửa Hàng Trực Tuyến</title>
</head>
<body>

<!-- Hero Banner Bootstrap -->
<div class="p-5 mb-4 bg-primary text-white rounded-4 shadow-sm" style="background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);">
    <div class="container-fluid py-3 text-center">
        <h1 class="display-5 fw-bold"><i class="bi bi-stars text-warning me-2"></i>Chào Mừng Đến Với Shop Online</h1>
        <p class="col-md-8 fs-5 mx-auto opacity-75">Khám phá các sản phẩm công nghệ, danh mục phong phú và phụ kiện mới nhất với giá tốt nhất hôm nay.</p>
        <div class="d-flex justify-content-center gap-2 mt-3">
            <a href="${pageContext.request.contextPath}/product" class="btn btn-light btn-lg px-4 fw-semibold text-primary">
                <i class="bi bi-bag-fill me-1"></i>Xem Tất Cả Sản Phẩm
            </a>
        </div>
    </div>
</div>

<!-- Section Header -->
<div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
    <h3 class="fw-bold text-dark m-0"><i class="bi bi-fire text-danger me-2"></i>Top 10 Sản Phẩm Mới Nhất</h3>
    <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary btn-sm fw-semibold">
        Xem tất cả <i class="bi bi-arrow-right ms-1"></i>
    </a>
</div>

<!-- Product Cards Grid Bootstrap -->
<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
    <c:forEach items="${top10Products}" var="p">
        <div class="col">
            <div class="card h-100 shadow-sm border-0 rounded-3 hover-shadow transition">
                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none">
                    <div class="bg-light d-flex align-items-center justify-content-center p-3 rounded-top" style="height: 200px;">
                        <c:choose>
                            <c:when test="${not empty p.images}">
                                <img src="${pageContext.request.contextPath}/uploads/${p.images}" class="img-fluid object-fit-contain" style="max-height: 180px;" alt="${p.productName}"
                                     onerror="this.onerror=null;this.src='https://placehold.co/250x180?text=San+Pham';" />
                            </c:when>
                            <c:otherwise>
                                <img src="https://placehold.co/250x180?text=San+Pham" class="img-fluid object-fit-contain" style="max-height: 180px;" alt="${p.productName}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </a>
                <div class="card-body d-flex flex-column">
                    <span class="badge bg-primary-subtle text-primary mb-2 align-self-start py-1 px-2">
                        <i class="bi bi-tag-fill me-1"></i>${p.category != null ? p.category.categoryname : 'Sản phẩm'}
                    </span>
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none text-dark">
                        <h6 class="card-title fw-bold text-truncate" title="${p.productName}">${p.productName}</h6>
                    </a>
                    <div class="mt-auto pt-2 d-flex justify-content-between align-items-center">
                        <span class="text-danger fw-bold fs-5">
                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                        </span>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm btn-outline-primary fw-semibold">
                            Chi tiết
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<c:if test="${empty top10Products}">
    <div class="text-center py-5 bg-white rounded-3 shadow-sm border">
        <i class="bi bi-inbox fs-1 text-muted"></i>
        <p class="text-muted mt-2">Hiện chưa có sản phẩm nào trong hệ thống.</p>
        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary btn-sm">
            <i class="bi bi-plus-circle me-1"></i>Thêm sản phẩm ngay tại trang Quản trị
        </a>
    </div>
</c:if>

</body>
</html>