
package models.customerT;

import java.io.Serializable;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;
import models.modelsDB;

public class CustomerDB implements modelsDB,Serializable{
    private int id;
    private String name;
    private String address;
    private String email;
    private String tagName;
    private int telephone;
    private int cellphone;
    private Date dateAdded;

    private String[] columns={"Idcustomer","name","address","Telephone","Cellphone"
     ,"Email","Tag_Name","date_added"};

    @Override
    public modelsDB me(){
        return this;
    }

    //constructors
    public CustomerDB(){
        id=0;
        name=new String("");
        address=new String("");
        email=new String("");
        tagName=new String("");
        telephone=0;
        cellphone=0;

        Calendar todayCalendar=Calendar.getInstance();
        dateAdded=new Date(todayCalendar.getTime().getTime());
    }
    public CustomerDB(int nID, String nName,String nAddress,String nEmail,
            String nTagName,int nTelephone,int nCellphone){
        id=nID;
        name=nName;
        address=nAddress;
        email=nEmail;
        tagName=nTagName;
        telephone=nTelephone;
        cellphone=nCellphone;

        Calendar todayCalendar=Calendar.getInstance();
        dateAdded=new Date(todayCalendar.getTime().getTime());
    }

    //field getters and setters

    public String get(int column){
        switch(column){
            case 0:return Integer.toString(id);
            case 1:return name;
            case 2:return address;
            case 3:return Integer.toString(telephone);
            case 4:return Integer.toString(cellphone);
            case 5:return email;
            case 6:return tagName;
            default:return dateAdded.toString();

        }
    }
    public void set(int column,String value){
        switch(column){
            case 0:id=Integer.parseInt(value);break;
            case 1:name=value;break;
            case 2:address=value;break;
            case 3:telephone=Integer.parseInt(value);break;
            case 4:cellphone=Integer.parseInt(value);break;
            case 5:email=value;break;
            case 6:tagName=value;break;
            default: {
                if((value==null)||(value.compareTo("")==0)){
                    Calendar todayCalendar=Calendar.getInstance();
                    dateAdded=new Date(todayCalendar.getTime().getTime());
                }
                else{
                    dateAdded=Date.valueOf(formatDate(value));
                }
            }

        }
    }
    private String formatDate(String s){
        return s.substring(0, 10);
    }
    public String getAddress() {
        return address;
    }

    public int getCellphone() {
        return cellphone;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public String getEmail() {
        return email;
    }

    @Override
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getTagName() {
        return tagName;
    }

    public int getTelephone() {
        return telephone;
    }

    public String[] getColumns() {
        return columns;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setCellphone(int cellphone) {
        this.cellphone = cellphone;
    }

    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }

    public void setTelephone(int telephone) {
        this.telephone = telephone;
    }

    //question
    public boolean isEmptyCustomer(){
        return this.id==0;
    }

    //operations
    public void saveMySelf() throws SQLException {
        CustomerOp c=new CustomerOp();
       try{
           c.saveNewCustomer(this);
       }
       catch(SQLException s){
            System.out.println("Error in sql exception:"+s.getMessage());
            throw new SQLException();
        }
        c.close();
        CustomerQue query=new CustomerQue();
        int length=query.searchAll().length;
        this.setId(query.searchAll()[length-1].getId());
    }
}
