package com.ngogiahuy.videoportal24162044.entity;

import java.io.Serializable;

public class CartItem_24162044 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Video_24162044 video;
    private int quantity;

    public CartItem_24162044() {}

    public CartItem_24162044(Video_24162044 video, int quantity) {
        this.video = video;
        this.quantity = quantity;
    }

    public Video_24162044 getVideo() { return video; }
    public void setVideo(Video_24162044 video) { this.video = video; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() {
        return video != null ? video.getPrice() : 0.0;
    }

    public double getSubtotal() {
        return getPrice() * quantity;
    }

    public String getFormattedPrice() {
        return String.format("%,.0f đ", getPrice()).replace(',', '.');
    }

    public String getFormattedSubtotal() {
        return String.format("%,.0f đ", getSubtotal()).replace(',', '.');
    }
}
