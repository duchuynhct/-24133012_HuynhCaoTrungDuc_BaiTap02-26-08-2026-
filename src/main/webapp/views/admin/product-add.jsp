<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm Sản Phẩm Mới</title>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
    <h3 class="fw-bold text-dark m-0"><i class="bi bi-box-seam text-success me-2"></i>THÊM SẢN PHẨM MỚI</h3>
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
        <form action="${pageContext.request.contextPath}/admin/product/insert" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
            <div class="mb-3">
                <label for="productname" class="form-label fw-bold">Tên sản phẩm (*):</label>
                <input type="text" class="form-control" id="productname" name="productname" required minlength="3" maxlength="200" placeholder="Nhập tên sản phẩm" value="${param.productname}">
                <div class="invalid-feedback">Vui lòng nhập tên sản phẩm (từ 3 đến 200 ký tự).</div>
            </div>

            <div class="mb-3">
                <label for="categoryid" class="form-label fw-bold">Thuộc Danh Mục (*):</label>
                <select class="form-select" id="categoryid" name="categoryid" required>
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.categoryid}" ${param.categoryid == c.categoryid ? 'selected' : ''}>${c.categoryname}</option>
                    </c:forEach>
                </select>
                <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="price" class="form-label fw-bold">Giá bán (VNĐ) (*):</label>
                    <input type="number" class="form-control" id="price" name="price" required min="1000" step="1000" placeholder="50000" value="${param.price}">
                    <div class="invalid-feedback">Giá bán phải là số dương (tối thiểu 1.000 VNĐ).</div>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="quantity" class="form-label fw-bold">Số lượng kho (*):</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" required min="0" step="1" placeholder="10" value="${not empty param.quantity ? param.quantity : '10'}">
                    <div class="invalid-feedback">Số lượng tồn kho phải là số nguyên không âm.</div>
                </div>
            </div>

            <div class="mb-3">
                <label for="images" class="form-label fw-bold">Hình ảnh sản phẩm:</label>
                <input type="file" class="form-control" id="images" name="images" accept="image/*">
                <div class="form-text">Hỗ trợ: JPG, PNG, WEBP (Tối đa 5MB)</div>
            </div>

            <div class="mb-3">
                <label for="status" class="form-label fw-bold">Trạng thái:</label>
                <select class="form-select" id="status" name="status">
                    <option value="1" selected>Hoạt động / Còn hàng</option>
                    <option value="0">Tạm khóa / Hết hàng</option>
                </select>
            </div>

            <div class="mb-4">
                <label for="description" class="form-label fw-bold">Mô tả chi tiết sản phẩm:</label>
                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập thông tin chi tiết về tính năng, thông số sản phẩm...">${param.description}</textarea>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success px-4 fw-semibold">
                    <i class="bi bi-save me-1"></i>Lưu Sản Phẩm
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