
package models.menuT;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import models.DB;

public class MenuQue {
     private Connection con;
     private MenuDB c=new MenuDB();

     public MenuQue(){
         DB db=new DB();
        con=db.getCon();
     }

    private ResultSet searchBy(int i,String value,int criteria) throws SQLException{
        String query=null;
        switch(criteria){
                case 0:query="SELECT * FROM menu WHERE "+c.getColumns()[i]+" like '"
                    +value+"%' ORDER BY product_name;"; break;
                case 1:query="SELECT * FROM subCategory WHERE "+c.getColumns()[i]+">="
                    +value+";";break;
                case 3:query="SELECT * FROM menu ORDER BY menu.price;";break;
                case 4:query="SELECT * FROM menu ORDER BY menu.price DESC;";break;
                case 5:query="SELECT * FROM menu WHERE "+c.getColumns()[i]+"='"
                    +value+"';";break;
                default:query="SELECT * FROM menu WHERE "+c.getColumns()[i]+"="
                    +value+";";break;
        }
         ResultSet rows=null;
        try{
            Statement s=con.createStatement();
           rows=s.executeQuery(query);
        }
        catch(SQLException s){System.out.println("Error here:"+s.getMessage());
            throw new SQLException();
        }
         return rows;
    }

    private MenuDB convert(ResultSet s) throws SQLException{
       try{ 
            MenuDB cu=new MenuDB();
            cu.set(0, Integer.toString(s.getInt(1)));
            cu.set(1, Integer.toString(s.getInt(2)));
            cu.set(2, s.getString(3));
            cu.set(3, s.getString(4));
            cu.set(4,Double.toString(s.getDouble(5)));
            return cu;
            
        }
        catch(SQLException e){
            System.out.println("Error "+e.getMessage()+" "+e.getLocalizedMessage());
            throw new SQLException();
        }
    }

    private MenuDB[] converts(ResultSet s) throws SQLException{
        Vector<MenuDB> result=new Vector<MenuDB>();
        try{
            while(s.next()){
                result.add(convert(s));
            }
            s.getStatement().close();
        }
        catch(SQLException e){
            System.out.println("Error in converts method:"+e.getMessage());
            throw new SQLException();
        }

        MenuDB[] r=new MenuDB[result.size()];
        result.copyInto(r);
        return r;
    }


    public MenuDB searchByID(int id) throws SQLException{
        try{
            ResultSet s=searchBy(0,Integer.toString(id),2);
           MenuDB r=null;
             if(s.next())r=convert(s);

            s.getStatement().close();
            return r;
        }
        catch(SQLException s){
            System.out.println("Error here:"+s.getMessage());
            throw new SQLException();
        }
    }
    public MenuDB[] searchBySubCategory(int id) throws SQLException{
        try{
            return converts(searchBy(1,Integer.toString(id),2));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }
     public MenuDB[] searchByProduct(String value) throws SQLException{
        try{
            return converts(searchBy(2,value,0));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }
    public MenuDB[] searchThisProduct(String value) throws SQLException{
        try{
            return converts(searchBy(2,value,5));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }
     public MenuDB[] searchByAscendingPrice(double value) throws SQLException{
        try{
            return converts(searchBy(1,Double.toString(value),3));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }
    public MenuDB[] searchByDescendingPrice(double value) throws SQLException{
        try{
            return converts(searchBy(1,Double.toString(value),4));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }
}

