package com.ngogiahuy.videoportal24162044.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class Cart_24162044 implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final int MIN_QUANTITY = 1;
    public static final int MAX_QUANTITY = 10;

    private final Map<Integer, CartItem_24162044> items = new LinkedHashMap<>();

    public Cart_24162044() {}

    /**
     * Adds an item to cart or increases quantity within limits.
     * @param video The video/product to add
     * @param quantity The quantity to add
     * @return 0 if added normally, 1 if capped at MAX_QUANTITY, -1 if invalid
     */
    public int addItem(Video_24162044 video, int quantity) {
        if (video == null || video.getVideoId() == null) return -1;
        if (quantity < MIN_QUANTITY) quantity = MIN_QUANTITY;

        int videoId = video.getVideoId();
        CartItem_24162044 existing = items.get(videoId);
        int result = 0;

        if (existing != null) {
            int newQty = existing.getQuantity() + quantity;
            if (newQty > MAX_QUANTITY) {
                existing.setQuantity(MAX_QUANTITY);
                result = 1; // capped
            } else {
                existing.setQuantity(newQty);
            }
        } else {
            if (quantity > MAX_QUANTITY) {
                quantity = MAX_QUANTITY;
                result = 1; // capped
            }
            items.put(videoId, new CartItem_24162044(video, quantity));
        }
        return result;
    }

    /**
     * Updates item quantity within limits (MIN_QUANTITY to MAX_QUANTITY).
     * @param videoId Target video id
     * @param quantity New requested quantity
     * @return 0 if updated normally, 1 if capped at MAX_QUANTITY, 2 if adjusted to MIN_QUANTITY, -1 if item not found
     */
    public int updateQuantity(int videoId, int quantity) {
        CartItem_24162044 existing = items.get(videoId);
        if (existing == null) return -1;

        int result = 0;
        if (quantity > MAX_QUANTITY) {
            existing.setQuantity(MAX_QUANTITY);
            result = 1; // capped at max
        } else if (quantity < MIN_QUANTITY) {
            existing.setQuantity(MIN_QUANTITY);
            result = 2; // adjusted to min
        } else {
            existing.setQuantity(quantity);
        }
        return result;
    }

    public boolean removeItem(int videoId) {
        return items.remove(videoId) != null;
    }

    public void clear() {
        items.clear();
    }

    public List<CartItem_24162044> getItems() {
        return new ArrayList<>(items.values());
    }

    public int getItemCount() {
        return items.size();
    }

    public int getTotalQuantity() {
        return items.values().stream().mapToInt(CartItem_24162044::getQuantity).sum();
    }

    public double getTotalAmount() {
        return items.values().stream().mapToDouble(CartItem_24162044::getSubtotal).sum();
    }

    public String getFormattedTotalAmount() {
        return String.format("%,.0f đ", getTotalAmount()).replace(',', '.');
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}
