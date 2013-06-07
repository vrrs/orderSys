
package models.orderInT;

import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;
import models.modelsDB;

public class OrderInDB implements modelsDB{
    private int id;
    private int customerInID;
    private Date date;
    private double total;

    private String[] columns={"id","customerInID","date","total"};

    @Override
    public modelsDB me(){
        return this;
    }

    public String[] getColumns() {
        return columns;
    }

     public OrderInDB(){
        id=0;
        customerInID=0;

       Calendar todayCalendar=Calendar.getInstance();
       date=new Date(todayCalendar.getTime().getTime());
       total=0;
    }

   public OrderInDB(int nId,int nCustomerInID,Date nDate,double nTotal){
       id=nId;
       customerInID=nCustomerInID;
       date=nDate;
       total=nTotal;
   }

    public int getCustomerInID() {
        return customerInID;
    }

    public void setCustomerInID(int customerInID) {
        this.customerInID = customerInID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String get(int column){
        switch(column){
            case 0:return Integer.toString(id);
            case 1:return Integer.toString(customerInID);
            case 2:return date.toString();
            default: return Double.toString(total);
        }
    }

    public void set(int column,String value){
        switch(column){
            case 0:id=Integer.parseInt(value);break;
            case 1:customerInID=Integer.parseInt(value);break;
            case 2:date=Date.valueOf(value);break;
            default: total=Double.parseDouble(value);
        }
    }

    //operations
    public void saveMySelf() throws SQLException {
        OrderInOp o=new OrderInOp();
       try{
           o.saveOrderInWithID(this);
       }
       catch(SQLException s){
            System.out.println("Error in orderinDB.saveMyself:"+s.getMessage());
            throw new SQLException();
        }
    }
}
