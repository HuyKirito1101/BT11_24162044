package com.ngogiahuy.videoportal24162044.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "Favorites")
public class Favorite_24162044 {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "FavoriteId")
    private Integer favoriteId;
    @Column(name = "LikedDate")
    private LocalDate likedDate;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "VideoId")
    private Video_24162044 video;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "Username")
    private User_24162044 user;

    public Integer getFavoriteId() { return favoriteId; }
    public LocalDate getLikedDate() { return likedDate; }
    public void setLikedDate(LocalDate value) { likedDate = value; }
    public Video_24162044 getVideo() { return video; }
    public void setVideo(Video_24162044 value) { video = value; }
    public User_24162044 getUser() { return user; }
    public void setUser(User_24162044 value) { user = value; }
}
