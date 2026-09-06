<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm Sản Phẩm Mới</title>
<style>
    body { font-family: 'Segoe UI', Arial, sans-serif; margin: 30px; background-color: #fdfdfd; }
    .form-card {
        max-width: 650px;
        margin: 0 auto;
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    h2 { margin-top: 0; color: #2c3e50; border-bottom: 2px solid #eee; padding-bottom: 12px; }
    .form-group { margin-bottom: 16px; }
    .form-group label { display: block; margin-bottom: 6px; font-weight: 600; color: #333; }
    .form-group input, .form-group select, .form-group textarea {
        width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px;
    }
    .btn { padding: 10px 18px; border-radius: 4px; color: white; text-decoration: none; display: inline-block; cursor: pointer; border: none; font-size: 15px; font-weight: 600; }
    .btn-save { background: #28a745; margin-right: 10px; }
    .btn-cancel { background: #6c757d; }
    .form-row { display: flex; gap: 15px; }
    .form-row .form-group { flex: 1; }
</style>
</head>
<body>

<div class="form-card">
    <h2>THÊM SẢN PHẨM MỚI</h2>

    <form action="${pageContext.request.contextPath}/admin/product/insert" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="productname">Tên sản phẩm (*):</label>
            <input type="text" id="productname" name="productname" required placeholder="Nhập tên sản phẩm" />
        </div>

        <div class="form-group">
            <label for="categoryid">Thuộc Danh Mục (*):</label>
            <select id="categoryid" name="categoryid" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach items="${categories}" var="c">
                    <option value="${c.categoryid}">${c.categoryname}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="price">Giá bán (VNĐ) (*):</label>
                <input type="number" id="price" name="price" required min="0" step="1000" placeholder="50000" />
            </div>

            <div class="form-group">
                <label for="quantity">Số lượng kho (*):</label>
                <input type="number" id="quantity" name="quantity" required min="0" value="10" />
            </div>
        </div>

        <div class="form-group">
            <label for="images">Hình ảnh đại diện sản phẩm:</label>
            <input type="file" id="images" name="images" accept="image/*" />
        </div>

        <div class="form-group">
            <label for="status">Trạng thái:</label>
            <select id="status" name="status">
                <option value="1">Hoạt động / Còn hàng</option>
                <option value="0">Tạm khóa / Hết hàng</option>
            </select>
        </div>

        <div class="form-group">
            <label for="description">Mô tả chi tiết sản phẩm:</label>
            <textarea id="description" name="description" rows="4" placeholder="Nhập thông tin chi tiết về sản phẩm..."></textarea>
        </div>

        <div style="margin-top: 20px;">
            <button type="submit" class="btn btn-save">Lưu Sản Phẩm</button>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-cancel">Hủy Bỏ</a>
        </div>
    </form>
</div>

</body>
</html>