package com.ngogiahuy.videoportal24162044.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
public class Order_24162044 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderId")
    private Integer orderId;

    @Column(name = "OrderDate", nullable = false)
    private LocalDateTime orderDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Username")
    private User_24162044 user;

    @Column(name = "CustomerName", nullable = false, length = 100)
    private String customerName;

    @Column(name = "Phone", nullable = false, length = 20)
    private String phone;

    @Column(name = "Address", nullable = false, length = 255)
    private String address;

    @Column(name = "Note", length = 500)
    private String note;

    @Column(name = "PaymentMethod", nullable = false, length = 50)
    private String paymentMethod = "COD";

    @Column(name = "Status", nullable = false, length = 50)
    private String status = "PENDING";

    @Column(name = "TotalAmount", nullable = false)
    private Double totalAmount = 0.0;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<OrderDetail_24162044> details = new ArrayList<>();

    public Order_24162044() {
        this.orderDate = LocalDateTime.now();
    }

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public LocalDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(LocalDateTime orderDate) { this.orderDate = orderDate; }

    public User_24162044 getUser() { return user; }
    public void setUser(User_24162044 user) { this.user = user; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Double getTotalAmount() { return totalAmount == null ? 0.0 : totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }

    public List<OrderDetail_24162044> getDetails() { return details; }
    public void setDetails(List<OrderDetail_24162044> details) { this.details = details; }

    public void addDetail(OrderDetail_24162044 detail) {
        details.add(detail);
        detail.setOrder(this);
    }

    public String getFormattedTotalAmount() {
        return String.format("%,.0f đ", getTotalAmount()).replace(',', '.');
    }

    public String getFormattedOrderDate() {
        if (orderDate == null) return "";
        return orderDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }

    public String getStatusDisplayName() {
        if ("PENDING".equalsIgnoreCase(status)) return "Chờ xử lý (COD)";
        if ("CONFIRMED".equalsIgnoreCase(status)) return "Đã xác nhận";
        if ("SHIPPING".equalsIgnoreCase(status)) return "Đang giao hàng";
        if ("COMPLETED".equalsIgnoreCase(status)) return "Hoàn thành";
        if ("CANCELLED".equalsIgnoreCase(status)) return "Đã hủy";
        return status;
    }
}
