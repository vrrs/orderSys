
package models.categoryT;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import models.DB;

public class CategoryQue {
    private Connection con;
    private CategoryDB c=new CategoryDB();

    public CategoryQue(){
        DB db=new DB();
        con=db.getCon();
    }

    private ResultSet searchBy(int i,String value,int criteria) throws SQLException{
          String query=null;
        switch(criteria){
                case 0:query="SELECT * FROM category WHERE "+c.getColumns()[i]+" like '"
                    +value+"%';"; break;
                case 1:query="SELECT * FROM category;";break;
                default:query="SELECT * FROM category WHERE "+c.getColumns()[i]+"="
                    +value+";";break;
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
//this kind of methods return null when there is no such a record
    public CategoryDB searchByID(int id) throws SQLException{
        try{
            ResultSet s=searchBy(0,Integer.toString(id),2);
           CategoryDB r=null;
            if(s.next()) r=convert(s);
            s.getStatement().close();
            return r;
        }
        catch(SQLException e){
            throw new SQLException();
        }
    }
    public CategoryDB[] searchByCategory(String s) throws SQLException{
         try{
            return converts(searchBy(1,s,0));
        }
        catch(SQLException e){
            throw new SQLException();
        }
   }
   public CategoryDB[] searchAllCategory() throws SQLException{
         try{
            return converts(searchBy(0," ",1));
        }
        catch(SQLException e){
            throw new SQLException();
        }
   }
    private CategoryDB convert(ResultSet s) throws SQLException{
        try{
            
                int id=s.getInt(1);
                String[] columns=new String[2];
                for(int i=0;i<2;i++){
                    columns[i]=s.getString(i+2);
                }
              
                return new CategoryDB(id,columns[0],columns[1]);
        }
        catch(SQLException e){
            throw new SQLException();
        }
    }
    private CategoryDB[] converts(ResultSet s) throws SQLException{
        Vector<CategoryDB> result=new Vector<CategoryDB>();
        try{
            while(s.next()) result.add(convert(s));
            s.getStatement().close();
        }
        catch(SQLException e){
            throw new SQLException();
        }

        CategoryDB[] r=new CategoryDB[result.size()];
        result.copyInto(r);
        return r;
    }
}
