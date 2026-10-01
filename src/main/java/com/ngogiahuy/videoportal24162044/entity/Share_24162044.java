package com.ngogiahuy.videoportal24162044.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "Shares")
public class Share_24162044 {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ShareId")
    private Integer shareId;
    @Column(name = "Emails", length = 50)
    private String emails;
    @Column(name = "SharedDate")
    private LocalDate sharedDate;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "VideoId")
    private Video_24162044 video;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "Username")
    private User_24162044 user;

    public Integer getShareId() { return shareId; }
    public String getEmails() { return emails; }
    public void setEmails(String value) { emails = value; }
    public LocalDate getSharedDate() { return sharedDate; }
    public void setSharedDate(LocalDate value) { sharedDate = value; }
    public Video_24162044 getVideo() { return video; }
    public void setVideo(Video_24162044 value) { video = value; }
    public User_24162044 getUser() { return user; }
    public void setUser(User_24162044 value) { user = value; }
}
