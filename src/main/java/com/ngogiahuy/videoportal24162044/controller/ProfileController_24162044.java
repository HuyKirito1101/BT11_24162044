package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import com.ngogiahuy.videoportal24162044.service.AuthService_24162044;
import com.ngogiahuy.videoportal24162044.service.AuthServiceImpl_24162044;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/account/profile")
public class ProfileController_24162044 extends BaseController_24162044 {
    private final AuthService_24162044 auth = new AuthServiceImpl_24162044();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User_24162044 currentUser = session == null ? null : (User_24162044) session.getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        view(req, resp, "user/profile.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User_24162044 currentUser = session == null ? null : (User_24162044) session.getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String images = req.getParameter("images");
        String newPassword = req.getParameter("newPassword");

        try {
            User_24162044 updatedUser = auth.updateProfile(currentUser.getUsername(), fullname, phone, images, newPassword);
            session.setAttribute("currentUser", updatedUser);
            req.setAttribute("message", "Cập nhật thông tin tài khoản thành công!");
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
        }
        view(req, resp, "user/profile.jsp");
    }
}
