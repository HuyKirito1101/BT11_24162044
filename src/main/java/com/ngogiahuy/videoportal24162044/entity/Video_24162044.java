package com.ngogiahuy.videoportal24162044.entity;

import jakarta.persistence.*;

@Entity @Table(name = "Videos")
public class Video_24162044 {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "VideoId") private Integer videoId;
    @Column(name = "Title") private String title;
    @Column(name = "Poster") private String poster;
    @Column(name = "Views") private int views;
    @Column(name = "Description") private String description;
    @Column(name = "Active") private boolean active;
    @Column(name = "Price") private Double price = 150000.0;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "CategoryId") private Category_24162044 category;
    @Transient private long likeCount;
    @Transient private long shareCount;
    public long getLikeCount() { return likeCount; }
    public void setLikeCount(long value) { likeCount = value; }
    public long getShareCount() { return shareCount; }
    public void setShareCount(long value) { shareCount = value; }
    public Double getPrice() { return price == null ? 150000.0 : price; }
    public void setPrice(Double price) { this.price = price; }
    public String getFormattedPrice() {
        return String.format("%,.0f đ", getPrice()).replace(',', '.');
    }
    public Integer getVideoId(){return videoId;} public void setVideoId(Integer v){videoId=v;}
    public String getTitle(){return title;} public void setTitle(String v){title=v;}
    public String getPoster(){return poster;} public void setPoster(String v){poster=v;}
    public int getViews(){return views;} public void setViews(int v){views=v;}
    public String getDescription(){return description;} public void setDescription(String v){description=v;}
    public boolean isActive(){return active;} public void setActive(boolean v){active=v;}
    public Category_24162044 getCategory(){return category;} public void setCategory(Category_24162044 v){category=v;}
}
