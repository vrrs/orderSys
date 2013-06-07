/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package controllers.dataControllers;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Calendar;
import java.sql.Date;
import java.util.GregorianCalendar;
import java.util.Vector;
import models.DB;

/**
 *
 * @author vic
 */

public class StatisticsDataController {

    private class MyNumber {
        private int intvalue=0;
        private double doubleVal=0;
        
        public MyNumber(){}

        @Override
        public boolean equals(Object o){
            if (o.getClass().toString().compareTo("MyNumber")==0){
                MyNumber temp=(MyNumber) o;
                if(temp.getDoubleValue()==this.getDoubleValue() & temp.getIntValue()==this.getIntValue()){
                    return true;
                }
                else{
                    return false;
                }
            }
            return false;
        }

        @Override
        public int hashCode() {
            int hash = 3;
            hash = 97 * hash + this.intvalue;
            hash = 97 * hash + (int) (Double.doubleToLongBits(this.doubleVal) ^ (Double.doubleToLongBits(this.doubleVal) >>> 32));
            return hash;
        }
       
        public double getDoubleValue(){
            return doubleVal;
        }
        public int getIntValue(){
            return intvalue;
        }
        
        public void setIntValue(int v){
            intvalue=v;
        }
        public void setDoubleValue(double v){
            doubleVal=v;
        }
        @Override
        public String toString(){
            return "MyNumber";
        }
}

    //private vars
    private Vector<MyNumber> productID=new Vector<MyNumber>();
    private Vector<MyNumber> price=new Vector<MyNumber>();

    //output data
    private Vector<MyNumber> quantity=new Vector<MyNumber>();
    private Vector<MyNumber> total=new Vector<MyNumber>();
    private Vector<String> names=new Vector<String>();

    //query criteria
    private Date date1;
    private Date date2;
    private boolean highest=true;
    private boolean totalSale=false;

    //db connection
    private Connection con;

    public StatisticsDataController(){
        DB db=new DB();
        con=db.getCon();
        date1=today();
        date2=today();
    }

    private ResultSet searchBy(String value,int criteria) throws SQLException{
        String query=null;
        switch(criteria){
                case 0:query="SELECT DISTINCT orders.IDproductInfo FROM orders WHERE orders.IDorderInfo in " +
                        "( select orderInfo.IDorderInfo from orderInfo " +
                        "WHERE orderInfo.orderDate>=CDATE('"+date1.toString()+"') and orderInfo.orderDate<=CDATE('" +
                        date2.toString()+"') ) "
                    +";"; break;
                case 1:query="SELECT SUM(orders.Quantity) FROM orders WHERE orders.IDproductInfo="+value+";";break;
                case 2:query="SELECT price,product_name FROM menu WHERE menu.IDmenu="+value+";";break;
        }
         ResultSet rows=null;
        try{
            Statement s=con.createStatement();
           rows=s.executeQuery(query);
        }
        catch(SQLException s){
            throw new SQLException("statisticsDataController.searchBy="+s.getLocalizedMessage());
        }
         return rows;

    }

    private void setProductID() throws SQLException{
       try{
           ResultSet r=searchBy("",0);
           MyNumber temp;
           while(r.next()){
               temp=new MyNumber();
               temp.setIntValue(r.getInt(1));
               productID.add(temp);
           }
           r.getStatement().close();
       }
        catch(SQLException s){
            throw new SQLException("statisticsDataController.setProductID="+s.getLocalizedMessage());
        }
    }
    private MyNumber getQuantityVal(String value) throws SQLException{
        MyNumber result=new MyNumber();
        try{
           ResultSet r=searchBy(value,1);
           if(r.next()){
               result.setIntValue(r.getInt(1));
           }
           r.getStatement().close();
       }
        catch(SQLException s){
            throw new SQLException("statisticsDataController.getQuantityVal="+s.getLocalizedMessage());
        }
        return result;
    }
    private MyNumber getPriceVal(String value) throws SQLException{
        MyNumber result=new MyNumber();
        try{
           ResultSet r=searchBy(value,2);
           if(r.next()){
               result.setDoubleValue(r.getDouble(1));
           }
           r.getStatement().close();
       }
        catch(SQLException s){
            throw new SQLException("statisticsDataController.getPriceVal="+s.getLocalizedMessage());
        }
        return result;
    }
    private String getNameVal(String value) throws SQLException{
        String result=null;
        try{
           ResultSet r=searchBy(value,2);
           if(r.next()){
               result=r.getString(2);
           }
           r.getStatement().close();
       }
        catch(SQLException s){
            throw new SQLException("statisticsDataController.getNameVal="+s.getLocalizedMessage());
        }
        return result;
    }

