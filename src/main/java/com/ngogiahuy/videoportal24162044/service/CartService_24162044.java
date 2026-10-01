package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.Cart_24162044;
import jakarta.servlet.http.HttpSession;

public interface CartService_24162044 {
    Cart_24162044 getCart(HttpSession session);
    int addToCart(HttpSession session, Integer videoId, int quantity);
    int updateQuantity(HttpSession session, Integer videoId, int quantity);
    boolean removeFromCart(HttpSession session, Integer videoId);
    void clearCart(HttpSession session);
}
