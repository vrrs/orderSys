package models.orderT;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import models.DB;



public class OrderOp {
    private Connection con;

    public OrderOp(){
        DB db=new DB();
        con=db.getCon();
    }

    public void saveOrder(OrderDB o)throws SQLException{
        String operationS="INSERT INTO orders (IDorders,IDorderInfo,IDproductInfo,Quantity)"+
                  " VALUES("+o.getIdOrder()+","+o.getId()+ ","+o.getIdProduct()+ ","+o.getQuantity()+ ");";
        try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in orderop.saveOrder:"+s.getMessage());
             throw new SQLException();
        }
    }
    public void editOrder(OrderDB o)throws SQLException{
        String operationS="UPDATE orders SET Quantity="+o.getQuantity()+
            "WHERE orderInfo.IDorderInfo="+o.getId()+",menu.IDproductInfo="+o.getIdProduct()+";";
         try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in sql exception:"+s.getMessage());
             throw new SQLException();
        }
    }

    //Query
    public ResultSet searchProductsQuantity(OrderDB o) throws SQLException{
        String query="SELECT orders.Quantity FROM orders WHERE orderInfo.IDorderInfo="+
                o.getId()+",menu.IDproductInfo="+o.getIdProduct()+";";
        ResultSet rows=null;
        try{
            Statement s=con.createStatement();
           rows=s.executeQuery(query);
            s.close();
        }
        catch(SQLException s){
            throw new SQLException();
        }
         return rows;
    }
     public OrderDB[] searchAll() throws SQLException{
        String query="SELECT * FROM orders;";
        ResultSet rows=null;
        OrderDB temp;
        Vector<OrderDB> preR=new Vector<OrderDB>();
        try{
            Statement s=con.createStatement();
            rows=s.executeQuery(query);
            while(rows.next()){
                temp=new OrderDB();
                temp.setId(rows.getInt(1));
                temp.setIdProduct(rows.getInt(2));
                temp.setQuantity(rows.getInt(3));
                temp.setIdOrder(rows.getInt(4));
                preR.add(temp);
            }
            s.close();
        }
        catch(SQLException s){
            throw new SQLException("Error in orderOp.searchAll:"+s.getLocalizedMessage());
        }
         OrderDB[] r=new OrderDB[preR.size()];
         preR.copyInto(r);
         return r;
    }
     public void close(){
         try{
             con.close();
         }
         catch(SQLException s){
             System.out.println("Error in orderop.close:"+s.getMessage());
         }
     }
}
