<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cập Nhật Danh Mục</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    .form-group { margin-bottom: 15px; }
    label { display: block; font-weight: bold; margin-bottom: 5px; }
    input[type="text"], input[type="file"], select { width: 350px; padding: 8px; }
    button { padding: 8px 16px; background: #007bff; color: white; border: none; cursor: pointer; }
    .preview-img { width: 100px; height: 75px; object-fit: cover; display: block; margin-top: 5px; border: 1px solid #ddd; }
</style>
</head>
<body>
    <h2>Cập Nhật Danh Mục</h2>
    <form action="${pageContext.request.contextPath}/admin/category/update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="categoryid" value="${cate.categoryid}">
        <input type="hidden" name="oldImage" value="${cate.images}">

        <div class="form-group">
            <label>Tên danh mục:</label>
            <input type="text" name="categoryname" value="${cate.categoryname}" required="required">
        </div>
        <div class="form-group">
            <label>Hình ảnh hiện tại:</label>
            <c:choose>
                <c:when test="${not empty cate.images}">
                    <img src="${pageContext.request.contextPath}/uploads/${cate.images}" class="preview-img" alt="Current Image">
                </c:when>
                <c:otherwise>
                    <span>Chưa có ảnh</span>
                </c:otherwise>
            </c:choose>
            <br>
            <label>Chọn ảnh mới (nếu muốn thay đổi):</label>
            <input type="file" name="images" accept="image/*">
        </div>
        <div class="form-group">
            <label>Trạng thái:</label>
            <select name="status">
                <option value="1" ${cate.status == 1 ? "selected" : ""}>Hoạt động</option>
                <option value="0" ${cate.status == 0 ? "selected" : ""}>Khóa</option>
            </select>
        </div>
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/categories">Quay lại</a>
    </form>
</body>
</html>