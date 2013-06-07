
package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
    private Connection con;
    private String errorMessage="";
    private static String settingFileName="settings.txt";
    private static String FXPadModelFileName="FXPadFiles.txt";
    private static String orderModelFileName="OrderModelDB.txt";

    public String getErrorMessage() {
        return errorMessage;
    }

    public Connection getCon() {
        return con;
    }
    
    public DB(){
        stablishConection();
    }

    public static String getSettingFileName(){
        return settingFileName;
    }

    public static String getFXPadModelFileName() {
        return FXPadModelFileName;
    }

    public static String getOrderModelFileName() {
        return orderModelFileName;
    }

    public static void setOrderModelFileName(String orderModelFileName) {
        DB.orderModelFileName = orderModelFileName;
    }

    private void stablishConection(){
        String data="jdbc:odbc:ordersys1";
        try{
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            con=DriverManager.getConnection(data);
        }
        catch(SQLException s){
            errorMessage=s.getMessage();
            System.out.println("Error in sql exception:"+s.getMessage());
        }
         catch(Exception e){
             errorMessage=e.getMessage();
            System.out.println("Error:"+e.getMessage()+" "+e.getLocalizedMessage());
        }
    }
    public void closeConnection(){
        try{
            con.close();
        }
        catch(SQLException s){
            System.out.println("Error in DB.closeConnection:"+s.getLocalizedMessage());
        }
    }

}
