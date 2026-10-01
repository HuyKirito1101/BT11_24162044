package com.ngogiahuy.videoportal24162044.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.HexFormat;

public class RequestFilter_24162044 implements Filter {
    private final SecureRandom random = new SecureRandom();
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        if (!req.getServletPath().startsWith("/assets/")) {
            HttpSession session = req.getSession();
            if (session.getAttribute("csrf") == null) {
                byte[] bytes = new byte[24];
                random.nextBytes(bytes);
                session.setAttribute("csrf", HexFormat.of().formatHex(bytes));
            }
            if ("POST".equals(req.getMethod())
                    && !session.getAttribute("csrf").equals(req.getParameter("csrf"))) {
                resp.sendError(403, "Phiên biểu mẫu hết hạn. Hãy tải lại trang.");
                return;
            }
            Object flash = session.getAttribute("flash");
            if (flash != null) {
                req.setAttribute("message", flash);
                session.removeAttribute("flash");
            }
        }
        chain.doFilter(request, response);
    }
}
