<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cập Nhật Danh Mục</title>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
    <h3 class="fw-bold text-dark m-0"><i class="bi bi-pencil-square text-primary me-2"></i>CẬP NHẬT DANH MỤC</h3>
    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary btn-sm">
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
    <div class="col-md-8 col-lg-6">
        <form action="${pageContext.request.contextPath}/admin/category/update" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
            <input type="hidden" name="categoryid" value="${cate.categoryid}">
            <input type="hidden" name="oldImage" value="${cate.images}">

            <div class="mb-3">
                <label for="categoryname" class="form-label fw-bold">Tên danh mục (*):</label>
                <input type="text" class="form-control" id="categoryname" name="categoryname" value="${cate.categoryname}" required minlength="2" maxlength="100">
                <div class="invalid-feedback">Vui lòng nhập tên danh mục (từ 2 đến 100 ký tự).</div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold d-block">Hình ảnh hiện tại:</label>
                <c:choose>
                    <c:when test="${not empty cate.images}">
                        <img src="${pageContext.request.contextPath}/uploads/${cate.images}" class="rounded object-fit-cover shadow-sm mb-2" style="width: 100px; height: 75px;" alt="Current Image">
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-light text-secondary border mb-2 d-inline-block">Chưa có ảnh</span>
                    </c:otherwise>
                </c:choose>
                <br>
                <label for="images" class="form-label fw-bold">Chọn ảnh mới (nếu muốn thay đổi):</label>
                <input type="file" class="form-control" id="images" name="images" accept="image/*">
            </div>

            <div class="mb-4">
                <label for="status" class="form-label fw-bold">Trạng thái:</label>
                <select class="form-select" id="status" name="status">
                    <option value="1" ${cate.status == 1 ? "selected" : ""}>Hoạt động</option>
                    <option value="0" ${cate.status == 0 ? "selected" : ""}>Khóa</option>
                </select>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4 fw-semibold">
                    <i class="bi bi-check2 me-1"></i>Cập Nhật Danh Mục
                </button>
                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary px-3">
                    Hủy bỏ
                </a>
            </div>
        </form>
    </div>
</div>

</body>
</html>