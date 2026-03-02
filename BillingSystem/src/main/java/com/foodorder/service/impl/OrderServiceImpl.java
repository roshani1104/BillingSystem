package com.foodorder.service.impl;

import com.foodorder.dao.MenuDAO;
import com.foodorder.dao.OrderDAO;
import com.foodorder.model.MenuItem;
import com.foodorder.model.OrderItem;
import com.foodorder.service.OrderService;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class OrderServiceImpl implements OrderService {

    private static final double TAX_RATE = 0.10;

    private final MenuDAO menuDAO;
    private final OrderDAO orderDAO;

    public OrderServiceImpl(MenuDAO menuDAO, OrderDAO orderDAO) {
        this.menuDAO  = menuDAO;
        this.orderDAO = orderDAO;
    }

    @Override
    public List<OrderItem> placeOrder(Map<String, String[]> params) throws SQLException {
        List<MenuItem> allMenuItems = menuDAO.getAllItems();
        return orderDAO.buildOrder(params, allMenuItems);
    }

    @Override
    public OrderResult saveOrder(List<OrderItem> items,
                                 double subtotal, double tax, double total) throws SQLException {
        String ref = "ORD-" + UUID.randomUUID().toString()
                                  .replace("-", "")
                                  .substring(0, 8)
                                  .toUpperCase();
        int orderId = orderDAO.saveOrder(ref, items, subtotal, tax, total);
        return new OrderResult(ref, orderId);
    }

    @Override
    public double calculateSubtotal(List<OrderItem> items) {
        return items.stream().mapToDouble(OrderItem::getLineTotal).sum();
    }

    @Override
    public double calculateTax(double subtotal) {
        return subtotal * TAX_RATE;
    }

    @Override
    public double calculateTotal(double subtotal, double tax) {
        return subtotal + tax;
    }
}