    private void setup() throws SQLException{
       MyNumber temp;
       productID.removeAllElements();
       quantity.removeAllElements();
       price.removeAllElements();
       names.removeAllElements();
       total.removeAllElements(); 
        try{
            setProductID();
            for(int i=0;i<productID.size();i++){
                quantity.add(this.getQuantityVal(Integer.toString(productID.get(i).getIntValue())));
                price.add(this.getPriceVal(Integer.toString(productID.get(i).getIntValue())));
                names.add(this.getNameVal(Integer.toString(productID.get(i).getIntValue())));
                temp=new MyNumber();
                temp.setDoubleValue(price.get(i).getDoubleValue()*quantity.get(i).getIntValue());
                total.add(temp);
            }
        }
        catch(SQLException s){
            throw new SQLException("statisticsDataController.setup="+s.getLocalizedMessage());
        }
    }

    private static String formatDate(int dateVal){
        String r="";
        if(dateVal<10){
            r="0";
        }
        r+=Integer.toString(dateVal);
        return r;
    }
    //input values(query setters)
    public void setHighest(boolean highest) {
        this.highest = highest;
    }
    public void setTotalSale(boolean totalSale) {
        this.totalSale = totalSale;
    }
    public void setDates(Date d1,Date d2){
        date1=d1;
        date2=d2;
    }
    public void trigger(){
        try{
            setup();
        }
         catch(SQLException s){
            System.out.println("Error in StatisticsDataController.trigger:"+s.getLocalizedMessage());
        }
    }
    //output
    public String[] getNames() {
       String[] r=new String[names.size()];
       names.copyInto(r);
        return r;
    }
    public int[] getQuantity() {
        MyNumber[] pre=new MyNumber[quantity.size()];
        quantity.copyInto(pre);
        int[] result=new int[pre.length];
        for(int i=0;i<pre.length;i++){
            result[i]=pre[i].getIntValue();
        }
        return result;
    }
    public double[] getTotal() {
        MyNumber[] pre=new MyNumber[total.size()];
        total.copyInto(pre);
        double[] result=new double[pre.length];
        for(int i=0;i<pre.length;i++){
            result[i]=pre[i].getDoubleValue();
        }
        if(totalSale){
            Arrays.sort(result);
            if(!highest){
                double[] temp=new double[pre.length];
                int k=0;
                for(int i=result.length-1;i>=0;i--){
                    temp[k++]=result[i];
                }
                result=temp;
            }
        }
        return result;
    }
    
    //query getter values
    public Date getDate1() {
        return date1;
    }
    public Date getDate2() {
        return date2;
    }
    public boolean isHighest() {
        return highest;
    }
    public boolean isTotalSale() {
        return totalSale;
    }

   //date operations{
   public static Date today(){
        Calendar todayCalendar=Calendar.getInstance();
        return new Date(todayCalendar.getTime().getTime());
    }
   //the month is 12>=month>=1
   public static Date firstDayOfTheMonth(int month){
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(today());

        int currentYear=calendar.get(Calendar.YEAR);
        String date=Integer.toString(currentYear)+"-"+formatDate(month)+"-01";
        return Date.valueOf(date);
    }
   public static Date lastDayOfTheMonth(int month){
       Calendar calendar = new GregorianCalendar();
       calendar.setTime(firstDayOfTheMonth(month));
       
       Calendar temp = new GregorianCalendar();
       temp.setTime(firstDayOfTheMonth(month));
       for(int amount=1;amount<=31;amount++){
           temp.add(Calendar.DAY_OF_MONTH,1);
           if(temp.get(Calendar.DAY_OF_MONTH)==1){
               calendar.add(Calendar.DAY_OF_MONTH,amount-1);
               break;
           }
       }
       String r=Integer.toString(calendar.get(Calendar.YEAR))+"-"+formatDate(calendar.get(Calendar.MONTH)+1)+"-"+formatDate(calendar.get(Calendar.DAY_OF_MONTH));
      return Date.valueOf(r);
    }
   public static Date firstDayOfTheYear(){
       return firstDayOfTheMonth(1);
   }
   public static Date lastDayOfTheYear(){
       return lastDayOfTheMonth(12);
   }
   public static Date firstDayOfWeek(int week){
       Calendar calendar = new GregorianCalendar();
       calendar.setTime(today());
       calendar.set(Calendar.WEEK_OF_YEAR, week);
       calendar.set(Calendar.DAY_OF_WEEK,1);
       String r=Integer.toString(calendar.get(Calendar.YEAR))+"-"+formatDate(calendar.get(Calendar.MONTH)+1)+"-"+formatDate(calendar.get(Calendar.DAY_OF_MONTH));
       return Date.valueOf(r);
   }
   public static Date lastDayOfWeek(int week){
       Calendar calendar = new GregorianCalendar();
       calendar.setTime(today());
       calendar.set(Calendar.WEEK_OF_YEAR, week);
       calendar.set(Calendar.DAY_OF_WEEK,7);
       String r=Integer.toString(calendar.get(Calendar.YEAR))+"-"+formatDate(calendar.get(Calendar.MONTH)+1)+"-"+formatDate(calendar.get(Calendar.DAY_OF_MONTH));
       return Date.valueOf(r);
   }
   //}
}
