package models.orderInT;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import models.DB;

public class OrderInQue {
    private Connection con;
    private OrderInDB c=new OrderInDB();

    public OrderInQue(){
        DB db=new DB();
        con=db.getCon();
    }
    private ResultSet searchBy(int i,String value,int criteria) throws SQLException{
        String query=null;
        switch(criteria){
                case 0:query="SELECT * FROM orderInfo WHERE "+c.get(i)+">='"
                    +value+"';"; break;
                case 1:query="SELECT * FROM orderInfo WHERE "+c.get(i)+">="
                    +value+";";break;
                case 3:query="SELECT * FROM orderInfo;";break;
                default:query="SELECT * FROM orderInfo WHERE "+c.get(i)+"="
                    +value+";";break;
        }
         ResultSet rows=null;
        try{
            Statement s=con.createStatement();
           rows=s.executeQuery(query);
        }
        catch(SQLException s){
            System.out.println("Error in orderInQue.searchBy:"+s.getLocalizedMessage());
            throw new SQLException("Error in orderInQue.searchBy:"+s.getLocalizedMessage());
        }
         return rows;
    }
    private OrderInDB convert(ResultSet s) throws SQLException{
       try{
               OrderInDB cu=new OrderInDB();
               cu.set(0, Integer.toString(s.getInt(1)));
               cu.set(1, Integer.toString(s.getInt(2)));
               cu.set(2, s.getDate(3).toString());
               cu.set(3, Double.toString(s.getDouble(4)));
               return cu;          
        }
        catch(SQLException e){
            System.out.println("Error in orderInQue.convert:"+e.getLocalizedMessage());
            throw new SQLException();
        }
    }
     private OrderInDB[] converts(ResultSet s) throws SQLException{
        Vector<OrderInDB> result=new Vector<OrderInDB>();
        try{
            while(s.next()) result.add(convert(s));
            s.getStatement().close();
        }
        catch(SQLException e){
            System.out.println("Error in orderInQue.converts:"+e.getLocalizedMessage());
            throw new SQLException();
        }

        OrderInDB[] r=new OrderInDB[result.size()];
        result.copyInto(r);
        return r;
    }

    public OrderInDB[] allRows()throws SQLException {
         try{
            return converts(searchBy(0,"",3));
        }
        catch(SQLException s){
            System.out.println("Error in orderInQue.allRows:"+s.getLocalizedMessage());
            throw new SQLException();
        }
    }
    public OrderInDB searchByID(int id) throws SQLException{
         try{
             ResultSet s=searchBy(0,Integer.toString(id),2);
             OrderInDB r=null;
             if(s.next())r=convert(s);
             s.getStatement().close();
            return r;
        }
        catch(SQLException s){
            throw new SQLException();
        }
     }
    public OrderInDB[] searchByCustomer(int c) throws SQLException{
         try{
            return converts(searchBy(1,Integer.toString(c),1));
        }
        catch(SQLException s){
            throw new SQLException();
        }
     }
    public OrderInDB[] searchByDate(String c) throws SQLException{
         try{
            return converts(searchBy(2,c,0));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }
    
}
