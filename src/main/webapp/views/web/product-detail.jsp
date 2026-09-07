<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chi Tiết Sản Phẩm - ${product != null ? product.productName : 'Không tìm thấy'}</title>
<style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; color: #333; }
    .navbar {
        background: #ffffff;
        padding: 15px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        position: sticky;
        top: 0;
        z-index: 100;
    }
    .brand { font-size: 22px; font-weight: bold; color: #1a73e8; text-decoration: none; }
    .nav-menu a {
        margin-left: 20px;
        text-decoration: none;
        color: #555;
        font-weight: 600;
        font-size: 15px;
        transition: color 0.2s;
    }
    .nav-menu a:hover { color: #1a73e8; }
    .container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
    .detail-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        display: flex;
        gap: 40px;
        padding: 35px;
    }
    @media (max-width: 768px) {
        .detail-card { flex-direction: column; }
    }
    .detail-img-wrap {
        flex: 1;
        max-width: 420px;
        background: #fafafa;
        border-radius: 8px;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #eee;
    }
    .detail-img {
        width: 100%;
        max-height: 400px;
        object-fit: cover;
    }
    .detail-info {
        flex: 1.2;
        display: flex;
        flex-direction: column;
    }
    .category-badge {
        display: inline-block;
        background: #e3f2fd;
        color: #1976d2;
        font-size: 13px;
        font-weight: bold;
        padding: 4px 10px;
        border-radius: 4px;
        margin-bottom: 12px;
        align-self: flex-start;
    }
    .detail-title {
        font-size: 26px;
        font-weight: bold;
        color: #2c3e50;
        margin: 0 0 15px 0;
        line-height: 1.3;
    }
    .detail-price {
        font-size: 28px;
        font-weight: bold;
        color: #e53935;
        margin-bottom: 20px;
    }
    .meta-row {
        margin-bottom: 12px;
        font-size: 15px;
        color: #555;
    }
    .meta-row strong {
        color: #222;
        display: inline-block;
        width: 130px;
    }
    .description-box {
        margin-top: 25px;
        padding-top: 20px;
        border-top: 1px solid #eee;
    }
    .description-box h4 {
        margin: 0 0 10px 0;
        color: #2c3e50;
        font-size: 17px;
    }
    .description-box p {
        color: #555;
        line-height: 1.6;
        margin: 0;
        white-space: pre-line;
    }
    .action-row {
        margin-top: 30px;
        display: flex;
        gap: 15px;
    }
    .btn-buy {
        background: #ff5722;
        color: white;
        padding: 12px 30px;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.2s;
    }
    .btn-buy:hover { background: #e64a19; }
    .btn-back {
        background: #6c757d;
        color: white;
        padding: 12px 24px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 15px;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
    .btn-back:hover { background: #5a6268; }
    .footer {
        background: #263238;
        color: #cfd8dc;
        text-align: center;
        padding: 25px;
        margin-top: 60px;
        font-size: 14px;
    }
</style>
</head>
<body>

<div class="container">
    <c:choose>
        <c:when test="${not empty product}">
            <div class="detail-card">
                <div class="detail-img-wrap">
                    <c:choose>
                        <c:when test="${not empty product.images}">
                            <img src="${pageContext.request.contextPath}/uploads/${product.images}" class="detail-img" alt="${product.productName}"
                                 onerror="this.onerror=null;this.src='https://placehold.co/400x350?text=San+Pham';" />
                        </c:when>
                        <c:otherwise>
                            <img src="https://placehold.co/400x350?text=San+Pham" class="detail-img" alt="${product.productName}" />
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="detail-info">
                    <span class="category-badge">${product.category != null ? product.category.categoryname : 'Danh mục chung'}</span>
                    <h1 class="detail-title">${product.productName}</h1>
                    <div class="detail-price">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </div>

                    <div class="meta-row">
                        <strong>Mã sản phẩm:</strong> #${product.productId}
                    </div>
                    <div class="meta-row">
                        <strong>Danh mục:</strong> ${product.category != null ? product.category.categoryname : 'Chưa phân loại'}
                    </div>
                    <div class="meta-row">
                        <strong>Số lượng còn lại:</strong> ${product.quantity} sản phẩm
                    </div>
                    <div class="meta-row">
                        <strong>Trạng thái:</strong> 
                        <span style="color: ${product.status == 1 ? '#28a745' : '#dc3545'}; font-weight: bold;">
                            ${product.status == 1 ? 'Còn hàng / Đang kinh doanh' : 'Tạm hết hàng'}
                        </span>
                    </div>

                    <div class="description-box">
                        <h4>MÔ TẢ CHI TIẾT</h4>
                        <p>${not empty product.description ? product.description : 'Sản phẩm chính hãng với chất lượng đảm bảo và bảo hành uy tín.'}</p>
                    </div>

                    <div class="action-row">
                        <button class="btn-buy" onclick="alert('Đã thêm sản phẩm vào giỏ hàng thành công!')">MUA NGAY</button>
                        <a href="${pageContext.request.contextPath}/product" class="btn-back">&larr; Quay lại danh sách</a>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div style="text-align: center; padding: 50px; background: white; border-radius: 8px;">
                <h2 style="color: #dc3545;">Không tìm thấy sản phẩm!</h2>
                <p>Sản phẩm này không tồn tại hoặc đã bị xóa.</p>
                <a href="${pageContext.request.contextPath}/product" class="btn-back" style="margin-top: 15px;">&larr; Về trang danh sách sản phẩm</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>