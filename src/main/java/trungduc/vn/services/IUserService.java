package trungduc.vn.services;

import java.util.List;
import trungduc.vn.entity.User;

public interface IUserService {

    boolean register(User user);

    /**
     * Xác thực mã OTP kích hoạt tài khoản
     * @return 1: Kích hoạt thành công
     *         0: Mã OTP không chính xác
     *        -1: Mã OTP đã hết hạn
     *        -2: Không tìm thấy tài khoản
     */
    int verifyOtp(String email, String otp);

    boolean resendOtp(String email);

    User login(String username, String password);

    /**
     * Gửi mã OTP khôi phục mật khẩu qua Email
     * @return true nếu gửi thành công, false nếu email không tồn tại
     */
    boolean sendForgotPasswordOtp(String email);

    /**
     * Xác thực OTP và đặt lại mật khẩu mới
     * @return 1: Đổi mật khẩu thành công
     *         0: Sai mã OTP
     *        -1: Mã OTP hết hạn
     *        -2: Không tìm thấy tài khoản
     */
    int resetPassword(String email, String otp, String newPassword);

    User findById(String username);

    User findByEmail(String email);

    List<User> findAll();

    boolean checkExistUsername(String username);

    boolean checkExistEmail(String email);
}