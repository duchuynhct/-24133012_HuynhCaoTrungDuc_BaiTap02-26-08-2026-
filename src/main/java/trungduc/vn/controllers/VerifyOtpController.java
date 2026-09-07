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

@WebServlet(urlPatterns = {"/verify-otp", "/resend-otp"})
public class VerifyOtpController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("otp_email");

        if (email == null || email.trim().isEmpty()) {
            email = req.getParameter("email");
            if (email != null && !email.trim().isEmpty()) {
                session.setAttribute("otp_email", email);
            }
        }

        if (uri.contains("/resend-otp")) {
            if (email != null && !email.trim().isEmpty()) {
                boolean resent = userService.resendOtp(email);
                if (resent) {
                    trungduc.vn.entity.User userWithOtp = userService.findByEmail(email);
                    if (userWithOtp != null && userWithOtp.getOtpCode() != null) {
                        session.setAttribute("demo_otp", userWithOtp.getOtpCode());
                    }
                    req.setAttribute("message", "Mã OTP mới đã được gửi tới email: " + email);
                } else {
                    req.setAttribute("error", "Không thể gửi lại mã OTP hoặc tài khoản đã được kích hoạt!");
                }
            } else {
                req.setAttribute("error", "Vui lòng nhập email để nhận mã OTP!");
            }
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        // Lấy lại mã OTP hiện tại của user để hiển thị hỗ trợ
        trungduc.vn.entity.User currentOtpUser = userService.findByEmail(email);
        if (currentOtpUser != null && currentOtpUser.getOtpCode() != null) {
            session.setAttribute("demo_otp", currentOtpUser.getOtpCode());
        }

        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        String email = req.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            email = (String) session.getAttribute("otp_email");
        }

        String otp = req.getParameter("otp");

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Không xác định được email tài khoản!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        if (otp == null || otp.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập mã OTP gồm 6 chữ số!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        int result = userService.verifyOtp(email.trim(), otp.trim());

        switch (result) {
            case 1:
                session.removeAttribute("otp_email");
                session.removeAttribute("demo_otp");
                session.setAttribute("message", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.");
                resp.sendRedirect(req.getContextPath() + "/login");
                break;
            case 0:
                req.setAttribute("error", "Mã OTP không chính xác, vui lòng kiểm tra lại!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
                break;
            case -1:
                req.setAttribute("error", "Mã OTP đã hết hạn (quá 5 phút). Vui lòng nhấn 'Gửi lại mã OTP'!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("error", "Không tìm thấy thông tin tài khoản tương ứng!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
                break;
        }
    }
}