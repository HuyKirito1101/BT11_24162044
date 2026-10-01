package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import com.ngogiahuy.videoportal24162044.service.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/video")
public class VideoDetailController_24162044 extends BaseController_24162044 {
    private final VideoService_24162044 videos = new VideoServiceImpl_24162044();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer videoId = id(req);
        var video = videos.incrementViewsAndGet(videoId);
        if (video == null) { resp.sendError(404, "Video không tồn tại hoặc đã ẩn."); return; }

        HttpSession session = req.getSession(false);
        User_24162044 currentUser = session == null ? null : (User_24162044) session.getAttribute("currentUser");
        boolean isLiked = currentUser != null && videos.isLikedByUser(video.getVideoId(), currentUser.getUsername());

        req.setAttribute("video", video);
        req.setAttribute("isLiked", isLiked);
        view(req, resp, "user/detail.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer videoId = id(req);
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        User_24162044 currentUser = session == null ? null : (User_24162044) session.getAttribute("currentUser");

        if ("like".equals(action)) {
            if (currentUser == null) {
                resp.sendRedirect(req.getContextPath() + "/auth/login");
                return;
            }
            videos.toggleLike(videoId, currentUser.getUsername());
            resp.sendRedirect(req.getContextPath() + "/video?id=" + videoId);
            return;
        }

        if ("share".equals(action)) {
            String email = req.getParameter("email");
            try {
                videos.shareVideo(videoId, currentUser != null ? currentUser.getUsername() : null, email);
                flash(req, "Đã lưu lượt chia sẻ video thành công!");
            } catch (IllegalArgumentException e) {
                flash(req, e.getMessage());
            }
            resp.sendRedirect(req.getContextPath() + "/video?id=" + videoId);
            return;
        }

        resp.sendError(400);
    }
}
