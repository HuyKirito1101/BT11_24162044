package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.*;
import com.ngogiahuy.videoportal24162044.repository.*;

public class VideoServiceImpl_24162044 implements VideoService_24162044 {
    private final VideoRepository_24162044 videoRepository = new VideoRepository_24162044();
    private final CategoryRepository_24162044 categoryRepository = new CategoryRepository_24162044();

    private int normalize(int page, long total, int size) {
        int last = Math.max(1, (int) Math.ceil((double) total / size));
        return Math.clamp(page, 1, last);
    }

    public PagedResult_24162044<Video_24162044> getAdminPage(int page) {
        long total = videoRepository.countAll();
        int current = normalize(page, total, 6);
        return new PagedResult_24162044<>(videoRepository.findPage(current, 6), current, 6, total);
    }

    public PagedResult_24162044<Video_24162044> getUserPage(Integer categoryId, int page) {
        long total = countByCategory(categoryId);
        int current = normalize(page, total, 3);
        return new PagedResult_24162044<>(videoRepository.findByCategoryPage(categoryId, current, 3),
                current, 3, total);
    }

    public Video_24162044 getById(Integer id) { return videoRepository.findById(id); }

    public Video_24162044 getPublicById(Integer id) {
        Video_24162044 video = getById(id);
        return video != null && video.isActive() && video.getCategory() != null
                && video.getCategory().isStatus() ? video : null;
    }

    @Override
    public Video_24162044 incrementViewsAndGet(Integer id) {
        Video_24162044 video = getPublicById(id);
        if (video != null) {
            videoRepository.incrementViews(id);
            video = getPublicById(id);
        }
        return video;
    }

    @Override
    public boolean isLikedByUser(Integer videoId, String username) {
        return videoRepository.isLikedByUser(videoId, username);
    }

    @Override
    public boolean toggleLike(Integer videoId, String username) {
        return videoRepository.toggleLike(videoId, username);
    }

    @Override
    public void shareVideo(Integer videoId, String username, String email) {
        if (email == null || email.isBlank() || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"))
            throw new IllegalArgumentException("Email chia sẻ không hợp lệ.");
        videoRepository.addShare(videoId, username, email.strip());
    }

    public void save(Video_24162044 video, Integer categoryId) {
        String title = video.getTitle() == null ? "" : video.getTitle().strip();
        if (title.isEmpty() || title.length() > 200)
            throw new IllegalArgumentException("Tiêu đề bắt buộc, tối đa 200 ký tự.");
        if (video.getViews() < 0) throw new IllegalArgumentException("Lượt xem không được âm.");
        String description = video.getDescription() == null ? "" : video.getDescription().strip();
        if (description.length() > 500) throw new IllegalArgumentException("Mô tả tối đa 500 ký tự.");
        String poster = video.getPoster() == null ? "" : video.getPoster().strip();
        if (!poster.isEmpty() && (poster.length() > 500
                || !poster.matches("(?i)^https?://[^\\s]+$")))
            throw new IllegalArgumentException("Poster phải là URL http/https, tối đa 500 ký tự.");
        Category_24162044 category = categoryId == null ? null : categoryRepository.findById(categoryId);
        if (category == null) throw new IllegalArgumentException("Hãy chọn danh mục hợp lệ.");
        video.setTitle(title);
        video.setDescription(description);
        video.setPoster(poster);
        video.setCategory(category);
        videoRepository.save(video);
    }

    public void delete(Integer id) {
        if (id == null || id <= 0) throw new IllegalArgumentException("Mã video không hợp lệ.");
        videoRepository.delete(id);
    }

    public long countByCategory(Integer id) { return videoRepository.countByCategory(id); }
}
