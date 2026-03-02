package com.foodorder.service;

import com.foodorder.model.MenuItem;

import java.sql.SQLException;
import java.util.List;

public interface MenuService {

    List<String> getCategories() throws SQLException;

    List<MenuItem> getItemsByCategory(String category) throws SQLException;
}
