package com.foodorder.servlet;

import com.foodorder.dao.MenuDAO;
import com.foodorder.dao.impl.MenuDAOImpl;
import com.foodorder.model.MenuItem;
import com.foodorder.service.MenuService;
import com.foodorder.service.impl.MenuServiceImpl;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private static final Gson gson = new Gson();
    private MenuService menuService;

    @Override
    public void init() {
        MenuDAO menuDAO = new MenuDAOImpl();
        this.menuService = new MenuServiceImpl(menuDAO);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String category = req.getParameter("cat");

        try {
            if (category != null && !category.isBlank()) {
                List<MenuItem> items = menuService.getItemsByCategory(category);
                resp.getWriter().write(gson.toJson(items));
            } else {
                List<String> categories = menuService.getCategories();
                resp.getWriter().write(gson.toJson(categories));
            }

        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new LinkedHashMap<>();
            error.put("error", "Database error");
            error.put("detail", e.getMessage());
            resp.getWriter().write(gson.toJson(error));
        }
    }
}
