package com.ngogiahuy.videoportal24162044.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public abstract class BaseController_24162044 extends HttpServlet {
    protected void view(HttpServletRequest req, HttpServletResponse resp, String jsp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/" + jsp).forward(req, resp);
    }
    protected int page(HttpServletRequest req) { return page(req, "page"); }
    protected int page(HttpServletRequest req, String name) {
        try { return Math.max(1, Integer.parseInt(req.getParameter(name))); }
        catch (NumberFormatException e) { return 1; }
    }
    protected Integer id(HttpServletRequest req) {
        try { return Integer.valueOf(req.getParameter("id")); }
        catch (NumberFormatException e) { return null; }
    }
    protected void flash(HttpServletRequest req, String message) {
        req.getSession().setAttribute("flash", message);
    }
}
