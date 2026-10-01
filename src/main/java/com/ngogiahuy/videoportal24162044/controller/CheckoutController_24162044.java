package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.entity.Cart_24162044;
import com.ngogiahuy.videoportal24162044.entity.Order_24162044;
import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import com.ngogiahuy.videoportal24162044.service.CartService_24162044;
import com.ngogiahuy.videoportal24162044.service.CartServiceImpl_24162044;
import com.ngogiahuy.videoportal24162044.service.OrderService_24162044;
import com.ngogiahuy.videoportal24162044.service.OrderServiceImpl_24162044;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutController_24162044 extends BaseController_24162044 {
    private final CartService_24162044 cartService = new CartServiceImpl_24162044();
    private final OrderService_24162044 orderService = new OrderServiceImpl_24162044();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart_24162044 cart = cartService.getCart(session);
        if (cart == null || cart.isEmpty()) {
            flash(req, "Giỏ hàng đang trống. Vui lòng thêm sản phẩm trước khi thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        User_24162044 currentUser = (User_24162044) session.getAttribute("currentUser");
        if (currentUser != null) {
            if (req.getAttribute("customerName") == null) {
                req.setAttribute("customerName", currentUser.getFullname());
            }
            if (req.getAttribute("phone") == null) {
                req.setAttribute("phone", currentUser.getPhone());
            }
        }

        req.setAttribute("cart", cart);
        view(req, resp, "user/checkout.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart_24162044 cart = cartService.getCart(session);
        if (cart == null || cart.isEmpty()) {
            flash(req, "Giỏ hàng đang trống. Vui lòng thêm sản phẩm trước khi thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String customerName = req.getParameter("customerName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");
        String paymentMethod = req.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.isBlank()) {
            paymentMethod = "COD";
        }

        User_24162044 currentUser = (User_24162044) session.getAttribute("currentUser");

        try {
            Order_24162044 order = orderService.createCodOrder(cart, currentUser, customerName, phone, address, note);
            cartService.clearCart(session);
            resp.sendRedirect(req.getContextPath() + "/order/success?id=" + order.getOrderId());
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("customerName", customerName);
            req.setAttribute("phone", phone);
            req.setAttribute("address", address);
            req.setAttribute("note", note);
            req.setAttribute("cart", cart);
            view(req, resp, "user/checkout.jsp");
        }
    }
}
