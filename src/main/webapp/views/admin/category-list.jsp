<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Danh mục</title>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
    <h3 class="fw-bold text-dark m-0"><i class="bi bi-folder-fill text-warning me-2"></i>QUẢN LÝ DANH MỤC</h3>
    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success btn-sm fw-semibold">
        <i class="bi bi-plus-circle me-1"></i>Thêm danh mục mới
    </a>
</div>

<div class="table-responsive">
    <table class="table table-hover table-bordered table-striped align-middle shadow-sm">
        <thead class="table-dark">
            <tr>
                <th style="width: 80px;" class="text-center">ID</th>
                <th style="width: 120px;" class="text-center">Hình Ảnh</th>
                <th>Tên Danh Mục</th>
                <th style="width: 150px;" class="text-center">Trạng Thái</th>
                <th style="width: 180px;" class="text-center">Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listcate}" var="item">
                <tr>
                    <td class="text-center fw-bold">#${item.categoryid}</td>
                    <td class="text-center">
                        <c:choose>
                            <c:when test="${not empty item.images}">
                                <img src="${pageContext.request.contextPath}/uploads/${item.images}" class="rounded object-fit-cover shadow-sm" style="width: 70px; height: 50px;" alt="${item.categoryname}" 
                                     onerror="this.onerror=null;this.src='https://placehold.co/70x50?text=No+Image';">
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-light text-secondary border">Chưa có ảnh</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><strong class="text-dark">${item.categoryname}</strong></td>
                    <td class="text-center">
                        <span class="badge ${item.status == 1 ? 'bg-success' : 'bg-danger'}">
                            ${item.status == 1 ? "Hoạt động" : "Khóa"}
                        </span>
                    </td>
                    <td class="text-center">
                        <div class="btn-group btn-group-sm">
                            <a href="${pageContext.request.contextPath}/admin/category/edit?id=${item.categoryid}" class="btn btn-outline-primary">
                                <i class="bi bi-pencil-square me-1"></i>Sửa
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/category/delete?id=${item.categoryid}" class="btn btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                                <i class="bi bi-trash me-1"></i>Xóa
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<c:if test="${empty listcate}">
    <div class="text-center py-4 text-muted">
        <i class="bi bi-inbox fs-2"></i>
        <p class="mt-2 mb-0">Chưa có danh mục nào trong hệ thống.</p>
    </div>
</c:if>

</body>
</html>