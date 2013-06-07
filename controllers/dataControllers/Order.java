

package controllers.dataControllers;

import java.io.Serializable;
import java.util.Calendar;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Vector;
import models.ModelSettings;
import models.customerT.CustomerDB;
import models.customerT.CustomerQue;
import models.orderInT.OrderInDB;
import models.orderInT.OrderInQue;
import models.orderT.OrderDB;

public class Order implements Cloneable,Serializable{
  
  //properties {
    //customer properties
    private CustomerDB customer;
    private final int NULL_CUSTOMER=0;
    private CustomerDB nullCustomer;

    //order properties
    private transient OrderInDB orderinfo;
    private transient OrderDB[] order;
    private transient int orderID=0;
    
    //item properties
    private Vector<Item> items=new Vector<Item>();
    private Vector<Integer> taxedItems; 
    private double salesTaxRate;
    private Item mainProduct=new Item();
  //}

    //constructor
    public Order() throws SQLException{
        try{
            setNullCustomer();
            customer=nullCustomer;
        }
        catch(SQLException s){
            throw new SQLException("Error in order.constructor:"+ s.getMessage());
        }
       updateTaxadValues();
    }

  //internal operations {
    private void createId(){
        OrderInQue q=new OrderInQue();
        OrderInDB[] rows=null;
        boolean flag=false;
        int lastid=-1;
        try{
            rows=q.allRows();
        }
        catch(SQLException s){
            flag=true;
            System.out.println("Error in order.createId:"+s.getLocalizedMessage());
        }

        if(!flag & rows.length>0){
           lastid=rows[rows.length-1].getId();
        }
        orderID=++lastid;
    }
    //setup the order to be print or saved
    private void setupOrder() {
        //determine the id
        createId();
        
        //determine the date
        Calendar todayCalendar=Calendar.getInstance();
        Date date=new Date(todayCalendar.getTime().getTime());

       //setup the orderDB object
        order=new OrderDB[items.size()];
        for(int i=0;i<items.size();i++){
          order[i]=new OrderDB();
          order[i].setId(orderID);
          order[i].setIdProduct(items.get(i).getProductID());
          order[i].setQuantity(items.get(i).getQuantity());
        }
       //calculate the total
       double total= getTotal();
       //setup the orderInfo obj
       int customerID=customer.getId();
       orderinfo=new OrderInDB(orderID,customerID,date,total);
       //}
    }
    //operations to update mainProduct
    private void updateMainProduct(Item i){
        if(i.getPrice()*i.getQuantity()>mainProduct.getPrice()*mainProduct.getQuantity()){
            mainProduct=i;
        }
    }
   private void searchNewMainProduct(){
        if(items.size()>0){
            Item mayor;
            mayor=items.get(0);
            for(int i=1;i<items.size();i++){
                Item temp=items.get(i);
                if(temp.getPrice()*temp.getQuantity()>mayor.getPrice()*mayor.getQuantity()){
                    mayor=items.get(i);
                }
            }
            mainProduct=mayor;
        }
        else{
            mainProduct=new Item();
        }
    }
 //}

   //properties accessors{
    //getters{
    public CustomerDB getNullCustomer(){
        return nullCustomer;
    }
    public CustomerDB getCustomer() {
        return customer;
    }
    public double getSalesTaxRate() {
        return salesTaxRate;
    }
    public int getOrderID(){
        return this.orderID;
    }
    //}
    //setters
    public void setCustomer(CustomerDB customer) {
        this.customer = customer;
    }
    private void setNullCustomer() throws SQLException{
        CustomerQue cQuery=new CustomerQue();
       try{
           nullCustomer=cQuery.searchByID(NULL_CUSTOMER);}
       catch(SQLException s){
           throw new SQLException("Error in setNullCustomer Method"+ s.getMessage());
       }

    }
  //}

    //external operations{
    public void save() throws Exception{
        setupOrder();
        try{
            orderinfo.saveMySelf();
            for(int i=0;i<order.length;i++) order[i].saveMySelf();
        }
        catch(SQLException e){
            throw new Exception("order.save Error:Save Operation fail:"+e.getLocalizedMessage()+","+e.getMessage()+","+e.getErrorCode());
        }
    }
    public void print(int i){
        this.createId();
        PrinterController printer=new PrinterController();
        printer.setOrder(this);
        if(i==0){
            printer.setChefDoc(true);
        }
        else{
            printer.setChefDoc(false);
        }
        printer.printDoc();
    }
    //}

    //questions
    public boolean isEmpty(){
        return (isNullCustomer()&items.size()==0);
    }
    public boolean isNullCustomer(){
        return nullCustomer==customer;
    }

  //items methods{
    //accessors
    public Item[] getItems(){
        Item[] r=new Item[items.size()];
        items.copyInto(r);
        return r;
    }
    public Item getMainProduct(){
        return mainProduct;
    }
    
    //item collection managment method
    public int indexOfItem(Item i){
        return items.indexOf(i);
    }
    public void addItem(Item i){
        updateMainProduct(i);
        items.add(i);
    }
    public void editQuantityInItem(Item i,int nQuantity){
        i.setQuantity(nQuantity);
        updateMainProduct(i);
    }
    public Item getItem(int pos) throws ArrayIndexOutOfBoundsException{
        if((pos>=items.size())|(pos<0))
             throw new ArrayIndexOutOfBoundsException("Error in order.getItem:Out of range");
        else
            return items.get(pos);
    }
    public void removeItem(int pos) throws ArrayIndexOutOfBoundsException{
        if((pos>=items.size())|(pos<0))
                throw new ArrayIndexOutOfBoundsException("Error in order.removeItem:Out of range");
        else{
            int mainItemPos=indexOfItem(mainProduct);
            items.removeElementAt(pos);
            if(pos==mainItemPos){
               searchNewMainProduct();
            }
        }
    }
    public void replaceItem(int pos,Item newItem)throws ArrayIndexOutOfBoundsException{
        if((pos>=items.size())|(pos<0))
            throw new ArrayIndexOutOfBoundsException("Error in order.replaceItem:Out of range");
        else{
            removeItem(pos);
            items.insertElementAt(newItem, pos);
        }
    }
    
    //item processing methods
    public double getSubTotal()  {
       double total=0;
       for(int i=0;i<items.size();i++){
             total+=items.get(i).getModel().getPrice()*items.get(i).getQuantity();
       }
        return total;
    }
    public double getTotal() {
        double untaxedSum=0;
        double taxedSum=0;
        for(int i=0;i<items.size();i++){
            if(SettingsController.isTaxedItem(taxedItems,items.get(i).getModel().getId())){
                taxedSum+=items.get(i).getModel().getPrice()*items.get(i).getQuantity();
            }
            else{
                untaxedSum+=items.get(i).getModel().getPrice()*items.get(i).getQuantity()*(salesTaxRate+1);
            }
        }
        return taxedSum+untaxedSum;
    }
    public double getUntaxedItemTotal(){
        double untaxedSum=0;
        for(int i=0;i<items.size();i++){
            if(!SettingsController.isTaxedItem(taxedItems,items.get(i).getModel().getId())){
              untaxedSum+=items.get(i).getModel().getPrice()*items.get(i).getQuantity()*(salesTaxRate);
            }
        }
        return untaxedSum;
    }
  //}
    public void updateTaxadValues(){
         SettingsController s=new SettingsController(0);
        ModelSettings setting=s.getSetting();
        salesTaxRate=setting.getTaxrate();
        taxedItems=setting.getTaxedItems();
    }
    @Override
    public Order clone(){
        return this.clone();
    }
}