package com.foodorder.service.impl;

import com.foodorder.dao.MenuDAO;
import com.foodorder.model.MenuItem;
import com.foodorder.service.MenuService;

import java.sql.SQLException;
import java.util.List;

public class MenuServiceImpl implements MenuService {

    private final MenuDAO menuDAO;

    public MenuServiceImpl(MenuDAO menuDAO) {
        this.menuDAO = menuDAO;
    }

    @Override
    public List<String> getCategories() throws SQLException {
        return menuDAO.getCategories();
    }

    @Override
    public List<MenuItem> getItemsByCategory(String category) throws SQLException {
        return menuDAO.getItemsByCategory(category);
    }
}
