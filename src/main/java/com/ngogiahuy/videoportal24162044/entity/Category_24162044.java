package com.ngogiahuy.videoportal24162044.entity;

import jakarta.persistence.*;
import java.util.*;

@Entity @Table(name = "Category")
public class Category_24162044 {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "CategoryId") private Integer categoryId;
    @Column(name = "Categoryname") private String categoryname;
    @Column(name = "Categorycode") private String categorycode;
    @Column(name = "Images") private String images;
    @Column(name = "Status") private boolean status;
    @OneToMany(mappedBy = "category") private List<Video_24162044> videos = new ArrayList<>();
    public Integer getCategoryId(){return categoryId;} public void setCategoryId(Integer v){categoryId=v;}
    public String getCategoryname(){return categoryname;} public void setCategoryname(String v){categoryname=v;}
    public String getCategorycode(){return categorycode;} public void setCategorycode(String v){categorycode=v;}
    public String getImages(){return images;} public void setImages(String v){images=v;}
    public boolean isStatus(){return status;} public void setStatus(boolean v){status=v;}
    public List<Video_24162044> getVideos(){return videos;} public void setVideos(List<Video_24162044> v){videos=v;}
}
