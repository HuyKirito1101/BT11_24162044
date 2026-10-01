package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.Cart_24162044;
import com.ngogiahuy.videoportal24162044.entity.Video_24162044;
import com.ngogiahuy.videoportal24162044.repository.VideoRepository_24162044;
import jakarta.servlet.http.HttpSession;

public class CartServiceImpl_24162044 implements CartService_24162044 {
    private static final String CART_SESSION_KEY = "cart";
    private final VideoRepository_24162044 videoRepository = new VideoRepository_24162044();

    @Override
    public Cart_24162044 getCart(HttpSession session) {
        if (session == null) return new Cart_24162044();
        Cart_24162044 cart = (Cart_24162044) session.getAttribute(CART_SESSION_KEY);
        if (cart == null) {
            cart = new Cart_24162044();
            session.setAttribute(CART_SESSION_KEY, cart);
        }
        session.setAttribute("cartCount", cart.getTotalQuantity());
        return cart;
    }

    @Override
    public int addToCart(HttpSession session, Integer videoId, int quantity) {
        if (videoId == null || videoId <= 0) return -1;
        Video_24162044 video = videoRepository.findById(videoId);
        if (video == null || !video.isActive()) return -1;

        Cart_24162044 cart = getCart(session);
        int res = cart.addItem(video, quantity);
        session.setAttribute(CART_SESSION_KEY, cart);
        session.setAttribute("cartCount", cart.getTotalQuantity());
        return res;
    }

    @Override
    public int updateQuantity(HttpSession session, Integer videoId, int quantity) {
        if (videoId == null || videoId <= 0) return -1;
        Cart_24162044 cart = getCart(session);
        int res = cart.updateQuantity(videoId, quantity);
        session.setAttribute(CART_SESSION_KEY, cart);
        session.setAttribute("cartCount", cart.getTotalQuantity());
        return res;
    }

    @Override
    public boolean removeFromCart(HttpSession session, Integer videoId) {
        if (videoId == null || videoId <= 0) return false;
        Cart_24162044 cart = getCart(session);
        boolean removed = cart.removeItem(videoId);
        session.setAttribute(CART_SESSION_KEY, cart);
        session.setAttribute("cartCount", cart.getTotalQuantity());
        return removed;
    }

    @Override
    public void clearCart(HttpSession session) {
        if (session == null) return;
        Cart_24162044 cart = getCart(session);
        cart.clear();
        session.setAttribute(CART_SESSION_KEY, cart);
        session.setAttribute("cartCount", 0);
    }
}
