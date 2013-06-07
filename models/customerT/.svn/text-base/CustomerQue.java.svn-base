package models.customerT;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import models.DB;

public class CustomerQue {
     private Connection con;
     private CustomerDB c=new CustomerDB();

    public CustomerQue(){
        DB db=new DB();
        con=db.getCon();
    }
    private CustomerDB[] converts(ResultSet s) throws SQLException{
        Vector<CustomerDB> result=new Vector<CustomerDB>();
        try{
            while(s.next()) result.add(convert(s));
            s.getStatement().close();
        }
        catch(SQLException e){System.out.println("Error in converts:"+e.getMessage());
            throw new SQLException();
        }

        CustomerDB[] r=new CustomerDB[result.size()];
        result.copyInto(r);
        return r;
    }
     private CustomerDB convert(ResultSet s) throws SQLException{
        try{
            
               CustomerDB cu=new CustomerDB();
               for(int i=0;i<8;i++){
                    if((i==3)|(i==4)|(i==0)) 
                       cu.set(i, Integer.toString(s.getInt(i+1)));
                    else
                       cu.set(i, s.getString(i+1));
                }
                return cu;
         
        }
        catch(SQLException e){
            throw new SQLException();
        }
    }
    private ResultSet searchBy(int i,String value,int criteria) throws SQLException{
       String query=null;
        switch(criteria){
                case 0:query="SELECT * FROM customer WHERE "+c.getColumns()[i]+" like '"
                    +value+"%';"; break;
                case 1:query="SELECT * FROM customer WHERE "+c.getColumns()[i]+">="
                    +value+";";break;
                case 3:query="SELECT * FROM customer;";break;
                default:query="SELECT * FROM customer WHERE "+c.getColumns()[i]+"="
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

    public  CustomerDB searchByID(int id)throws SQLException{
        try{
            ResultSet s=searchBy(0,Integer.toString(id),2);
         CustomerDB r=null;
             if(s.next())r=convert(s);
            s.getStatement().close();
            return r;
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }

    public CustomerDB[] searchByName(String name) throws SQLException {
        try{
            return converts(searchBy(1,name,0));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }

    public CustomerDB[] searchByAddress(String address) throws SQLException {
        try{
            return converts(searchBy(2,address,0));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }

    public CustomerDB[] searchByEmail(String email) throws SQLException {
        try{
            return converts(searchBy(5,email,0));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }

   public CustomerDB[] searchByTel(int tel) throws SQLException {
        try{
            return converts(searchBy(3,Integer.toString(tel),1));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }

   public CustomerDB[] searchByCel(int cel) throws SQLException {
        try{
            return converts(searchBy(4,Integer.toString(cel),1));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }

   public CustomerDB[] searchBytag(String tagName) throws SQLException {
        try{
            return converts(searchBy(6,tagName,0));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }

   public CustomerDB[] searchByDate(String date) throws SQLException {
        try{
            return converts(searchBy(7,date,0));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }
   public CustomerDB[] searchAll() throws SQLException {
        try{
            return converts(searchBy(-1,"",3));
        }
        catch(SQLException s){
            throw new SQLException();
        }
    }
}
