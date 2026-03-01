package com.foodorder.dao;

import com.foodorder.model.MenuItem;

import java.sql.SQLException;
import java.util.List;

public interface MenuDAO {

    List<String> getCategories() throws SQLException;

    List<MenuItem> getItemsByCategory(String category) throws SQLException;

    List<MenuItem> getAllItems() throws SQLException;
}
