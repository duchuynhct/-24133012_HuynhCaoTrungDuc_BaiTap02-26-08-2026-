<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hồ Sơ Cá Nhân - ${user.fullname}</title>
<style>
    .profile-container { max-width: 800px; margin: 40px auto; padding: 0 20px; }
    .card { background: white; border-radius: 12px; box-shadow: 0 4px 16px rgba(0,0,0,0.08); padding: 35px; }
    .card-header { border-bottom: 2px solid #f0f0f0; padding-bottom: 15px; margin-bottom: 30px; }
    .card-header h2 { margin: 0; color: #1a73e8; font-size: 24px; }
    .card-header p { margin: 5px 0 0 0; color: #666; font-size: 14px; }
    .profile-layout { display: grid; grid-template-columns: 240px 1fr; gap: 35px; align-items: start; }
    @media (max-width: 700px) {
        .profile-layout { grid-template-columns: 1fr; }
    }
    .avatar-section { text-align: center; background: #fafafa; padding: 25px 20px; border-radius: 10px; border: 1px dashed #cfd8dc; }
    .avatar-box { width: 140px; height: 140px; border-radius: 50%; overflow: hidden; margin: 0 auto 15px; border: 3px solid #1a73e8; background: #eee; }
    .avatar-box img { width: 100%; height: 100%; object-fit: cover; }
    .upload-btn-wrapper { position: relative; overflow: hidden; display: inline-block; margin-top: 10px; }
    .btn-file { border: 1px solid #1a73e8; color: #1a73e8; background: white; padding: 7px 16px; border-radius: 6px; font-weight: 600; font-size: 13px; cursor: pointer; transition: background 0.2s; }
    .btn-file:hover { background: #e8f0fe; }
    .upload-btn-wrapper input[type=file] { font-size: 100px; position: absolute; left: 0; top: 0; opacity: 0; cursor: pointer; }
    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; margin-bottom: 6px; font-weight: 600; color: #444; font-size: 14px; }
    .form-control { width: 100%; box-sizing: border-box; padding: 10px 14px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px; transition: border-color 0.2s; }
    .form-control:focus { outline: none; border-color: #1a73e8; }
    .form-control:read-only, .form-control:disabled { background-color: #f1f3f4; color: #666; cursor: not-allowed; }
    .btn-submit { background: #1a73e8; color: white; border: none; padding: 12px 28px; border-radius: 6px; font-weight: 600; font-size: 15px; cursor: pointer; transition: background 0.2s; }
    .btn-submit:hover { background: #1557b0; }
    .alert { padding: 12px 16px; border-radius: 6px; margin-bottom: 20px; font-size: 14px; }
    .alert-success { background-color: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9; }
    .alert-danger { background-color: #ffebee; color: #c62828; border: 1px solid #ffcdd2; }
</style>
</head>
<body>

<div class="profile-container">
    <div class="card">
        <div class="card-header">
            <h2>HỒ SƠ CÁ NHÂN</h2>
            <p>Quản lý thông tin tài khoản, số điện thoại và ảnh đại diện của bạn</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">✅ ${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">❌ ${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
            <input type="hidden" name="oldImage" value="${user.images}" />

            <div class="profile-layout">
                <!-- Cột trái: Ảnh đại diện -->
                <div class="avatar-section">
                    <div class="avatar-box">
                        <c:choose>
                            <c:when test="${not empty user.images}">
                                <img id="previewAvatar" src="${pageContext.request.contextPath}/uploads/${user.images}" 
                                     alt="Avatar" onerror="this.onerror=null;this.src='https://placehold.co/140x140?text=Avatar';"/>
                            </c:when>
                            <c:otherwise>
                                <img id="previewAvatar" src="https://placehold.co/140x140?text=Avatar" alt="Avatar"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="upload-btn-wrapper">
                        <button type="button" class="btn-file">📷 Chọn ảnh mới</button>
                        <input type="file" name="images" id="imageInput" accept="image/*" onchange="previewImage(this);" />
                    </div>
                    <p style="font-size: 12px; color: #888; margin-top: 8px;">Hỗ trợ: JPG, PNG, GIF (Tối đa 10MB)</p>
                </div>

                <!-- Cột phải: Form thông tin -->
                <div class="info-section">
                    <div class="form-group">
                        <label>Tên đăng nhập (Username):</label>
                        <input type="text" class="form-control" value="${user.username}" readonly />
                    </div>

                    <div class="form-group">
                        <label>Địa chỉ Email:</label>
                        <input type="text" class="form-control" value="${user.email}" readonly />
                    </div>

                    <div class="form-group">
                        <label for="fullname">Họ và tên (*):</label>
                        <input type="text" id="fullname" name="fullname" class="form-control" 
                               value="${user.fullname}" required placeholder="Nhập họ và tên đầy đủ" />
                    </div>

                    <div class="form-group">
                        <label for="phone">Số điện thoại:</label>
                        <input type="text" id="phone" name="phone" class="form-control" 
                               value="${user.phone}" placeholder="Ví dụ: 0912345678" />
                    </div>

                    <div style="margin-top: 25px;">
                        <button type="submit" class="btn-submit">💾 Lưu Thay Đổi</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('previewAvatar').src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

</body>
</html>

