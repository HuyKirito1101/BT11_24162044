package com.ngogiahuy.videoportal24162044.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "order_details")
public class OrderDetail_24162044 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderDetailId")
    private Integer orderDetailId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "OrderId", nullable = false)
    private Order_24162044 order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "VideoId")
    private Video_24162044 video;

    @Column(name = "Price", nullable = false)
    private Double price = 0.0;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity = 1;

    @Column(name = "Subtotal", nullable = false)
    private Double subtotal = 0.0;

    public OrderDetail_24162044() {}

    public OrderDetail_24162044(Order_24162044 order, Video_24162044 video, Double price, Integer quantity) {
        this.order = order;
        this.video = video;
        this.price = price;
        this.quantity = quantity;
        this.subtotal = (price != null ? price : 0.0) * (quantity != null ? quantity : 1);
    }

    public Integer getOrderDetailId() { return orderDetailId; }
    public void setOrderDetailId(Integer orderDetailId) { this.orderDetailId = orderDetailId; }

    public Order_24162044 getOrder() { return order; }
    public void setOrder(Order_24162044 order) { this.order = order; }

    public Video_24162044 getVideo() { return video; }
    public void setVideo(Video_24162044 video) { this.video = video; }

    public Double getPrice() { return price == null ? 0.0 : price; }
    public void setPrice(Double price) {
        this.price = price;
        calculateSubtotal();
    }

    public Integer getQuantity() { return quantity == null ? 0 : quantity; }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
        calculateSubtotal();
    }

    public Double getSubtotal() { return subtotal == null ? 0.0 : subtotal; }
    public void setSubtotal(Double subtotal) { this.subtotal = subtotal; }

    public void calculateSubtotal() {
        this.subtotal = getPrice() * getQuantity();
    }

    public String getFormattedPrice() {
        return String.format("%,.0f đ", getPrice()).replace(',', '.');
    }

    public String getFormattedSubtotal() {
        return String.format("%,.0f đ", getSubtotal()).replace(',', '.');
    }
}
