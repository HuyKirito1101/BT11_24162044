package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import com.ngogiahuy.videoportal24162044.repository.UserRepository_24162044;
import java.security.SecureRandom;
import java.time.LocalDateTime;

public class AuthServiceImpl_24162044 implements AuthService_24162044 {
    private final UserRepository_24162044 users = new UserRepository_24162044();
    private final OtpDeliveryService_24162044 delivery = new OtpDeliveryService_24162044();

    @Override
    public String register(User_24162044 user) {
        if (user.getUsername() == null || !user.getUsername().matches("[A-Za-z0-9_]{3,50}"))
            throw new IllegalArgumentException("Username gồm 3-50 chữ không dấu, số hoặc dấu gạch dưới.");
        if (user.getPassword() == null || user.getPassword().length() < 6 || user.getPassword().length() > 128)
            throw new IllegalArgumentException("Mật khẩu phải có 6-128 ký tự.");
        if (user.getFullname() == null || user.getFullname().isBlank() || user.getFullname().length() > 50)
            throw new IllegalArgumentException("Họ tên bắt buộc, tối đa 50 ký tự.");
        if (user.getEmail() == null || user.getEmail().length() > 150
                || !user.getEmail().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"))
            throw new IllegalArgumentException("Email không hợp lệ.");
        if (user.getPhone() != null && !user.getPhone().isBlank() && !user.getPhone().matches("[+0-9 .()-]{7,15}"))
            throw new IllegalArgumentException("Số điện thoại không hợp lệ.");
        if (users.findByUsername(user.getUsername()) != null)
            throw new IllegalArgumentException("Username đã tồn tại.");
        if (users.findByEmail(user.getEmail()) != null)
            throw new IllegalArgumentException("Email đã tồn tại.");
        String otp = String.format("%06d", new SecureRandom().nextInt(1_000_000));
        user.setPassword(PasswordService_24162044.hash(user.getPassword()));
        user.setAdmin(false);
        user.setActive(false);
        user.setOtpCode(otp);
        user.setOtpExpiresAt(LocalDateTime.now().plusMinutes(5));
        String demoCode = delivery.send(user.getEmail(), otp);
        users.save(user);
        return demoCode;
    }

    @Override
    public boolean verifyOtp(String username, String otp) {
        if (username == null || otp == null || !otp.matches("[0-9]{6}")) return false;
        return users.activate(username, otp);
    }

    @Override
    public String resendOtp(String username) {
        User_24162044 user = username == null ? null : users.findByUsername(username);
        if (user == null || user.isActive()) throw new IllegalArgumentException("Không có tài khoản chờ kích hoạt.");
        String otp = String.format("%06d", new SecureRandom().nextInt(1_000_000));
        String demoCode = delivery.send(user.getEmail(), otp);
        user.setOtpCode(otp);
        user.setOtpExpiresAt(LocalDateTime.now().plusMinutes(5));
        users.save(user);
        return demoCode;
    }

    @Override
    public User_24162044 login(String username, String password) {
        User_24162044 user = username == null ? null : users.findByUsername(username);
        return user != null && user.isActive() && PasswordService_24162044.matches(password, user.getPassword())
                ? user : null;
    }

    @Override
    public User_24162044 updateProfile(String username, String fullname, String phone, String images, String newPassword) {
        User_24162044 user = username == null ? null : users.findByUsername(username);
        if (user == null) throw new IllegalArgumentException("Tài khoản không tồn tại.");
        if (fullname == null || fullname.isBlank() || fullname.length() > 50)
            throw new IllegalArgumentException("Họ tên bắt buộc, tối đa 50 ký tự.");
        if (phone != null && !phone.isBlank() && !phone.matches("[+0-9 .()-]{7,15}"))
            throw new IllegalArgumentException("Số điện thoại không hợp lệ.");
        if (images != null && !images.isBlank() && images.length() > 500)
            throw new IllegalArgumentException("Đường dẫn ảnh tối đa 500 ký tự.");
        
        user.setFullname(fullname.strip());
        user.setPhone(phone == null ? "" : phone.strip());
        user.setImages(images == null ? "" : images.strip());
        if (newPassword != null && !newPassword.isBlank()) {
            if (newPassword.length() < 6 || newPassword.length() > 128)
                throw new IllegalArgumentException("Mật khẩu mới phải có 6-128 ký tự.");
            user.setPassword(PasswordService_24162044.hash(newPassword));
        }
        users.save(user);
        return user;
    }
}
