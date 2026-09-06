package trungduc.vn.test;

import java.util.List;
import jakarta.persistence.EntityManager;
import trungduc.vn.configs.JpaConfig;
import trungduc.vn.entity.Category;
import trungduc.vn.entity.Video;
import trungduc.vn.entity.User;
import trungduc.vn.entity.Product;

public class TestMain {

    public static void main(String[] args) {
        EntityManager em = JpaConfig.getEntityManager();

        try {
            List<Category> list = em.createNamedQuery("Category.findAll", Category.class).getResultList();

            System.out.println("========== DANH SÁCH DỮ LIỆU ==========");
            for (Category c : list) {
                System.out.println("Category [" + c.getCategoryid() + "]: " + c.getCategoryname());
                for (Video v : c.getVideos()) {
                    System.out.println("  └── Video ID: " + v.getVideoId() + " | Title: " + v.getTitle());
                }
            }

            System.out.println("\n========== TEST ĐĂNG KÝ VÀ KÍCH HOẠT OTP ==========");
            trungduc.vn.services.IUserService userService = new trungduc.vn.services.impl.UserServiceImpl();
            String testUser = "testuser_" + System.currentTimeMillis();
            String testEmail = testUser + "@example.com";

            trungduc.vn.entity.User u = new trungduc.vn.entity.User();
            u.setUsername(testUser);
            u.setEmail(testEmail);
            u.setFullname("Test User");
            u.setPassword("123456");

            boolean reg = userService.register(u);
            System.out.println("1. Đăng ký tài khoản: " + (reg ? "THÀNH CÔNG" : "THẤT BẠI"));

            trungduc.vn.entity.User saved = userService.findById(testUser);
            System.out.println("2. Trạng thái sau đăng ký: " + (saved.getStatus() == 0 ? "Chưa kích hoạt (status=0) - ĐÚNG" : "Sai"));
            System.out.println("3. Mã OTP sinh ra: " + saved.getOtpCode());

            // Test nhập sai OTP
            int verifyWrong = userService.verifyOtp(testEmail, "999999");
            System.out.println("4. Test nhập sai OTP (kỳ vọng 0): " + verifyWrong);

            // Test nhập đúng OTP
            int verifySuccess = userService.verifyOtp(testEmail, saved.getOtpCode());
            System.out.println("5. Test nhập đúng OTP (kỳ vọng 1): " + verifySuccess);

            trungduc.vn.entity.User activeUser = userService.findById(testUser);
            System.out.println("6. Trạng thái sau kích hoạt: " + (activeUser.getStatus() == 1 ? "ĐÃ KÍCH HOẠT (status=1) - ĐÚNG" : "Sai"));

            // Test quên mật khẩu
            System.out.println("\n========== TEST QUÊN MẬT KHẨU ==========");
            boolean sentForgot = userService.sendForgotPasswordOtp(testEmail);
            System.out.println("8. Gửi OTP quên mật khẩu: " + (sentForgot ? "THÀNH CÔNG" : "THẤT BẠI"));
            User forgotUser = userService.findByEmail(testEmail);
            int resetResult = userService.resetPassword(testEmail, forgotUser.getOtpCode(), "newpassword123");
            System.out.println("9. Đặt lại mật khẩu với OTP: " + (resetResult == 1 ? "THÀNH CÔNG" : "THẤT BẠI"));
            User checkNewPass = userService.login(testUser, "newpassword123");
            System.out.println("10. Đăng nhập bằng mật khẩu mới: " + (checkNewPass != null ? "THÀNH CÔNG" : "THẤT BẠI"));

            System.out.println("\n========== TEST SẢN PHẨM & PHÂN TRANG ==========");
            trungduc.vn.services.IProductService productService = new trungduc.vn.services.impl.ProductServiceImpl();
            trungduc.vn.services.ICategoryService categoryService = new trungduc.vn.services.impl.CategoryServiceImpl();

            List<Category> allCategories = categoryService.findAll();
            Category defaultCate = null;
            if (allCategories.isEmpty()) {
                defaultCate = new Category();
                defaultCate.setCategoryname("Điện tử & Công nghệ");
                defaultCate.setStatus(1);
                categoryService.insert(defaultCate);
                allCategories = categoryService.findAll();
            }
            defaultCate = allCategories.get(0);

            int currentCount = productService.countAll();
            System.out.println("Tổng số sản phẩm hiện tại: " + currentCount);

            // Nếu ít hơn 12 sản phẩm, thêm các sản phẩm mẫu để phục vụ test top 10 và phân trang 6 sp/trang
            if (currentCount < 12) {
                System.out.println("Đang khởi tạo dữ liệu mẫu cho bảng Products...");
                for (int i = currentCount + 1; i <= 12; i++) {
                    trungduc.vn.entity.Product p = new trungduc.vn.entity.Product();
                    p.setProductName("Sản phẩm công nghệ Pro " + i);
                    p.setDescription("Mô tả chi tiết sản phẩm công nghệ cao cấp thế hệ " + i + ". Bảo hành chính hãng 12 tháng.");
                    p.setPrice(150000.0 * i);
                    p.setQuantity(20 + i);
                    p.setStatus(1);
                    p.setCreateDate(java.time.LocalDateTime.now().minusHours(12 - i));
                    p.setCategory(defaultCate);
                    productService.insert(p);
                }
                currentCount = productService.countAll();
                System.out.println("Đã khởi tạo xong. Tổng số sản phẩm: " + currentCount);
            }

            // Test lấy 10 sản phẩm mới nhất
            List<trungduc.vn.entity.Product> top10 = productService.findTop10Latest();
            System.out.println("11. Số lượng sản phẩm top 10 mới nhất: " + top10.size() + " (Kỳ vọng: 10)");

            // Test phân trang 6 sản phẩm / trang
            List<trungduc.vn.entity.Product> page1 = productService.findPaginated(1, 6);
            System.out.println("12. Số lượng sản phẩm trang 1 (size 6): " + page1.size() + " (Kỳ vọng: 6)");

            List<trungduc.vn.entity.Product> page2 = productService.findPaginated(2, 6);
            System.out.println("13. Số lượng sản phẩm trang 2 (size 6): " + page2.size() + " (Kỳ vọng: 6)");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
            JpaConfig.shutdown();
        }
    }
}