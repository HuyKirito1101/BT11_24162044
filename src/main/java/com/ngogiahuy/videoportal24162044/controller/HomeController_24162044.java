package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.service.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/home", "/products"})
public class HomeController_24162044 extends BaseController_24162044 {
    private final CategoryService_24162044 categories = new CategoryServiceImpl_24162044();
    private final VideoService_24162044 videos = new VideoServiceImpl_24162044();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategorySection_24162044> sections = new ArrayList<>();
        for (var category : categories.getActiveCategories()) {
            sections.add(new CategorySection_24162044(category,
                    videos.getUserPage(category.getCategoryId(), page(req, "p_" + category.getCategoryId()))));
        }
        // Each category has its own page parameter. Keep all other categories on their current page.
        for (var section : sections) {
            StringBuilder base = new StringBuilder(req.getContextPath() + req.getServletPath() + "?");
            for (var other : sections) {
                if (other != section) base.append("p_").append(other.getCategory().getCategoryId())
                        .append("=").append(other.getVideoPage().getPage()).append("&");
            }
            String key = "p_" + section.getCategory().getCategoryId();
            for (int p = 1; p <= section.getVideoPage().getTotalPages(); p++) {
                section.getPageLinks().put(p, base + key + "=" + p + "#category-" + section.getCategory().getCategoryId());
            }
        }
        req.setAttribute("sections", sections);
        view(req, resp, "user/home.jsp");
    }
}
