package com.foodorder.dao.impl;

import com.foodorder.dao.MenuDAO;
import com.foodorder.db.DBConnection;
import com.foodorder.model.MenuItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public List<String> getCategories() throws SQLException {
        String sql = "SELECT DISTINCT category FROM menu_items "
                   + "ORDER BY FIELD(category,"
                   + "'Breakfast','North Indian','South Indian','Chinese',"
                   + "'Pizza','Burgers','Sandwiches','Italian',"
                   + "'Salads','Healthy Bowls','Desserts','Beverages')";

        List<String> categories = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) categories.add(rs.getString("category"));
        }
        return categories;
    }

    @Override
    public List<MenuItem> getItemsByCategory(String category) throws SQLException {
        String sql = "SELECT id, name, category, price FROM menu_items WHERE category = ? ORDER BY id";
        List<MenuItem> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(new MenuItem(rs.getInt("id"), rs.getString("name"),
                                          rs.getString("category"), rs.getDouble("price")));
                }
            }
        }
        return items;
    }

    @Override
    public List<MenuItem> getAllItems() throws SQLException {
        String sql = "SELECT id, name, category, price FROM menu_items ORDER BY id";
        List<MenuItem> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                items.add(new MenuItem(rs.getInt("id"), rs.getString("name"),
                                       rs.getString("category"), rs.getDouble("price")));
            }
        }
        return items;
    }
}
