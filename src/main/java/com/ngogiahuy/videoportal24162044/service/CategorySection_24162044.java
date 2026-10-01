package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class CategorySection_24162044 {
    private final Category_24162044 category;
    private final PagedResult_24162044<Video_24162044> videoPage;
    private final Map<Integer, String> pageLinks = new LinkedHashMap<>();

    public CategorySection_24162044(Category_24162044 category,
            PagedResult_24162044<Video_24162044> videoPage) {
        this.category = category;
        this.videoPage = videoPage;
    }
    public Category_24162044 getCategory() { return category; }
    public PagedResult_24162044<Video_24162044> getVideoPage() { return videoPage; }
    public Map<Integer, String> getPageLinks() { return pageLinks; }
    public String getPreviousUrl() { return pageLinks.get(Math.max(1, videoPage.getPage() - 1)); }
    public String getNextUrl() { return pageLinks.get(Math.min(videoPage.getTotalPages(), videoPage.getPage() + 1)); }
}
