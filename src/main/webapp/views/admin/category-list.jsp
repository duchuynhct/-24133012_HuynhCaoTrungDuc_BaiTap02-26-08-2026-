<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Danh mục</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    table { width: 100%; border-collapse: collapse; margin-top: 15px; }
    th, td { border: 1px solid #ccc; padding: 10px; text-align: left; vertical-align: middle; }
    th { background-color: #f4f4f4; }
    .btn { padding: 6px 12px; text-decoration: none; border-radius: 4px; color: white; display: inline-block; }
    .btn-add { background: #28a745; margin-bottom: 10px; }
    .btn-edit { background: #ffc107; color: black; }
    .btn-delete { background: #dc3545; }
    .table-img { width: 70px; height: 50px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd; }
</style>
</head>
<body>
    <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e0e0e0; padding-bottom: 15px; margin-bottom: 20px;">
        <div>
            <h2 style="margin: 0; color: #2c3e50;">QUẢN LÝ DANH MỤC</h2>
            <div style="margin-top: 8px;">
                <a href="${pageContext.request.contextPath}/admin/categories" style="margin-right: 15px; text-decoration: none; color: #28a745; font-weight: 600;">Quản lý Danh mục</a>
                <a href="${pageContext.request.contextPath}/admin/products" style="margin-right: 15px; text-decoration: none; color: #1a73e8; font-weight: 600;">Quản lý Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/home" target="_blank" style="margin-right: 15px; text-decoration: none; color: #555; font-weight: 600;">Xem Trang chủ</a>
                <a href="${pageContext.request.contextPath}/product" target="_blank" style="text-decoration: none; color: #555; font-weight: 600;">Xem Trang /product</a>
            </div>
        </div>
        <div>
            <c:choose>
                <c:when test="${not empty sessionScope.account}">
                    <span>Xin chào, <strong>${sessionScope.account.fullname}</strong>!</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-delete" style="margin-left: 10px;">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn" style="background: #1a73e8; margin-right: 5px;">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn" style="background: #6c757d;">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-add">+ Thêm danh mục mới</a>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên Danh Mục</th>
                <th>Hình Ảnh</th>
                <th>Trạng Thái</th>
                <th>Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listcate}" var="item">
                <tr>
                    <td>${item.categoryid}</td>
                    <td>${item.categoryname}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty item.images}">
                                <c:url value="/uploads/${item.images}" var="imgUrl" />
                                <img src="${imgUrl}" class="table-img" alt="${item.categoryname}" 
                                     onerror="this.onerror=null;this.src='https://placehold.co/70x50?text=No+Image';">
                            </c:when>
                            <c:otherwise>
                                <i>Chưa có ảnh</i>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.status == 1 ? "Hoạt động" : "Khóa"}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${item.categoryid}" class="btn btn-edit">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${item.categoryid}" class="btn btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>