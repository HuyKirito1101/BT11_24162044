package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.Video_24162044;

public interface VideoService_24162044 {
    PagedResult_24162044<Video_24162044> getAdminPage(int page);
    PagedResult_24162044<Video_24162044> getUserPage(Integer categoryId, int page);
    Video_24162044 getById(Integer id);
    Video_24162044 getPublicById(Integer id);
    Video_24162044 incrementViewsAndGet(Integer id);
    boolean isLikedByUser(Integer videoId, String username);
    boolean toggleLike(Integer videoId, String username);
    void shareVideo(Integer videoId, String username, String email);
    void save(Video_24162044 video, Integer categoryId);
    void delete(Integer id);
    long countByCategory(Integer categoryId);
}
