package com.foodorder.dao;

import com.foodorder.model.MenuItem;
import com.foodorder.model.OrderItem;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface OrderDAO {

    /** Build an in-memory list of ordered items from submitted form params. */
    List<OrderItem> buildOrder(Map<String, String[]> params, List<MenuItem> menuItems);

    /** Persist the order to the database. Returns the generated order ID. */
    int saveOrder(String ref, List<OrderItem> items, double subtotal, double tax, double total)
            throws SQLException;
}
