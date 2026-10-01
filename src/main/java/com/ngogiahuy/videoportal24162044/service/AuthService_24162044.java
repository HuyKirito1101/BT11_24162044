package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.User_24162044;

public interface AuthService_24162044 {
    String register(User_24162044 user);
    String resendOtp(String username);
    boolean verifyOtp(String username, String otp);
    User_24162044 login(String username, String password);
    User_24162044 updateProfile(String username, String fullname, String phone, String images, String newPassword);
}
