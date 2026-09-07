<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Sản phẩm (Admin)</title>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
    <h3 class="fw-bold text-dark m-0"><i class="bi bi-box-seam-fill text-info me-2"></i>QUẢN LÝ SẢN PHẨM</h3>
    <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-success btn-sm fw-semibold">
        <i class="bi bi-plus-circle me-1"></i>Thêm sản phẩm mới
    </a>
</div>

<div class="table-responsive">
    <table class="table table-hover table-bordered table-striped align-middle shadow-sm">
        <thead class="table-dark">
            <tr>
                <th style="width: 70px;" class="text-center">ID</th>
                <th style="width: 100px;" class="text-center">Hình Ảnh</th>
                <th>Tên Sản Phẩm</th>
                <th style="width: 140px;">Danh Mục</th>
                <th style="width: 130px;" class="text-end">Giá Bán</th>
                <th style="width: 100px;" class="text-center">Kho</th>
                <th style="width: 140px;" class="text-center">Trạng Thái</th>
                <th style="width: 170px;" class="text-center">Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listProducts}" var="p">
                <tr>
                    <td class="text-center fw-bold">#${p.productId}</td>
                    <td class="text-center">
                        <c:choose>
                            <c:when test="${not empty p.images}">
                                <img src="${pageContext.request.contextPath}/uploads/${p.images}" class="rounded object-fit-cover shadow-sm" style="width: 70px; height: 60px;" alt="${p.productName}" 
                                     onerror="this.onerror=null;this.src='https://placehold.co/70x60?text=No+Img';">
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-light text-secondary border">Chưa có ảnh</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><strong class="text-dark">${p.productName}</strong></td>
                    <td>
                        <span class="badge bg-info-subtle text-info border">
                            ${p.category != null ? p.category.categoryname : 'N/A'}
                        </span>
                    </td>
                    <td class="text-end fw-bold text-danger">
                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </td>
                    <td class="text-center fw-semibold">${p.quantity}</td>
                    <td class="text-center">
                        <span class="badge ${p.status == 1 ? 'bg-success' : 'bg-secondary'}">
                            ${p.status == 1 ? 'Còn hàng' : 'Tạm ngưng'}
                        </span>
                    </td>
                    <td class="text-center">
                        <div class="btn-group btn-group-sm">
                            <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}" class="btn btn-outline-primary">
                                <i class="bi bi-pencil-square me-1"></i>Sửa
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.productId}" class="btn btn-outline-danger" onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?')">
                                <i class="bi bi-trash me-1"></i>Xóa
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty listProducts}">
                <tr>
                    <td colspan="8" class="text-center py-4 text-muted">
                        Chưa có sản phẩm nào. Hãy bấm nút "+ Thêm sản phẩm mới" ở trên!
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

</body>
</html>