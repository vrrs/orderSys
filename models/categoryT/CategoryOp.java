package models.categoryT;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import models.DB;

public class CategoryOp {
    private Connection con;

    public CategoryOp(){
        DB db=new DB();
        con=db.getCon();
    }

    public void saveCategory(CategoryDB c) throws SQLException{
        String operationS="INSERT INTO category (category_name,category_detail) VALUES ('"+
            c.getcName()+"','"+c.getDetail()+"');";
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
    public void deleteCategory(CategoryDB c) throws SQLException{
        String operationS="DELETE FROM category WHERE category.IDcategory=" +
                c.getId()+";" ;
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
    public void editCategory(CategoryDB c) throws SQLException{
        String operationS="UPDATE category SET category_name='" +
                c.getcName()+"',category_detail='"+c.getDetail()+"'"+
                "WHERE category.IDcategory="+c.getId()+ ";";
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
}
