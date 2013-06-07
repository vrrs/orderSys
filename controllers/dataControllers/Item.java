package controllers.dataControllers;

import java.io.Serializable;
import models.menuT.MenuDB;

public class Item implements Serializable{
    private int productID=0;
    private int quantity=1;
    private double price=0;
    private MenuDB model;

    public MenuDB getModel() {
        return model;
    }

    public void setModel(MenuDB m) {
        this.model = m;
        setProductID(m.getId());
        setPrice();
    }

    public Item(int id,int q){
        productID=id;
        quantity=q;
    }
    
    public Item(){}

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }
    public double getPrice(){
        return price;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    private void setPrice(){
        price=model.getPrice();
    }

}
