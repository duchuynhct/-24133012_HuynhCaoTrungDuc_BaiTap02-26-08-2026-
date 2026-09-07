package trungduc.vn.controllers.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import trungduc.vn.entity.User;
import trungduc.vn.services.IUserService;
import trungduc.vn.services.impl.UserServiceImpl;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
@WebServlet(urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();
    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Truy vấn dữ liệu mới nhất từ CSDL bằng username
        User user = userService.findById(currentUser.getUsername());
        req.setAttribute("user", user);

        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String oldImage = req.getParameter("oldImage");

        if (fullname == null || fullname.trim().isEmpty() || fullname.trim().length() < 2) {
            req.setAttribute("error", "Họ và tên không được để trống và phải có ít nhất 2 ký tự!");
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
            return;
        }

        if (phone != null && !phone.trim().isEmpty() && !phone.trim().matches("^(0[3|5|7|8|9])[0-9]{8}$")) {
            req.setAttribute("error", "Số điện thoại không đúng định dạng mạng viễn thông Việt Nam (10 chữ số, bắt đầu 03, 05, 07, 08, 09)!");
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
            return;
        }

        // Thư mục lưu trữ ảnh uploads/
        String uploadPath = req.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Xử lý upload file ảnh multipart an toàn
        String finalFileName = oldImage;
        try {
            Part filePart = req.getPart("images");
            if (filePart != null && filePart.getSize() > 0) {
                String submitted = filePart.getSubmittedFileName();
                if (submitted != null && !submitted.trim().isEmpty()) {
                    String lower = submitted.toLowerCase();
                    if (!lower.endsWith(".jpg") && !lower.endsWith(".jpeg") && !lower.endsWith(".png") && !lower.endsWith(".webp") && !lower.endsWith(".gif")) {
                        req.setAttribute("error", "Chỉ chấp nhận file ảnh định dạng JPG, JPEG, PNG, WEBP hoặc GIF!");
                        req.setAttribute("user", currentUser);
                        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
                        return;
                    }
                    String submittedFileName = Paths.get(submitted).getFileName().toString();
                    finalFileName = System.currentTimeMillis() + "_" + submittedFileName;
                    filePart.write(uploadPath + File.separator + finalFileName);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Cập nhật thông tin vào CSDL qua JPA
        User updatedUser = userService.updateProfile(currentUser.getUsername(), fullname.trim(), phone, finalFileName);

        if (updatedUser != null) {
            // Cập nhật lại session để thanh navbar nhận diện tên và avatar mới ngay lập tức
            session.setAttribute("account", updatedUser);
            req.setAttribute("user", updatedUser);
            req.setAttribute("message", "Cập nhật hồ sơ cá nhân thành công!");
        } else {
            req.setAttribute("error", "Cập nhật thất bại, vui lòng thử lại!");
            req.setAttribute("user", currentUser);
        }

        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }
}

