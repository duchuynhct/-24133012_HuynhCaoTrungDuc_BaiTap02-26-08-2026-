package trungduc.vn.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import trungduc.vn.services.IUserService;
import trungduc.vn.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/forgot-password", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        HttpSession session = req.getSession();

        if (uri.contains("/reset-password")) {
            String email = (String) session.getAttribute("reset_email");
            if (email == null || email.trim().isEmpty()) {
                email = req.getParameter("email");
                if (email != null && !email.trim().isEmpty()) {
                    session.setAttribute("reset_email", email);
                }
            }

            if (email == null || email.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }

            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        HttpSession session = req.getSession();

        if (uri.contains("/forgot-password")) {
            String email = req.getParameter("email");

            if (email == null || email.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập địa chỉ email của bạn!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            boolean sent = userService.sendForgotPasswordOtp(email.trim());

            if (sent) {
                session.setAttribute("reset_email", email.trim());
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("error", "Email này chưa được đăng ký trong hệ thống!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
            return;
        }

        if (uri.contains("/reset-password")) {
            String email = req.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                email = (String) session.getAttribute("reset_email");
            }

            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            if (email == null || email.trim().isEmpty()) {
                req.setAttribute("error", "Không tìm thấy thông tin email tài khoản!");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            if (otp == null || otp.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập đầy đủ mã OTP và mật khẩu mới!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            int result = userService.resetPassword(email.trim(), otp.trim(), newPassword.trim());

            switch (result) {
                case 1:
                    session.removeAttribute("reset_email");
                    session.setAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập bằng mật khẩu mới.");
                    resp.sendRedirect(req.getContextPath() + "/login");
                    break;
                case 0:
                    req.setAttribute("error", "Mã OTP không chính xác, vui lòng kiểm tra lại!");
                    req.setAttribute("email", email);
                    req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                    break;
                case -1:
                    req.setAttribute("error", "Mã OTP đã hết hạn (quá 5 phút). Vui lòng yêu cầu gửi lại OTP!");
                    req.setAttribute("email", email);
                    req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                    break;
                default:
                    req.setAttribute("error", "Không tìm thấy thông tin tài khoản!");
                    req.setAttribute("email", email);
                    req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                    break;
            }
        }
    }
}