package com.ngogiahuy.videoportal24162044.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class OtpDeliveryService_24162044 {
    private String config(String key, String fallback) {
        return System.getProperty(key, System.getenv().getOrDefault(key, fallback));
    }

    /** Sends real OTP email via Gmail SMTP by default. */
    public String send(String email, String otp) {
        String mode = config("OTP_DELIVERY_MODE", "smtp");
        if ("demo".equalsIgnoreCase(mode)) return otp;

        String host = config("SMTP_HOST", "smtp.gmail.com");
        String port = config("SMTP_PORT", "587");
        String user = config("SMTP_USER", "minhkhuyen779@gmail.com");
        String password = config("SMTP_PASSWORD", "ypmhxsnytdwstszy");
        String from = config("SMTP_FROM", user);

        Properties p = new Properties();
        p.setProperty("mail.smtp.host", host);
        p.setProperty("mail.smtp.port", port);
        p.setProperty("mail.smtp.auth", "true");
        p.setProperty("mail.smtp.starttls.enable", "true");
        p.setProperty("mail.smtp.starttls.required", "true");
        p.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        p.setProperty("mail.smtp.connectiontimeout", "15000");
        p.setProperty("mail.smtp.timeout", "15000");
        p.setProperty("mail.smtp.writetimeout", "15000");

        Session session = Session.getInstance(p, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from, "Video Portal"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Mã kích hoạt OTP - Video Portal", "UTF-8");
            message.setText("Xin chào,\n\nMã OTP kích hoạt tài khoản Video Portal của bạn là: " + otp + "\n\nMã này có hiệu lực trong vòng 5 phút.\n\nTrân trọng,\nVideo Portal", "UTF-8");
            Transport.send(message);
            return null;
        } catch (Exception e) {
            System.err.println("Gửi email thất bại: " + e.getMessage());
            throw new IllegalArgumentException("Không gửi được OTP đến email. Vui lòng kiểm tra lại địa chỉ email hoặc kết nối mạng.", e);
        }
    }
}
