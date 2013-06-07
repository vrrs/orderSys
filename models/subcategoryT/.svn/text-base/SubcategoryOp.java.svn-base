
package models.subcategoryT;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import models.DB;
import models.categoryT.CategoryDB;

public class SubcategoryOp {
    private Connection con;

    public SubcategoryOp(){
        DB db=new DB();
        con=db.getCon();
    }

    public void saveSubcategory(CategoryDB ca,SubcategoryDB c) throws SQLException{
          String operationS="INSERT INTO subCategory(IDcategory,subcategory_name,subCategory_detail)"+
                  " VALUES("+ca.getId()+ ",'"+c.getSubName()+ "','"+c.getSubDetail()+ "');";
          try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in subcategory.save sql exception:"+s.getMessage());
             throw new SQLException();
        }
    }
    public void editSubcategory(CategoryDB ca,SubcategoryDB c) throws SQLException{
        String operationS="UPDATE subCategory SET IDcategory="+ca.getId()+ ",subcategory_name='" +
                c.getSubName()+ "',subCategory_detail='"+ c.getSubDetail()+
                "' WHERE subCategory.IDsubcategory="+ c.getId()+";" ;
        try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in subcategory.edit,sql exception:"+s.getMessage());
             throw new SQLException();
        }
    }
    public void deleteSubcategory(SubcategoryDB c) throws SQLException{
        String operationS="DELETE FROM subCategory WHERE subCategory.IDsubcategory="+
                c.getId()+ ";";
        try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in subcategory.delete sql exception:"+s.getMessage());
             throw new SQLException();
        }
    }
}
