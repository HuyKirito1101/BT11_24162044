package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.service.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({"/admin", "/admin/", "/admin/home"})
public class AdminHomeController_24162044 extends BaseController_24162044 {
    private final VideoService_24162044 videos = new VideoServiceImpl_24162044();
    private final CategoryService_24162044 categories = new CategoryServiceImpl_24162044();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("videoTotal", videos.getAdminPage(1).getTotalItems());
        req.setAttribute("categoryTotal", categories.getAllCategories().size());
        view(req, resp, "admin/home.jsp");
    }
}
