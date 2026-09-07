<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh Sách Sản Phẩm</title>
</head>
<body>

<div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
    <h3 class="fw-bold text-dark m-0"><i class="bi bi-box-seam text-primary me-2"></i>TẤT CẢ SẢN PHẨM</h3>
    <span class="text-muted small">Hiển thị 6 sản phẩm/trang | Tổng cộng: <span class="badge bg-primary">${totalProducts}</span> sản phẩm</span>
</div>

<!-- Product Cards Grid Bootstrap -->
<div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 g-4">
    <c:forEach items="${listProducts}" var="p">
        <div class="col">
            <div class="card h-100 shadow-sm border-0 rounded-3 hover-shadow transition">
                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none">
                    <div class="bg-light d-flex align-items-center justify-content-center p-3 rounded-top" style="height: 220px;">
                        <c:choose>
                            <c:when test="${not empty p.images}">
                                <img src="${pageContext.request.contextPath}/uploads/${p.images}" class="img-fluid object-fit-contain" style="max-height: 200px;" alt="${p.productName}"
                                     onerror="this.onerror=null;this.src='https://placehold.co/300x220?text=San+Pham';" />
                            </c:when>
                            <c:otherwise>
                                <img src="https://placehold.co/300x220?text=San+Pham" class="img-fluid object-fit-contain" style="max-height: 200px;" alt="${p.productName}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </a>
                <div class="card-body d-flex flex-column">
                    <span class="badge bg-primary-subtle text-primary mb-2 align-self-start py-1 px-2">
                        <i class="bi bi-tag-fill me-1"></i>${p.category != null ? p.category.categoryname : 'Sản phẩm'}
                    </span>
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none text-dark">
                        <h5 class="card-title fw-bold text-truncate" title="${p.productName}">${p.productName}</h5>
                    </a>
                    <div class="mt-auto pt-2 d-flex justify-content-between align-items-center">
                        <span class="text-danger fw-bold fs-5">
                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                        </span>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm btn-outline-primary fw-semibold">
                            Xem chi tiết
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<c:if test="${empty listProducts}">
    <div class="text-center py-5 bg-white rounded-3 shadow-sm border">
        <i class="bi bi-search fs-1 text-muted"></i>
        <p class="text-muted mt-2">Không tìm thấy sản phẩm nào trên trang này.</p>
    </div>
</c:if>

<!-- Phân trang Bootstrap -->
<c:if test="${totalPages > 1}">
    <nav class="mt-5" aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage - 1}" tabindex="-1">
                    <i class="bi bi-chevron-left"></i> Trước
                </a>
            </li>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                </li>
            </c:forEach>

            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">
                    Sau <i class="bi bi-chevron-right"></i>
                </a>
            </li>
        </ul>
    </nav>
</c:if>

</body>
</html>