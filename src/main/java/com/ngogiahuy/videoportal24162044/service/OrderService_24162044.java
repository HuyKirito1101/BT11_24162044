package com.ngogiahuy.videoportal24162044.service;

import com.ngogiahuy.videoportal24162044.entity.Cart_24162044;
import com.ngogiahuy.videoportal24162044.entity.Order_24162044;
import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import java.util.List;

public interface OrderService_24162044 {
    Order_24162044 createCodOrder(Cart_24162044 cart, User_24162044 user,
                                  String customerName, String phone,
                                  String address, String note);
    Order_24162044 getOrderById(Integer orderId);
    List<Order_24162044> getOrdersByUser(String username);
    List<Order_24162044> getAllOrders();
}
