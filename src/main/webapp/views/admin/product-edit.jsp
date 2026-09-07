<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh Sửa Sản Phẩm</title>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
    <h3 class="fw-bold text-dark m-0"><i class="bi bi-pencil-square text-primary me-2"></i>CẬP NHẬT SẢN PHẨM</h3>
    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
    </a>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<div class="row">
    <div class="col-lg-8">
        <form action="${pageContext.request.contextPath}/admin/product/update" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
            <input type="hidden" name="productid" value="${product.productId}" />
            <input type="hidden" name="oldImage" value="${product.images}" />

            <div class="mb-3">
                <label for="productname" class="form-label fw-bold">Tên sản phẩm (*):</label>
                <input type="text" class="form-control" id="productname" name="productname" required minlength="3" maxlength="200" value="${product.productName}">
                <div class="invalid-feedback">Vui lòng nhập tên sản phẩm (từ 3 đến 200 ký tự).</div>
            </div>

            <div class="mb-3">
                <label for="categoryid" class="form-label fw-bold">Thuộc Danh Mục (*):</label>
                <select class="form-select" id="categoryid" name="categoryid" required>
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.categoryid}" ${product.category != null && product.category.categoryid == c.categoryid ? 'selected' : ''}>
                            ${c.categoryname}
                        </option>
                    </c:forEach>
                </select>
                <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="price" class="form-label fw-bold">Giá bán (VNĐ) (*):</label>
                    <input type="number" class="form-control" id="price" name="price" required min="1000" step="1000" value="${product.price}">
                    <div class="invalid-feedback">Giá bán phải là số dương (tối thiểu 1.000 VNĐ).</div>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="quantity" class="form-label fw-bold">Số lượng kho (*):</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" required min="0" step="1" value="${product.quantity}">
                    <div class="invalid-feedback">Số lượng tồn kho phải là số nguyên không âm.</div>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold d-block">Hình ảnh hiện tại:</label>
                <c:choose>
                    <c:when test="${not empty product.images}">
                        <img src="${pageContext.request.contextPath}/uploads/${product.images}" class="rounded object-fit-cover shadow-sm mb-2" style="width: 100px; height: 80px;" alt="Ảnh hiện tại" />
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-light text-secondary border mb-2 d-inline-block">Chưa có ảnh</span>
                    </c:otherwise>
                </c:choose>
                <br>
                <label for="images" class="form-label fw-bold">Chọn ảnh mới (nếu muốn thay đổi):</label>
                <input type="file" class="form-control" id="images" name="images" accept="image/*">
                <div class="form-text">Hỗ trợ: JPG, PNG, WEBP (Tối đa 5MB)</div>
            </div>

            <div class="mb-3">
                <label for="status" class="form-label fw-bold">Trạng thái:</label>
                <select class="form-select" id="status" name="status">
                    <option value="1" ${product.status == 1 ? 'selected' : ''}>Hoạt động / Còn hàng</option>
                    <option value="0" ${product.status == 0 ? 'selected' : ''}>Tạm khóa / Hết hàng</option>
                </select>
            </div>

            <div class="mb-4">
                <label for="description" class="form-label fw-bold">Mô tả chi tiết sản phẩm:</label>
                <textarea class="form-control" id="description" name="description" rows="4">${product.description}</textarea>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4 fw-semibold">
                    <i class="bi bi-check2 me-1"></i>Cập Nhật Sản Phẩm
                </button>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary px-3">
                    Hủy bỏ
                </a>
            </div>
        </form>
    </div>
</div>

</body>
</html>