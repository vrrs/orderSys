
package models.subcategoryT;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import models.DB;

public class SubcategoryQue {
    private Connection con;
    private SubcategoryDB c=new SubcategoryDB();

    public SubcategoryQue(){
        DB db=new DB();
        con=db.getCon();
    }

     private ResultSet searchBy(int i,String value,int criteria) throws SQLException{
        String query=null;
        switch(criteria){
                case 0:query="SELECT * FROM subCategory WHERE "+c.getColumns()[i]+">='"
                    +value+"';"; break;
                case 1:query="SELECT * FROM subCategory WHERE "+c.getColumns()[i]+"="
                    +value+";";break;
                case 3:query="SELECT * FROM subCategory ORDER BY subCategory.subcategory_name;";break;
                case 4:query="SELECT * FROM subCategory WHERE "+c.getColumns()[i]+"='"
                    +value+"';";break;
                default:query="SELECT * FROM subCategory WHERE "+c.getColumns()[i]+" LIKE '"
                    +value+"%';";break;
        }
         ResultSet rows=null;
        try{
            Statement s=con.createStatement();
           rows=s.executeQuery(query);
        }
        catch(SQLException s){
            throw new SQLException();
        }
         return rows;
    }

     private SubcategoryDB convert(ResultSet s) throws SQLException{
       try{
               SubcategoryDB cu=new SubcategoryDB();
               cu.set(0, Integer.toString(s.getInt(1)));
               cu.set(1, Integer.toString(s.getInt(2)));
               cu.set(2, s.getString(3));
               cu.set(3, s.getString(4));
               return cu;
            }
            
        catch(SQLException e){
            throw new SQLException("subcategory.convert="+e.getLocalizedMessage());
        }
    }
     private SubcategoryDB[] converts(ResultSet s) throws SQLException{
        Vector<SubcategoryDB> result=new Vector<SubcategoryDB>();
        try{
            while(s.next()) result.add(convert(s));
            s.getStatement().close();
        }
        catch(SQLException e){
            throw new SQLException("subcategoryque.converts="+e.getLocalizedMessage());
        }

        SubcategoryDB[] r=new SubcategoryDB[result.size()];
        result.copyInto(r);
        return r;
    }

    public SubcategoryDB searchByID(int id) throws SQLException{
        try{
            ResultSet s=searchBy(0,Integer.toString(id),1);
            SubcategoryDB r=null;
             if(s.next())r=convert(s);
            s.getStatement().close();
            return r;
        }
        catch(SQLException e){
            throw new SQLException();
        }
    }

     public SubcategoryDB[] searchByCategory(int id) throws SQLException{
        try{
            return converts(searchBy(1,Integer.toString(id),1));
        }
        catch(SQLException e){
            throw new SQLException();
        }
    }
     public SubcategoryDB[] searchAll() throws SQLException{
         try{
            return converts(searchBy(-1,"",3));
        }
        catch(SQLException e){
            throw new SQLException();
        }
     }
     public SubcategoryDB[] searchBysubName(String v) throws SQLException{
        try{
            return converts(searchBy(2,v,2));
        }
        catch(SQLException e){
            throw new SQLException("subcategoryQue.searchbyname="+e.getLocalizedMessage());
        }
    }
     public SubcategoryDB[] searchByExactsubName(String v) throws SQLException{
        try{
            return converts(searchBy(2,v,4));
        }
        catch(SQLException e){
            throw new SQLException();
        }
    }
}
