package com.foodorder.model;

public class OrderItem {

    private String name;
    private int    quantity;
    private double unitPrice;
    private double lineTotal;

    public OrderItem() {}

    public OrderItem(String name, int quantity, double unitPrice) {
        this.name      = name;
        this.quantity  = quantity;
        this.unitPrice = unitPrice;
        this.lineTotal = quantity * unitPrice;
    }

    public String getName()      { return name; }
    public int    getQuantity()  { return quantity; }
    public double getUnitPrice() { return unitPrice; }
    public double getLineTotal() { return lineTotal; }

    public void setName(String name)          { this.name = name; }
    public void setQuantity(int quantity)      { this.quantity = quantity; this.lineTotal = quantity * unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; this.lineTotal = quantity * unitPrice; }

    @Override
    public String toString() {
        return "OrderItem{name='" + name + "', qty=" + quantity + ", price=" + unitPrice + ", total=" + lineTotal + "}";
    }
}
