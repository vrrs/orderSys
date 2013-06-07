
package models.customerT;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class CustomerOp {
    private Connection con;

    public CustomerOp(){
        stablishConection();
    }

    private void stablishConection(){
        String data="jdbc:odbc:ordersys1";
        try{
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            con=DriverManager.getConnection(data);
        }
        catch(SQLException s){
            System.out.println("Error customerop.stablishing connection, sql exception:"+s.getMessage());
        }
         catch(Exception e){
            System.out.println("Error customerop.stablishing connection:"+e.getMessage()+" "+e.getLocalizedMessage());
        }
    }

    public void saveNewCustomer(CustomerDB c) throws SQLException{
        String operationS="INSERT INTO customer (name,address,Telephone," +
                "Cellphone,Email,Tag_Name,date_added) VALUES('"+ c.getName()+
                "','"+c.getAddress()+"',"+c.getTelephone()+","+c.getCellphone()+",'"
                + c.getEmail()+"','"+c.getTagName()+"','"+c.getDateAdded().toString()
                +"');";
        try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in customerOP.savenewcustomer(),sqlException:"+s.getMessage());
             throw new SQLException();
        }
    }

    public void deleteCustomer(CustomerDB c) throws SQLException{
        String operationS="DELETE FROM customer WHERE customer.Idcustomer="+
                c.getId()+";";
         try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in customerop.delete(),sql exception:"+s.getMessage());
             throw new SQLException();
        }
    }

    public void editCustomer(CustomerDB c) throws SQLException{
        String operationS="UPDATE customer SET ";

        int size=c.getColumns().length;
        String cvpairs=new String("");
        for(int i=1;i<size-1;i++){
            if((i!=3)&(i!=4))cvpairs+=c.getColumns()[i]+"='"+c.get(i)+"',";
        }
        cvpairs+=c.getColumns()[size-1]+"='"+c.get(size-1)+"',";//last column
        //columns with numerical types
        cvpairs+=c.getColumns()[3]+"="+c.get(3)+",";
        cvpairs+=c.getColumns()[4]+"="+c.get(4);
        operationS+=cvpairs+" WHERE customer.Idcustomer="+c.getId()+";";
        try{
            Statement s=con.createStatement();
            s.executeUpdate(operationS);
            s.close();
        }
        catch(SQLException s){
            System.out.println("Error in customerop.editcustomer(),sql exception:"+s.getMessage());
            throw new SQLException();
        }
    }
    public void close(){
        try{
            con.close();
        }
        catch(SQLException s){
            System.out.println("Error in customerop.close");
        }
    }
 }

