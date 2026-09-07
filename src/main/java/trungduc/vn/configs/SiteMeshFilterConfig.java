package trungduc.vn.configs;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

import jakarta.servlet.annotation.WebFilter;

@WebFilter(filterName = "sitemesh", urlPatterns = "/*")
public class SiteMeshFilterConfig extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Tiền tố đường dẫn chứa decorator
        builder.setDecoratorPrefix("/WEB-INF/decorators");

        // Áp dụng decorator cho giao diện quản trị
        builder.addDecoratorPath("/admin/*", "/admin.jsp")
               // Áp dụng decorator cho giao diện người dùng
               .addDecoratorPath("/*", "/web.jsp")
               // Loại trừ các trang auth và tài nguyên tĩnh không cần decorator
               .addExcludedPath("/login*")
               .addExcludedPath("/register*")
               .addExcludedPath("/verify-otp*")
               .addExcludedPath("/resend-otp*")
               .addExcludedPath("/forgot-password*")
               .addExcludedPath("/reset-password*")
               .addExcludedPath("/uploads/*");
    }
}
