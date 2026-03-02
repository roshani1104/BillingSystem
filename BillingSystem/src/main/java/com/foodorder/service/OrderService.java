package com.foodorder.service;

import com.foodorder.model.OrderItem;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface OrderService {

    List<OrderItem> placeOrder(Map<String, String[]> params) throws SQLException;

    /** Save the order to DB and return a reference struct with ref + orderId. */
    OrderResult saveOrder(List<OrderItem> items, double subtotal, double tax, double total)
            throws SQLException;

    double calculateSubtotal(List<OrderItem> items);
    double calculateTax(double subtotal);
    double calculateTotal(double subtotal, double tax);

    record OrderResult(String ref, int orderId) {}
}
