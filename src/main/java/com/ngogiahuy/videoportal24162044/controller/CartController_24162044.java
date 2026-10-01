package com.ngogiahuy.videoportal24162044.controller;

import com.ngogiahuy.videoportal24162044.entity.Cart_24162044;
import com.ngogiahuy.videoportal24162044.service.CartService_24162044;
import com.ngogiahuy.videoportal24162044.service.CartServiceImpl_24162044;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/cart", "/cart/*"})
public class CartController_24162044 extends BaseController_24162044 {
    private final CartService_24162044 cartService = new CartServiceImpl_24162044();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cart_24162044 cart = cartService.getCart(req.getSession());
        req.setAttribute("cart", cart);
        view(req, resp, "user/cart.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null && req.getPathInfo() != null) {
            action = req.getPathInfo().replace("/", "");
        }
        if (action == null) action = "view";

        switch (action) {
            case "add" -> {
                Integer videoId = id(req);
                int quantity = 1;
                try {
                    String qParam = req.getParameter("quantity");
                    if (qParam != null && !qParam.isBlank()) {
                        quantity = Integer.parseInt(qParam);
                    }
                } catch (NumberFormatException ignored) {}

                int res = cartService.addToCart(req.getSession(), videoId, quantity);
                if (res == 1) {
                    flash(req, "Đã thêm vào giỏ hàng (Số lượng đã đạt giới hạn tối đa " + Cart_24162044.MAX_QUANTITY + " sản phẩm)!");
                } else if (res == 0) {
                    flash(req, "Đã thêm sản phẩm vào giỏ hàng thành công!");
                } else {
                    flash(req, "Không thể thêm sản phẩm vào giỏ hàng.");
                }

                if ("checkout".equalsIgnoreCase(req.getParameter("next"))) {
                    resp.sendRedirect(req.getContextPath() + "/checkout");
                    return;
                }

                String referer = req.getParameter("redirect");
                if (referer != null && !referer.isBlank()) {
                    resp.sendRedirect(referer);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/cart");
                }
            }
            case "update" -> {
                Integer videoId = id(req);
                int quantity = 1;
                try {
                    quantity = Integer.parseInt(req.getParameter("quantity"));
                } catch (NumberFormatException ignored) {}

                if (quantity <= 0) {
                    cartService.removeFromCart(req.getSession(), videoId);
                    flash(req, "Đã xóa sản phẩm khỏi giỏ hàng do số lượng bằng 0.");
                } else {
                    int res = cartService.updateQuantity(req.getSession(), videoId, quantity);
                    if (res == 1) {
                        flash(req, "Số lượng đã đạt giới hạn tối đa cho phép (" + Cart_24162044.MAX_QUANTITY + " sản phẩm)!");
                    } else if (res == 2) {
                        flash(req, "Số lượng tối thiểu là " + Cart_24162044.MIN_QUANTITY + " sản phẩm.");
                    } else {
                        flash(req, "Đã cập nhật số lượng thành công!");
                    }
                }
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
            case "remove" -> {
                Integer videoId = id(req);
                cartService.removeFromCart(req.getSession(), videoId);
                flash(req, "Đã xóa sản phẩm khỏi giỏ hàng.");
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
            case "clear" -> {
                cartService.clearCart(req.getSession());
                flash(req, "Đã làm trống giỏ hàng.");
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
            default -> resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}
