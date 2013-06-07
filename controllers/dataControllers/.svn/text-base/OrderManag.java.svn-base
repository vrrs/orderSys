
package controllers.dataControllers;

import java.sql.SQLException;
import java.util.Vector;

public class OrderManag extends Vector<Order>{
    private Order selectedOrder;

    //constructor
    public OrderManag(){
        super();
        setDefaultOrder();
    }

    //private operations
    private void setDefaultOrder(){
            Order defaultOrder=null;
            try{
                defaultOrder=new Order();
            }
            catch(SQLException s){
                System.out.println("Error in orderMag.setDefault Method:"+s.getMessage());
            }
            selectedOrder=defaultOrder;
            this.add(defaultOrder);
   }
  //accessors
    //getters{
    public Order getSelectedOrder() {
        return selectedOrder;
    }
    //setters
    public void setSelectedOrder(int pos){
        selectedOrder=this.get(pos);
    }
    public void setSelectedOrder(Order r){
        selectedOrder=r;
    }
  //}

  //operations{
    public void newOrder() throws SQLException{
        Order n=null;
        try{n=new Order();}
        catch(SQLException s){
            throw new SQLException("Error in new order Method:"+s.getMessage());
        }
        this.add(n);
        if(selectedOrder.isEmpty()){
            this.removeElement(selectedOrder);
        }
       selectedOrder=n;
    }
    public void CancellAll(){
        this.removeAllElements();
        setDefaultOrder();
    }
    public void replaceSelectedOrder(Order newOrder){
        int index=this.indexOf(selectedOrder);
        this.removeElementAt(index);
        this.insertElementAt(newOrder, index);
        selectedOrder=newOrder;System.out.println("here cono:"+this.get(0).getCustomer().getName()+","+selectedOrder.getCustomer().getName());
    }
    public void selectNextOrder(){
        int index=this.indexOf(selectedOrder);
        if(index+1==this.size()){
            index=0;
        }
        else{
            index++;
        }
        selectedOrder=this.get(index);
    }
    public void selectPreviousOrder(){
        int index=this.indexOf(selectedOrder);
        if(index-1<0){
            index=this.size()-1;
        }
        else{
            index--;
        }
        selectedOrder=this.get(index);
    }
    //Assumption:When the selectedOrder is deleted from this, the private var obj
    //is deleted,too.
    @Override
    public synchronized void removeElementAt(int index) {
        int indexSelected=this.indexOf(selectedOrder);
        super.removeElementAt(index);
        if(indexSelected==index){
            if(this.size()==0){
                setDefaultOrder();
            }
            else{
                if(index==0){
                    selectedOrder=this.get(0);
                }
                else{
                     selectedOrder=this.get(--index);
                }
            }
        }
    }
}
