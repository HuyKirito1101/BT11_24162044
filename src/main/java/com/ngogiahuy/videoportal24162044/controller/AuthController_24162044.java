package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import com.ngogiahuy.videoportal24162044.service.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth/*")
public class AuthController_24162044 extends BaseController_24162044 {
    private final AuthService_24162044 auth = new AuthServiceImpl_24162044();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo() == null ? "/login" : req.getPathInfo();
        if ("/logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        if ("/login".equals(action) && req.getSession().getAttribute("currentUser") != null) {
            User_24162044 user = (User_24162044) req.getSession().getAttribute("currentUser");
            resp.sendRedirect(req.getContextPath() + (user.isAdmin() ? "/admin/home" : "/home"));
            return;
        }
        switch (action) {
            case "/login" -> view(req, resp, "auth/login.jsp");
            case "/register" -> view(req, resp, "auth/register.jsp");
            case "/verify" -> {
                if (req.getSession().getAttribute("pendingUsername") == null) {
                    resp.sendRedirect(req.getContextPath() + "/auth/register");
                    return;
                }
                view(req, resp, "auth/verify.jsp");
            }
            default -> resp.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        try {
            switch (action == null ? "" : action) {
                case "/register" -> register(req, resp);
                case "/verify" -> verify(req, resp);
                case "/resend" -> resend(req, resp);
                case "/login" -> login(req, resp);
                default -> resp.sendError(404);
            }
        } catch (IllegalArgumentException e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            String page = "/register".equals(action) ? "auth/register.jsp"
                    : "/login".equals(action) ? "auth/login.jsp" : "auth/verify.jsp";
            view(req, resp, page);
        }
    }

    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User_24162044 user = new User_24162044();
        user.setUsername(req.getParameter("username"));
        user.setPassword(req.getParameter("password"));
        user.setFullname(req.getParameter("fullname"));
        user.setEmail(req.getParameter("email"));
        user.setPhone(req.getParameter("phone"));
        String demoOtp = auth.register(user);
        req.getSession().setAttribute("pendingUsername", user.getUsername());
        req.setAttribute("message", demoOtp == null ? "OTP đã được gửi đến email của bạn."
                : "Chế độ demo - mã OTP của bạn: " + demoOtp);
        view(req, resp, "auth/verify.jsp");
    }

    private void verify(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = (String) req.getSession().getAttribute("pendingUsername");
        if (!auth.verifyOtp(username, req.getParameter("otp"))) {
            req.setAttribute("error", "OTP sai hoặc đã hết hạn.");
            view(req, resp, "auth/verify.jsp");
            return;
        }
        req.getSession().removeAttribute("pendingUsername");
        flash(req, "Kích hoạt thành công. Hãy đăng nhập.");
        resp.sendRedirect(req.getContextPath() + "/auth/login");
    }

    private void resend(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String demoOtp = auth.resendOtp((String) req.getSession().getAttribute("pendingUsername"));
        req.setAttribute("message", demoOtp == null ? "Đã gửi lại OTP đến email của bạn."
                : "Mã OTP demo mới: " + demoOtp);
        view(req, resp, "auth/verify.jsp");
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User_24162044 user = auth.login(req.getParameter("username"), req.getParameter("password"));
        if (user == null) {
            req.setAttribute("error", "Sai tài khoản, mật khẩu hoặc tài khoản chưa kích hoạt.");
            view(req, resp, "auth/login.jsp");
            return;
        }
        req.changeSessionId();
        req.getSession().setAttribute("currentUser", user);
        resp.sendRedirect(req.getContextPath() + (user.isAdmin() ? "/admin/home" : "/home"));
    }
}
