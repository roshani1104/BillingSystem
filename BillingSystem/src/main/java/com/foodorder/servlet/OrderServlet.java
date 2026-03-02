package com.foodorder.servlet;

import com.foodorder.dao.MenuDAO;
import com.foodorder.dao.OrderDAO;
import com.foodorder.dao.impl.MenuDAOImpl;
import com.foodorder.dao.impl.OrderDAOImpl;
import com.foodorder.model.OrderItem;
import com.foodorder.service.OrderService;
import com.foodorder.service.OrderService.OrderResult;
import com.foodorder.service.impl.OrderServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() {
        MenuDAO menuDAO   = new MenuDAOImpl();
        OrderDAO orderDAO = new OrderDAOImpl();
        this.orderService = new OrderServiceImpl(menuDAO, orderDAO);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {
            List<OrderItem> orderItems = orderService.placeOrder(req.getParameterMap());

            if (orderItems.isEmpty()) {
                resp.sendRedirect("index.html");
                return;
            }

            double subtotal = orderService.calculateSubtotal(orderItems);
            double tax      = orderService.calculateTax(subtotal);
            double total    = orderService.calculateTotal(subtotal, tax);

            // Persist to DB — single source of truth for ref ID
            OrderResult result = orderService.saveOrder(orderItems, subtotal, tax, total);

            req.setAttribute("orderItems", orderItems);
            req.setAttribute("subtotal",   String.format("Rs %.2f", subtotal));
            req.setAttribute("tax",        String.format("Rs %.2f", tax));
            req.setAttribute("total",      String.format("Rs %.2f", total));
            req.setAttribute("ref",        result.ref());
            req.setAttribute("orderId",    result.orderId());

            req.getRequestDispatcher("/WEB-INF/receipt.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Order processing failed: " + e.getMessage(), e);
        }
    }
}
