<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Sản phẩm (Admin)</title>
<style>
    body { font-family: 'Segoe UI', Arial, sans-serif; margin: 30px; background-color: #fdfdfd; }
    .header-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 2px solid #e0e0e0;
        padding-bottom: 15px;
        margin-bottom: 25px;
    }
    .nav-links a {
        margin-right: 15px;
        text-decoration: none;
        color: #1a73e8;
        font-weight: 600;
    }
    .nav-links a:hover { text-decoration: underline; }
    table { width: 100%; border-collapse: collapse; margin-top: 15px; background: white; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
    th, td { border: 1px solid #ddd; padding: 12px; text-align: left; vertical-align: middle; }
    th { background-color: #f8f9fa; color: #333; }
    .btn { padding: 6px 12px; text-decoration: none; border-radius: 4px; color: white; display: inline-block; font-size: 14px; }
    .btn-add { background: #28a745; margin-bottom: 15px; font-weight: 600; }
    .btn-edit { background: #ffc107; color: black; }
    .btn-delete { background: #dc3545; }
    .table-img { width: 70px; height: 60px; object-fit: cover; border-radius: 4px; border: 1px solid #eee; }
    .badge-active { background: #e8f5e9; color: #2e7d32; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600; }
    .badge-inactive { background: #ffebee; color: #c62828; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600; }
</style>
</head>
<body>

<div class="header-bar">
    <div>
        <h2 style="margin: 0; color: #2c3e50;">QUẢN LÝ SẢN PHẨM</h2>
        <div class="nav-links" style="margin-top: 8px;">
            <a href="${pageContext.request.contextPath}/admin/categories">Quản lý Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/products" style="color: #28a745;">Quản lý Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/home" target="_blank">Xem Trang chủ</a>
            <a href="${pageContext.request.contextPath}/product" target="_blank">Xem Trang /product</a>
        </div>
    </div>
    <div>
        <c:choose>
            <c:when test="${not empty sessionScope.account}">
                <span>Xin chào, <strong>${sessionScope.account.fullname}</strong>!</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-delete" style="margin-left: 10px;">Đăng xuất</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn" style="background: #1a73e8;">Đăng nhập</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-add">+ Thêm sản phẩm mới</a>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Hình Ảnh</th>
            <th>Tên Sản Phẩm</th>
            <th>Danh Mục</th>
            <th>Giá Bán</th>
            <th>Số Lượng</th>
            <th>Trạng Thái</th>
            <th>Thao Tác</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${listProducts}" var="p">
            <tr>
                <td>${p.productId}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty p.images}">
                            <c:url value="/uploads/${p.images}" var="imgUrl" />
                            <img src="${imgUrl}" class="table-img" alt="${p.productName}" 
                                 onerror="this.onerror=null;this.src='https://placehold.co/70x60?text=No+Img';">
                        </c:when>
                        <c:otherwise>
                            <i>Chưa có ảnh</i>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><strong>${p.productName}</strong></td>
                <td>${p.category != null ? p.category.categoryname : 'N/A'}</td>
                <td><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                <td>${p.quantity}</td>
                <td>
                    <span class="${p.status == 1 ? 'badge-active' : 'badge-inactive'}">
                        ${p.status == 1 ? 'Còn hàng / Hoạt động' : 'Tạm ngưng'}
                    </span>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}" class="btn btn-edit">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.productId}" class="btn btn-delete" onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty listProducts}">
            <tr>
                <td colspan="8" style="text-align: center; color: #888; padding: 25px;">Chưa có sản phẩm nào. Hãy bấm nút "+ Thêm sản phẩm mới" ở trên!</td>
            </tr>
        </c:if>
    </tbody>
</table>

</body>
</html>