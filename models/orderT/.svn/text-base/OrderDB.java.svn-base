package models.orderT;

import java.sql.SQLException;
import models.modelsDB;

public class OrderDB implements modelsDB{
    private int id;
    private int idProduct;
    private int quantity;
    private int idOrder=-1;
    private String[] columns={"IDorderInfo","IDproductInfo","Quantity,IDorders"};

     @Override
    public modelsDB me(){
        return this;
    }
     
    public OrderDB(){
        id=0;
        idProduct=0;
        quantity=0;
    }
    public OrderDB(int nId,int nIdProduct,int nQuantity){
        id=nId;
        idProduct=nIdProduct;
        quantity=nQuantity;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    @Override
    public int getId() {
        return id;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public double getQuantity() {
        return quantity;
    }

    public String[] getColumns() {
        return columns;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void set(int column,String value){
        switch(column){
            case 0:setId(Integer.parseInt(value));break;
            case 1:setIdProduct(Integer.parseInt(value));break;
            default:setQuantity(Integer.parseInt(value));break;
        }
    }
    public void saveMySelf() throws SQLException{
        OrderOp o=new OrderOp();
        try{
           if(idOrder<0) setupID();
           o.saveOrder(this);
           o.close();
       }
       catch(SQLException s){
            System.out.println("Error in orderDB.saveMyself:"+s.getMessage());
            throw new SQLException("orderDB.savemyself:"+s.getLocalizedMessage());
        }
    }
    private void setupID()throws SQLException{
        OrderOp query=new OrderOp();
        OrderDB[] rows;
        try{
            rows=query.searchAll();
            int size=rows.length;
            System.out.println(size);
            if(size>0){
                OrderDB lastRow=rows[size-1];
                int lastRowID=lastRow.getIdOrder();
                this.setIdOrder(++lastRowID);
            }
            else{
                this.setIdOrder(0);
            }
            query.close();
        }
        catch(SQLException s){
            throw new SQLException("Error in orderDB.setupID:"+s.getLocalizedMessage());
        }
    }
}
