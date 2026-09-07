package trungduc.vn.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import trungduc.vn.entity.User;
import trungduc.vn.services.IUserService;
import trungduc.vn.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // 1. Kiểm tra rỗng
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            fullname == null || fullname.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ tất cả các trường thông tin!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // 2. Validate định dạng Regex Server-side
        if (!username.trim().matches("^[a-zA-Z0-9_]{4,30}$")) {
            req.setAttribute("error", "Tên đăng nhập không hợp lệ (từ 4-30 ký tự, không dấu, chỉ gồm chữ, số và gạch dưới)!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (fullname.trim().length() < 2) {
            req.setAttribute("error", "Họ và tên quá ngắn (tối thiểu 2 ký tự)!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (!email.trim().matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            req.setAttribute("error", "Địa chỉ email không đúng định dạng!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (!phone.trim().matches("^(0[3|5|7|8|9])[0-9]{8}$")) {
            req.setAttribute("error", "Số điện thoại không đúng định dạng mạng viễn thông Việt Nam (10 chữ số, bắt đầu 03, 05, 07, 08, 09)!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("error", "Mật khẩu phải chứa ít nhất 6 ký tự!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không trùng khớp!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // 3. Kiểm tra tính duy nhất trong CSDL
        if (userService.checkExistUsername(username.trim())) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại, vui lòng chọn tên khác!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistEmail(email.trim())) {
            req.setAttribute("error", "Email này đã được sử dụng bởi một tài khoản khác!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setFullname(fullname.trim());
        user.setPhone(phone.trim());
        user.setPassword(password.trim());
        user.setRoleid(0);

        boolean isRegistered = userService.register(user);

        if (isRegistered) {
            HttpSession session = req.getSession();
            session.setAttribute("otp_email", email.trim());
            User createdUser = userService.findByEmail(email.trim());
            if (createdUser != null && createdUser.getOtpCode() != null) {
                session.setAttribute("demo_otp", createdUser.getOtpCode());
            }
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại sau!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}