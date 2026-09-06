# BÀI TẬP 02 - LẬP TRÌNH WEB (JPA 3.0 & JAKARTA SERVLET 6.0)

- **Sinh viên thực hiện:** Huỳnh Cao Trung Đức
- **Mã số sinh viên:** 24133012

---

### Công nghệ sử dụng
- Java 17+, Jakarta Servlet 6.0, Jakarta JSP 3.1
- Hibernate Core 6.4 (JPA 3.0)
- SQL Server (JDBC Driver 12.6.1)
- Jakarta Mail 2.1 (Eclipse Angus Mail 2.0.3)
- Apache Tomcat 10.1+ / 11.0+

---

### Các chức năng đã hoàn thành

1. **Quản lý Danh mục (Category) & Video:**
   - Quan hệ 1 - N giữa `Category` và `Video`.
   - Thực hiện đầy đủ CRUD cho Danh mục, hỗ trợ tải lên hình ảnh đại diện (`uploads/`).

2. **Quản lý Sản phẩm (Product) - Quan hệ 1 - N với Category:**
   - Tạo bảng `products` liên kết khóa ngoại với bảng `categories`.
   - Thực hiện đầy đủ CRUD cho Sản phẩm (Upload ảnh, chọn danh mục, giá bán, số lượng, mô tả).
   - URL Quản trị Sản phẩm: `/admin/products`.

3. **Xác thực Tài khoản & Kích hoạt qua Email OTP:**
   - Đăng ký tài khoản (`/register`): Hệ thống lưu tài khoản ở trạng thái chưa kích hoạt (`status = 0`), tự động sinh mã OTP 6 chữ số và gửi qua Email (kèm thời hạn 5 phút).
   - Kích hoạt bằng OTP (`/verify-otp`): Nhập đúng mã OTP để kích hoạt tài khoản (`status = 1`). Có hỗ trợ gửi lại mã OTP (`/resend-otp`).
   - Đăng nhập (`/login`) & Đăng xuất (`/logout`): Kiểm tra thông tin đăng nhập, bắt buộc tài khoản đã kích hoạt mới được truy cập hệ thống.

4. **Khôi phục / Quên mật khẩu qua OTP Email:**
   - Quên mật khẩu (`/forgot-password`): Nhập email tài khoản để nhận mã OTP xác thực.
   - Đặt lại mật khẩu (`/reset-password`): Xác thực mã OTP hợp lệ trong 5 phút và cập nhật mật khẩu mới.

5. **Trang hiển thị Client Web:**
   - **Trang chủ (`/home` hoặc `/`):** Hiển thị danh sách **10 sản phẩm mới nhất** theo dạng lưới thẻ card hiện đại.
   - **Trang Sản phẩm (`/product`):** Hiển thị toàn bộ sản phẩm với chức năng **phân trang 6 sản phẩm/trang**.
   - **Chi tiết Sản phẩm (`/product/detail?id=...`):** Xem chi tiết hình ảnh lớn, tên, danh mục, giá, số lượng kho, mô tả khi nhấp vào bất kỳ sản phẩm nào từ Trang chủ hoặc trang `/product`.

---

### Danh sách các URL chính của dự án

| Chức năng | Đường dẫn URL |
|---|---|
| Trang chủ (Top 10 sản phẩm mới) | `http://localhost:8080/BaiTap_26_8/home` |
| Danh sách sản phẩm (Phân trang 6 sp/trang) | `http://localhost:8080/BaiTap_26_8/product` |
| Chi tiết sản phẩm | `http://localhost:8080/BaiTap_26_8/product/detail?id=1` |
| Đăng ký tài khoản | `http://localhost:8080/BaiTap_26_8/register` |
| Xác thực OTP | `http://localhost:8080/BaiTap_26_8/verify-otp` |
| Đăng nhập | `http://localhost:8080/BaiTap_26_8/login` |
| Quên mật khẩu | `http://localhost:8080/BaiTap_26_8/forgot-password` |
| Quản trị Sản phẩm (CRUD) | `http://localhost:8080/BaiTap_26_8/admin/products` |
| Quản trị Danh mục (CRUD) | `http://localhost:8080/BaiTap_26_8/admin/categories` |

