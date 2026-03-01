package com.foodorder.model;

public class MenuItem {

    private int    id;
    private String name;
    private String category;
    private double price;   // changed from int to double for DECIMAL(10,2)

    public MenuItem() {}

    public MenuItem(int id, String name, String category, double price) {
        this.id       = id;
        this.name     = name;
        this.category = category;
        this.price    = price;
    }

    public int    getId()       { return id; }
    public String getName()     { return name; }
    public String getCategory() { return category; }
    public double getPrice()    { return price; }

    public void setId(int id)           { this.id = id; }
    public void setName(String name)    { this.name = name; }
    public void setCategory(String cat) { this.category = cat; }
    public void setPrice(double price)  { this.price = price; }

    @Override
    public String toString() {
        return "MenuItem{id=" + id + ", name='" + name + "', category='" + category + "', price=" + price + "}";
    }
}
