package models.menuT;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import models.DB;
import models.subcategoryT.SubcategoryDB;

public class MenuOp {
    private Connection con;
    private DB db=new DB();

    public MenuOp(){
        con=db.getCon();
    }

     public void saveMenu(SubcategoryDB c,MenuDB m) throws SQLException{
        String operationS="INSERT INTO menu (IDsubcategory,product_name,product_detail,price) VALUES("+
                c.getId()+",'"+m.getProduct()+"','"+m.getProductDetail()+"',"+ m.getPrice()+");";
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
    public void editMenu(MenuDB m) throws SQLException{
        String operationS="UPDATE menu SET IDsubcategory="+m.getSubCaID()+ ",product_name='" +
                m.getProduct()+ "',product_detail='"+ m.getProductDetail()+"',price="+m.getPrice()+
                " WHERE menu.IDmenu="+ m.getId()+";" ;
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
    public void deleteMenu(MenuDB m)throws SQLException{
      String operationS="DELETE FROM menu WHERE menu.IDmenu="+
                m.getId()+ ";";
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
    public void closeConection(){
       db.closeConnection();
    }
}
