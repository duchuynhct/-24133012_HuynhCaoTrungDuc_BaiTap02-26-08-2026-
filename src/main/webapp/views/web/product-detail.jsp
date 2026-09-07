<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi Tiết Sản Phẩm - ${product != null ? product.productName : 'Không tìm thấy'}</title>
</head>
<body>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product" class="text-decoration-none">Sản Phẩm</a></li>
        <li class="breadcrumb-item active" aria-current="page">${product != null ? product.productName : 'Chi tiết'}</li>
    </ol>
</nav>

<c:choose>
    <c:when test="${not empty product}">
        <div class="card shadow-sm border-0 rounded-3 p-4 bg-white">
            <div class="row g-4">
                <!-- Product Image Column -->
                <div class="col-md-5 d-flex align-items-center justify-content-center bg-light rounded-3 p-3">
                    <c:choose>
                        <c:when test="${not empty product.images}">
                            <img src="${pageContext.request.contextPath}/uploads/${product.images}" class="img-fluid rounded object-fit-contain" style="max-height: 380px;" alt="${product.productName}"
                                 onerror="this.onerror=null;this.src='https://placehold.co/400x350?text=San+Pham';" />
                        </c:when>
                        <c:otherwise>
                            <img src="https://placehold.co/400x350?text=San+Pham" class="img-fluid rounded object-fit-contain" style="max-height: 380px;" alt="${product.productName}" />
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Product Details Column -->
                <div class="col-md-7 d-flex flex-column">
                    <span class="badge bg-primary-subtle text-primary align-self-start py-1 px-3 mb-2 fs-6">
                        <i class="bi bi-tag-fill me-1"></i>${product.category != null ? product.category.categoryname : 'Chưa phân loại'}
                    </span>
                    <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>
                    <h3 class="text-danger fw-bold mb-4">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </h3>

                    <ul class="list-group list-group-flush mb-4">
                        <li class="list-group-item px-0 d-flex justify-content-between">
                            <span class="text-muted">Mã sản phẩm:</span>
                            <span class="fw-semibold">#${product.productId}</span>
                        </li>
                        <li class="list-group-item px-0 d-flex justify-content-between">
                            <span class="text-muted">Danh mục:</span>
                            <span class="fw-semibold">${product.category != null ? product.category.categoryname : 'N/A'}</span>
                        </li>
                        <li class="list-group-item px-0 d-flex justify-content-between">
                            <span class="text-muted">Tồn kho:</span>
                            <span class="fw-semibold">${product.quantity} sản phẩm</span>
                        </li>
                        <li class="list-group-item px-0 d-flex justify-content-between">
                            <span class="text-muted">Trạng thái:</span>
                            <span class="badge ${product.status == 1 ? 'bg-success' : 'bg-danger'}">
                                ${product.status == 1 ? 'Còn hàng / Đang kinh doanh' : 'Tạm khóa / Hết hàng'}
                            </span>
                        </li>
                    </ul>

                    <div class="mb-4">
                        <h5 class="fw-bold text-dark border-bottom pb-2">Mô Tả Sản Phẩm</h5>
                        <p class="text-secondary mb-0" style="white-space: pre-line;">
                            ${not empty product.description ? product.description : 'Sản phẩm chính hãng với chất lượng đảm bảo và bảo hành uy tín.'}
                        </p>
                    </div>

                    <div class="mt-auto d-flex gap-2">
                        <button class="btn btn-danger btn-lg px-4 fw-bold" onclick="alert('Đã thêm sản phẩm vào giỏ hàng thành công!')">
                            <i class="bi bi-cart-plus me-2"></i>MUA NGAY
                        </button>
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary btn-lg px-3">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="text-center py-5 bg-white rounded-3 shadow-sm border">
            <i class="bi bi-exclamation-triangle text-danger fs-1"></i>
            <h3 class="text-danger mt-3">Không tìm thấy sản phẩm!</h3>
            <p class="text-muted">Sản phẩm này không tồn tại hoặc đã bị xóa khỏi hệ thống.</p>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-primary mt-2">
                <i class="bi bi-arrow-left me-1"></i>Về trang danh sách sản phẩm
            </a>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>