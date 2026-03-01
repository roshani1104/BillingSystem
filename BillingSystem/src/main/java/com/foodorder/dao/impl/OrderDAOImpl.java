package com.foodorder.dao.impl;

import com.foodorder.dao.OrderDAO;
import com.foodorder.db.DBConnection;
import com.foodorder.model.MenuItem;
import com.foodorder.model.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrderDAOImpl implements OrderDAO {

    private static final int MAX_QTY = 99;

    @Override
    public List<OrderItem> buildOrder(Map<String, String[]> params, List<MenuItem> menuItems) {
        List<OrderItem> orderItems = new ArrayList<>();

        for (MenuItem item : menuItems) {
            String[] values = params.get("item_" + item.getId());
            if (values == null || values[0].isBlank()) continue;

            int qty;
            try {
                qty = Integer.parseInt(values[0].trim());
            } catch (NumberFormatException e) {
                continue;
            }

            if (qty <= 0 || qty > MAX_QTY) continue;

            orderItems.add(new OrderItem(item.getName(), qty, item.getPrice()));
        }

        return orderItems;
    }

    @Override
    public int saveOrder(String ref, List<OrderItem> items,
                         double subtotal, double tax, double total) throws SQLException {

        String insertOrder = "INSERT INTO orders (ref, subtotal, tax, total) VALUES (?, ?, ?, ?)";
        String insertItem  = "INSERT INTO order_items (order_id, item_name, quantity, unit_price, line_total) " +
                             "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int orderId;
                try (PreparedStatement ps = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, ref);
                    ps.setDouble(2, subtotal);
                    ps.setDouble(3, tax);
                    ps.setDouble(4, total);
                    ps.executeUpdate();

                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        keys.next();
                        orderId = keys.getInt(1);
                    }
                }

                try (PreparedStatement ps = conn.prepareStatement(insertItem)) {
                    for (OrderItem item : items) {
                        ps.setInt(1, orderId);
                        ps.setString(2, item.getName());
                        ps.setInt(3, item.getQuantity());
                        ps.setDouble(4, item.getUnitPrice());
                        ps.setDouble(5, item.getLineTotal());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }

                conn.commit();
                return orderId;

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }
}
