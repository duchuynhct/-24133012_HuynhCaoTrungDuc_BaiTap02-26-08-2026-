<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm Danh Mục</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    .form-group { margin-bottom: 15px; }
    label { display: block; font-weight: bold; margin-bottom: 5px; }
    input[type="text"], input[type="file"], select { width: 350px; padding: 8px; }
    button { padding: 8px 16px; background: #28a745; color: white; border: none; cursor: pointer; }
</style>
</head>
<body>
    <h2>Thêm Mới Danh Mục</h2>
    <form action="${pageContext.request.contextPath}/admin/category/insert" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Tên danh mục:</label>
            <input type="text" name="categoryname" required="required">
        </div>
        <div class="form-group">
            <label>Hình ảnh:</label>
            <input type="file" name="images" accept="image/*">
        </div>
        <div class="form-group">
            <label>Trạng thái:</label>
            <select name="status">
                <option value="1">Hoạt động</option>
                <option value="0">Khóa</option>
            </select>
        </div>
        <button type="submit">Lưu lại</button>
        <a href="${pageContext.request.contextPath}/admin/categories">Quay lại</a>
    </form>
</body>
</html>