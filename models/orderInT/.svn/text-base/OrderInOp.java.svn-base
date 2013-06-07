
package models.orderInT;


import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import models.DB;

public class OrderInOp {
    private Connection con;

    public OrderInOp(){
        DB db=new DB();
        con=db.getCon();
    }

    public void saveOrderIn(OrderInDB o)throws SQLException{
        String operationS="INSERT INTO orderInfo (IDcustomerInfo,orderDate,total) VALUES("
                + o.getCustomerInID()+",'"+o.getDate().toString()+"',"+o.getTotal()+");";
        try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in orderinop.saveorderin:"+s.getMessage());
             throw new SQLException();
        }
    }
    //this method is used to store an orderinDB that contain already the ID
    public void saveOrderInWithID(OrderInDB o)throws SQLException{
        String operationS="INSERT INTO orderInfo (IDorderInfo,IDcustomerInfo,orderDate,total) VALUES("
                + o.getId()+","+o.getCustomerInID()+",'"+o.getDate().toString()+"',"+o.getTotal()+");";
        try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in orderinop.saveOrderInWithID:"+s.getMessage());
             throw new SQLException();
        }

    }
    public void editOrderIn(OrderInDB o)throws SQLException{
        String operationS="UPDATE orderInfo SET IDcustomerInfo="+o.getCustomerInID()+"," +
                "orderDate='"+o.getDate().toString()+"',total="+o.getTotal()+
                "WHERE IDorderInfo="+o.getId() +";";
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
    public void deleteOrder(OrderInDB o)throws SQLException{
        String operationS="DELETE FROM orderInfo WHERE orderInfo.IDorderInfo="+o.getId() +";";
        String operationS1="DELETE FROM orders WHERE orderInfo.IDorderInfo="+o.getId() +";";
        try{
            Statement s=con.createStatement();
            Statement s1=con.createStatement();
            s1.executeUpdate(operationS1);
            s.executeUpdate(operationS);
            s.close();
            s1.close();
        }
        catch(SQLException s){
            System.out.println("Error in sql exception:"+s.getMessage());
             throw new SQLException();
        }
    }
}
