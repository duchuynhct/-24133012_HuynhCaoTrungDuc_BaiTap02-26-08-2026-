package trungduc.vn.utils;

import java.util.Properties;
import java.util.Random;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // Cấu hình Email gửi đi (Có thể thay đổi bằng thông tin Gmail và Mật khẩu ứng dụng của bạn)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "your-email@gmail.com"; // Thay bằng email của bạn
    private static final String SENDER_PASSWORD = "your-app-password";  // Thay bằng mật khẩu ứng dụng Gmail 16 ký tự

    /**
     * Sinh mã OTP ngẫu nhiên gồm 6 chữ số
     */
    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    /**
     * Gửi mã OTP qua Email với mục đích tùy chỉnh (Kích hoạt tài khoản hoặc Khôi phục mật khẩu)
     * @param toEmail Email người nhận
     * @param otpCode Mã OTP 6 chữ số
     * @param fullname Họ tên người nhận
     * @param subject Tiêu đề email
     * @param purpose Mục đích gửi ("KÍCH HOẠT TÀI KHOẢN" hoặc "KHÔI PHỤC MẬT KHẨU")
     * @return true nếu thành công
     */
    public static boolean sendOtpEmail(String toEmail, String otpCode, String fullname, String subject, String purpose) {
        System.out.println("==================================================================");
        System.out.println("[EMAIL SERVICE - " + purpose.toUpperCase() + "]");
        System.out.println(">> Gửi đến Email: " + toEmail + " (" + fullname + ")");
        System.out.println(">> Mã OTP xác nhận: " + otpCode + " (Có hiệu lực trong 5 phút)");
        System.out.println("==================================================================");

        // Nếu email hoặc mật khẩu chưa được cấu hình thật thì bỏ qua bước gửi qua mạng nhưng trả về true
        if (SENDER_EMAIL.contains("your-email") || SENDER_PASSWORD.contains("your-app-password")) {
            System.out.println("[EMAIL SERVICE] Lưu ý: Đang dùng thông tin cấu hình mặc định. Vui lòng lấy mã OTP từ Console ở trên để tiếp tục!");
            return true;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Hệ thống Quản lý Web"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            String htmlContent = "<div style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px;\">"
                    + "<h2 style=\"color: #2c3e50; text-align: center;\">" + purpose.toUpperCase() + "</h2>"
                    + "<p>Xin chào <strong>" + fullname + "</strong>,</p>"
                    + "<p>Bạn đã gửi yêu cầu " + purpose.toLowerCase() + ". Vui lòng sử dụng mã OTP dưới đây để hoàn tất thao tác:</p>"
                    + "<div style=\"text-align: center; margin: 25px 0;\">"
                    + "<span style=\"display: inline-block; font-size: 32px; font-weight: bold; color: #ffffff; background: #007bff; padding: 10px 25px; border-radius: 6px; letter-spacing: 5px;\">"
                    + otpCode + "</span>"
                    + "</div>"
                    + "<p style=\"color: #e74c3c; font-size: 14px;\"><strong>* Lưu ý:</strong> Mã OTP này có hiệu lực trong vòng <strong>5 phút</strong>. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>"
                    + "<hr style=\"border: none; border-top: 1px solid #eee; margin: 20px 0;\" />"
                    + "<p style=\"color: #888; font-size: 12px; text-align: center;\">Đây là email tự động, vui lòng không phản hồi lại thư này.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("[EMAIL SERVICE] Đã gửi email thành công tới: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("[EMAIL SERVICE] Lỗi khi gửi email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}