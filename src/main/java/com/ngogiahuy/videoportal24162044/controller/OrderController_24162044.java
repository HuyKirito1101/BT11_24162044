package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.entity.Order_24162044;
import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import com.ngogiahuy.videoportal24162044.service.OrderService_24162044;
import com.ngogiahuy.videoportal24162044.service.OrderServiceImpl_24162044;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/orders", "/order/success", "/order/detail"})
public class OrderController_24162044 extends BaseController_24162044 {
    private final OrderService_24162044 orderService = new OrderServiceImpl_24162044();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        HttpSession session = req.getSession(false);
        User_24162044 currentUser = session == null ? null : (User_24162044) session.getAttribute("currentUser");

        if ("/order/success".equals(servletPath)) {
            Integer orderId = id(req);
            if (orderId == null) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }
            Order_24162044 order = orderService.getOrderById(orderId);
            if (order == null) {
                resp.sendError(404, "Không tìm thấy đơn hàng.");
                return;
            }
            req.setAttribute("order", order);
            view(req, resp, "user/order-success.jsp");
            return;
        }

        if ("/order/detail".equals(servletPath)) {
            Integer orderId = id(req);
            if (orderId == null) {
                resp.sendRedirect(req.getContextPath() + "/orders");
                return;
            }
            Order_24162044 order = orderService.getOrderById(orderId);
            if (order == null) {
                resp.sendError(404, "Không tìm thấy đơn hàng.");
                return;
            }
            // If logged in, check permission (or admin)
            if (order.getUser() != null && (currentUser == null || (!currentUser.isAdmin() && !order.getUser().getUsername().equals(currentUser.getUsername())))) {
                resp.sendError(403, "Bạn không có quyền xem đơn hàng này.");
                return;
            }
            req.setAttribute("order", order);
            view(req, resp, "user/order-detail.jsp");
            return;
        }

        // /orders (Order History)
        if (currentUser == null) {
            flash(req, "Vui lòng đăng nhập để xem lịch sử đơn hàng của bạn.");
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String statusParam = req.getParameter("status");
        if (statusParam == null || statusParam.isBlank()) {
            statusParam = "ALL";
        } else {
            statusParam = statusParam.trim().toUpperCase();
        }

        List<Order_24162044> orders = orderService.getOrdersByUserAndStatus(currentUser.getUsername(), statusParam);
        java.util.Map<String, Long> statusCounts = orderService.countOrdersByStatusForUser(currentUser.getUsername());

        req.setAttribute("orders", orders);
        req.setAttribute("selectedStatus", statusParam);
        req.setAttribute("statusCounts", statusCounts);
        req.setAttribute("statuses", com.ngogiahuy.videoportal24162044.entity.OrderStatus_24162044.values());
        view(req, resp, "user/orders.jsp");
    }
}
