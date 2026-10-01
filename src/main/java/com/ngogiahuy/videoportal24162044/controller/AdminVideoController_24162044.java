package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.entity.Video_24162044;
import com.ngogiahuy.videoportal24162044.service.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/videos/*")
public class AdminVideoController_24162044 extends BaseController_24162044 {
    private final VideoService_24162044 videos = new VideoServiceImpl_24162044();
    private final CategoryService_24162044 categories = new CategoryServiceImpl_24162044();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo() == null ? "/" : req.getPathInfo();
        switch (action) {
            case "/", "/list" -> {
                req.setAttribute("videoPage", videos.getAdminPage(page(req)));
                view(req, resp, "admin/videos/list.jsp");
            }
            case "/create", "/edit", "/detail" -> {
                Video_24162044 video;
                if ("/create".equals(action)) {
                    video = new Video_24162044();
                    video.setActive(true);
                } else {
                    video = videos.getById(id(req));
                    if (video == null) { resp.sendError(404); return; }
                }
                req.setAttribute("video", video);
                req.setAttribute("categories", categories.getAllCategories());
                view(req, resp, "/detail".equals(action) ? "user/detail.jsp" : "admin/videos/form.jsp");
            }
            case "/delete", "/save" -> resp.sendError(405);
            default -> resp.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if ("/delete".equals(action)) {
            if (videos.getById(id(req)) == null) { resp.sendError(404); return; }
            videos.delete(id(req));
            flash(req, "Đã xóa video và các lượt thích/chia sẻ liên quan.");
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
            return;
        }
        if (!"/save".equals(action)) { resp.sendError(404); return; }
        String rawId = req.getParameter("id");
        boolean isNew = rawId == null || rawId.isBlank();
        Video_24162044 video = isNew ? new Video_24162044() : videos.getById(id(req));
        if (video == null) { resp.sendError(404); return; }
        video.setTitle(req.getParameter("title"));
        video.setPoster(req.getParameter("poster"));
        video.setDescription(req.getParameter("description"));
        video.setActive("on".equals(req.getParameter("active")));
        try {
            if (isNew) {
                video.setViews(0);
            } else {
                String viewsStr = req.getParameter("views");
                if (viewsStr != null && !viewsStr.isBlank()) {
                    video.setViews(Integer.parseInt(viewsStr));
                }
            }
            videos.save(video, Integer.valueOf(req.getParameter("categoryId")));
            flash(req, "Đã lưu video thành công.");
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        } catch (IllegalArgumentException e) {
            resp.setStatus(400);
            req.setAttribute("error", e instanceof NumberFormatException
                    ? "Danh mục phải là số hợp lệ." : e.getMessage());
            req.setAttribute("video", video);
            req.setAttribute("categories", categories.getAllCategories());
            view(req, resp, "admin/videos/form.jsp");
        }
    }
}
