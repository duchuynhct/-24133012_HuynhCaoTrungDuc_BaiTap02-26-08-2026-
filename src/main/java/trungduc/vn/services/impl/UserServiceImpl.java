package trungduc.vn.services.impl;

import java.time.LocalDateTime;
import java.util.List;
import trungduc.vn.dao.IUserDao;
import trungduc.vn.dao.impl.UserDaoImpl;
import trungduc.vn.entity.User;
import trungduc.vn.services.IUserService;
import trungduc.vn.utils.EmailUtil;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDaoImpl();

    @Override
    public boolean register(User user) {
        if (userDao.checkExistUsername(user.getUsername()) || userDao.checkExistEmail(user.getEmail())) {
            return false;
        }

        String otp = EmailUtil.generateOtp();
        user.setOtpCode(otp);
        user.setOtpExpiryTime(LocalDateTime.now().plusMinutes(5));
        user.setStatus(0); // Chưa kích hoạt
        if (user.getRoleid() <= 0) {
            user.setRoleid(0); // Mặc định role User
        }

        userDao.insert(user);
        EmailUtil.sendOtpEmail(user.getEmail(), otp, user.getFullname(), "Mã OTP kích hoạt tài khoản của bạn", "KÍCH HOẠT TÀI KHOẢN");
        return true;
    }

    @Override
    public int verifyOtp(String email, String otp) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return -2;
        }

        if (user.getStatus() == 1) {
            return 1;
        }

        if (user.getOtpCode() == null || !user.getOtpCode().trim().equals(otp.trim())) {
            return 0;
        }

        if (user.getOtpExpiryTime() == null || LocalDateTime.now().isAfter(user.getOtpExpiryTime())) {
            return -1;
        }

        user.setStatus(1);
        user.setOtpCode(null);
        user.setOtpExpiryTime(null);
        userDao.update(user);
        return 1;
    }

    @Override
    public boolean resendOtp(String email) {
        User user = userDao.findByEmail(email);
        if (user == null || user.getStatus() == 1) {
            return false;
        }

        String newOtp = EmailUtil.generateOtp();
        user.setOtpCode(newOtp);
        user.setOtpExpiryTime(LocalDateTime.now().plusMinutes(5));
        userDao.update(user);

        EmailUtil.sendOtpEmail(user.getEmail(), newOtp, user.getFullname(), "Mã OTP kích hoạt tài khoản của bạn", "KÍCH HOẠT TÀI KHOẢN");
        return true;
    }

    @Override
    public User login(String username, String password) {
        User user = userDao.findById(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public boolean sendForgotPasswordOtp(String email) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }

        String otp = EmailUtil.generateOtp();
        user.setOtpCode(otp);
        user.setOtpExpiryTime(LocalDateTime.now().plusMinutes(5));
        userDao.update(user);

        EmailUtil.sendOtpEmail(user.getEmail(), otp, user.getFullname(), "Mã OTP khôi phục mật khẩu của bạn", "KHÔI PHỤC MẬT KHẨU");
        return true;
    }

    @Override
    public int resetPassword(String email, String otp, String newPassword) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return -2;
        }

        if (user.getOtpCode() == null || !user.getOtpCode().trim().equals(otp.trim())) {
            return 0;
        }

        if (user.getOtpExpiryTime() == null || LocalDateTime.now().isAfter(user.getOtpExpiryTime())) {
            return -1;
        }

        user.setPassword(newPassword.trim());
        user.setOtpCode(null);
        user.setOtpExpiryTime(null);
        userDao.update(user);
        return 1;
    }

    @Override
    public User findById(String username) {
        return userDao.findById(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }
}