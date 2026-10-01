package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AdminAuthorizationFilter_24162044 implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        User_24162044 user = session == null ? null : (User_24162044) session.getAttribute("currentUser");
        if (user == null || !user.isAdmin() || !user.isActive()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        resp.setHeader("Cache-Control", "no-store");
        chain.doFilter(request, response);
    }
}
