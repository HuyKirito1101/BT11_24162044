package com.ngogiahuy.videoportal24162044.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity @Table(name = "Users")
public class User_24162044 {
    @Id @Column(name = "Username", length = 50) private String username;
    @Column(name = "Password", nullable = false) private String password;
    @Column(name = "Phone") private String phone;
    @Column(name = "Fullname") private String fullname;
    @Column(name = "Email") private String email;
    @Column(name = "Admin") private boolean admin;
    @Column(name = "Active") private boolean active;
    @Column(name = "Images") private String images;
    @Column(name = "OtpCode") private String otpCode;
    @Column(name = "OtpExpiresAt") private LocalDateTime otpExpiresAt;
    public String getUsername(){return username;} public void setUsername(String v){username=v;}
    public String getPassword(){return password;} public void setPassword(String v){password=v;}
    public String getPhone(){return phone;} public void setPhone(String v){phone=v;}
    public String getFullname(){return fullname;} public void setFullname(String v){fullname=v;}
    public String getEmail(){return email;} public void setEmail(String v){email=v;}
    public boolean isAdmin(){return admin;} public void setAdmin(boolean v){admin=v;}
    public boolean isActive(){return active;} public void setActive(boolean v){active=v;}
    public String getImages(){return images;} public void setImages(String v){images=v;}
    public String getOtpCode(){return otpCode;} public void setOtpCode(String v){otpCode=v;}
    public LocalDateTime getOtpExpiresAt(){return otpExpiresAt;} public void setOtpExpiresAt(LocalDateTime v){otpExpiresAt=v;}
}
