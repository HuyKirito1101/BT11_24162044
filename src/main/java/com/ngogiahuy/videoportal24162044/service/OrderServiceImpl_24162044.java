package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.*;
import com.ngogiahuy.videoportal24162044.repository.OrderRepository_24162044;
import java.time.LocalDateTime;
import java.util.List;

public class OrderServiceImpl_24162044 implements OrderService_24162044 {
    private final OrderRepository_24162044 orderRepository = new OrderRepository_24162044();

    @Override
    public Order_24162044 createCodOrder(Cart_24162044 cart, User_24162044 user,
                                         String customerName, String phone,
                                         String address, String note) {
        if (cart == null || cart.isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng đang trống, không thể tạo đơn hàng.");
        }
        if (customerName == null || customerName.strip().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập họ tên người nhận.");
        }
        if (customerName.strip().length() > 100) {
            throw new IllegalArgumentException("Họ tên người nhận không được vượt quá 100 ký tự.");
        }
        if (phone == null || phone.strip().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập số điện thoại nhận hàng.");
        }
        String cleanPhone = phone.strip();
        if (!cleanPhone.matches("^(0|\\+84)[0-9]{9,10}$")) {
            throw new IllegalArgumentException("Số điện thoại không hợp lệ (từ 10 đến 11 số).");
        }
        if (address == null || address.strip().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập địa chỉ giao hàng.");
        }
        if (address.strip().length() > 255) {
            throw new IllegalArgumentException("Địa chỉ giao hàng không được vượt quá 255 ký tự.");
        }
        if (note != null && note.strip().length() > 500) {
            throw new IllegalArgumentException("Ghi chú đơn hàng tối đa 500 ký tự.");
        }

        Order_24162044 order = new Order_24162044();
        order.setOrderDate(LocalDateTime.now());
        order.setUser(user);
        order.setCustomerName(customerName.strip());
        order.setPhone(cleanPhone);
        order.setAddress(address.strip());
        order.setNote(note != null ? note.strip() : null);
        order.setPaymentMethod("COD");
        order.setStatus("PENDING");
        order.setTotalAmount(cart.getTotalAmount());

        for (CartItem_24162044 item : cart.getItems()) {
            OrderDetail_24162044 detail = new OrderDetail_24162044();
            detail.setOrder(order);
            detail.setVideo(item.getVideo());
            detail.setPrice(item.getVideo().getPrice());
            detail.setQuantity(item.getQuantity());
            detail.setSubtotal(item.getSubtotal());
            order.addDetail(detail);
        }

        orderRepository.save(order);
        return order;
    }

    @Override
    public Order_24162044 getOrderById(Integer orderId) {
        return orderRepository.findById(orderId);
    }

    @Override
    public List<Order_24162044> getOrdersByUser(String username) {
        return orderRepository.findByUsername(username);
    }

    @Override
    public List<Order_24162044> getAllOrders() {
        return orderRepository.findAll();
    }
}
