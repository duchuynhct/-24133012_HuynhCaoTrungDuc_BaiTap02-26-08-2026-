package trungduc.vn.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT u FROM User u"),
    @NamedQuery(name = "User.findByEmail", query = "SELECT u FROM User u WHERE u.email = :email")
})
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "username", length = 50, nullable = false)
    private String username;

    @Column(name = "password", length = 200, nullable = false)
    private String password;

    @Column(name = "email", length = 100, nullable = false, unique = true)
    private String email;

    @Column(name = "fullname", columnDefinition = "nvarchar(100) not null")
    private String fullname;

    @Column(name = "phone", columnDefinition = "nvarchar(20) null")
    private String phone;

    @Column(name = "avatar", columnDefinition = "nvarchar(500) null")
    private String avatar;

    @Column(name = "status", nullable = false)
    private int status; // 0: Chua kich hoat (Inactive), 1: Da kich hoat (Active)

    @Column(name = "otp_code", length = 10, nullable = true)
    private String otpCode;

    @Column(name = "otp_expiry_time", nullable = true)
    private LocalDateTime otpExpiryTime;

    @Column(name = "roleid", nullable = false)
    private int roleid; // 0: User, 1: Admin

    public User() {
    }

    public User(String username, String password, String email, String fullname, String avatar, int status,
                String otpCode, LocalDateTime otpExpiryTime, int roleid) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullname = fullname;
        this.avatar = avatar;
        this.status = status;
        this.otpCode = otpCode;
        this.otpExpiryTime = otpExpiryTime;
        this.roleid = roleid;
    }

    public User(String username, String password, String email, String fullname, String phone, String avatar, int status,
                String otpCode, LocalDateTime otpExpiryTime, int roleid) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.avatar = avatar;
        this.status = status;
        this.otpCode = otpCode;
        this.otpExpiryTime = otpExpiryTime;
        this.roleid = roleid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    // Alias getter/setter cho images trỏ tới avatar
    public String getImages() {
        return avatar;
    }

    public void setImages(String images) {
        this.avatar = images;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getOtpCode() {
        return otpCode;
    }

    public void setOtpCode(String otpCode) {
        this.otpCode = otpCode;
    }

    public LocalDateTime getOtpExpiryTime() {
        return otpExpiryTime;
    }

    public void setOtpExpiryTime(LocalDateTime otpExpiryTime) {
        this.otpExpiryTime = otpExpiryTime;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }
}