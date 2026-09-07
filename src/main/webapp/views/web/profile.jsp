<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hồ Sơ Cá Nhân - ${user.fullname}</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-lg-10">
        <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
            <div class="card-header bg-primary text-white py-3 px-4">
                <h4 class="mb-1 fw-bold"><i class="bi bi-person-badge me-2"></i>HỒ SƠ CÁ NHÂN</h4>
                <p class="mb-0 small opacity-75">Quản lý thông tin tài khoản, số điện thoại và ảnh đại diện</p>
            </div>
            
            <div class="card-body p-4">
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="profileForm">
                    <input type="hidden" name="oldImage" value="${user.images}" />

                    <div class="row g-4">
                        <!-- Left column: Avatar preview & upload -->
                        <div class="col-md-4 text-center">
                            <div class="p-3 bg-light rounded-3 border border-dashed text-center">
                                <div class="position-relative d-inline-block mb-3">
                                    <c:choose>
                                        <c:when test="${not empty user.images}">
                                            <img id="previewAvatar" src="${pageContext.request.contextPath}/uploads/${user.images}" 
                                                 class="rounded-circle shadow object-fit-cover border border-3 border-primary" style="width: 140px; height: 140px;"
                                                 alt="Avatar" onerror="this.onerror=null;this.src='https://placehold.co/140x140?text=Avatar';"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img id="previewAvatar" src="https://placehold.co/140x140?text=Avatar" 
                                                 class="rounded-circle shadow object-fit-cover border border-3 border-primary" style="width: 140px; height: 140px;" alt="Avatar"/>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="mb-2">
                                    <label for="imageInput" class="btn btn-outline-primary btn-sm fw-semibold">
                                        <i class="bi bi-camera-fill me-1"></i>Chọn ảnh mới
                                    </label>
                                    <input type="file" name="images" id="imageInput" class="d-none" accept="image/*" onchange="previewImage(this);" />
                                </div>
                                <span class="text-muted d-block" style="font-size: 12px;">Định dạng: JPG, PNG, WEBP (Tối đa 5MB)</span>
                            </div>
                        </div>

                        <!-- Right column: Information Form -->
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label class="form-label fw-semibold text-secondary">Tên đăng nhập (Username):</label>
                                <input type="text" class="form-control bg-light" value="${user.username}" readonly />
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold text-secondary">Địa chỉ Email:</label>
                                <input type="text" class="form-control bg-light" value="${user.email}" readonly />
                            </div>

                            <div class="mb-3">
                                <label for="fullname" class="form-label fw-semibold">Họ và tên (*):</label>
                                <input type="text" id="fullname" name="fullname" class="form-control" 
                                       value="${user.fullname}" required minlength="2" maxlength="100" placeholder="Nhập họ và tên đầy đủ" />
                                <div class="invalid-feedback">Họ và tên không được để trống (tối thiểu 2 ký tự).</div>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label fw-semibold">Số điện thoại:</label>
                                <input type="tel" id="phone" name="phone" class="form-control" 
                                       value="${user.phone}" pattern="^(0[3|5|7|8|9])[0-9]{8}$" placeholder="Ví dụ: 0912345678" />
                                <div class="invalid-feedback">Số điện thoại phải gồm 10 chữ số (bắt đầu 03, 05, 07, 08, 09).</div>
                            </div>

                            <div class="mt-4 pt-2">
                                <button type="submit" class="btn btn-primary px-4 py-2 fw-semibold">
                                    <i class="bi bi-check2-circle me-1"></i>Lưu Thay Đổi
                                </button>
                                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-3 py-2 ms-2">
                                    Quay lại
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function previewImage(input) {
    if (input.files && input.files[0]) {
        const file = input.files[0];
        const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/webp', 'image/gif'];
        if (!allowedTypes.includes(file.type)) {
            alert('Chỉ chấp nhận các định dạng file ảnh (JPG, PNG, WEBP, GIF)!');
            input.value = '';
            return;
        }
        if (file.size > 5 * 1024 * 1024) {
            alert('Dung lượng ảnh không được vượt quá 5MB!');
            input.value = '';
            return;
        }
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('previewAvatar').src = e.target.result;
        }
        reader.readAsDataURL(file);
    }
}
</script>

</body>
</html>
