/*
 * OrderViewController.fx
 *
 * Created on Feb 10, 2010, 9:54:43 PM
 */

package controllers.viewControllers;

import controllers.dataControllers.Order;
import controllers.dataControllers.Item;
import models.customerT.CustomerQue;
import models.customerT.CustomerDB;
import javafx.util.Math;
import ordersys.GUI;

/**
 * @author vic
 */

 //properties{
  //item properties
  public var items:Item[];
  public var itemHasChanged:Boolean=false;
  public var itemHasChangedOV:Boolean=false;
  //true means that the textboxes are searchboxes
  public var mode:Boolean=false;
  //customer properties
  public var customer:CustomerDB;
  public var customerTrigger=false;
  public var triggerCount=0;
  //order property
  public var orderOV:Order;
  public var duplicateOrder:Order;
  public var orderTrigger=false;

  def updaterOV=bind OrderMagController.orderHasChanged on replace{
      if(updaterOV){
          orderOV=OrderMagController.order;
          customer=orderOV.getCustomer();
          triggerC(1);
          items=orderOV.getItems();
          trigger(1);
          OrderMagController.orderHasChanged=false;
      }
  }
 //}

 //Internal operations{
  //trigger functions
  function triggerC(criteria:Integer):Void{
        OrderViewController.customerTrigger=true;
        if(criteria==0) triggerO();
 }
  function trigger(criteria:Integer){
    itemHasChanged=true;
    OrderViewController.itemHasChangedOV=true;
    if(criteria==0) triggerO();
}
  function triggerO(){
      orderTrigger=true;
  }

  //numerical presentation function
  function round(n:Double):Double{
    def n1=(Math.round(n*100));
    var d:Double=n1 mod 100;
    d=d/100;
    def m=n1/100;
    return m+d;
 }
  //customer internal operations
  function getCustomer():CustomerDB{
      var cu=new CustomerDB();
      var k=0;
      for(i in [1,6,2,3,5,4]){
         cu.set(i,"{GUI.currentOrder.boxes[k++].searchTextBox.text}");
      }
      return cu;
  }
  //compare customers,true if they are the same.
  function compareCustomers(c1:CustomerDB,c2:CustomerDB):Boolean{
      for(i in [1..6]){
          if(c1.get(i).compareTo(c2.get(i))!=0){
              return false;
          }
      }
      return true;
  }

  function setCustomer():Void{
     def cus:CustomerDB=getCustomer();
     if(not compareCustomers(cus,orderOV.getCustomer())){
          cus.saveMySelf();
          orderOV.setCustomer(cus);
      }
  }

//}

//operations{
  //totalSec operations{
  public function getSubTotal():Number{
     return round(orderOV.getSubTotal());
 }
  public function getTax():Number{
     return round(orderOV.getUntaxedItemTotal());
 }
  public function getTotal():Number{
     return round(orderOV.getTotal());
 }
  //}
  //item managment{
  public function deleteItem(id:Item):Void{
    def i=orderOV.indexOfItem(id);
    orderOV.removeItem(i);
    delete items[i];
    trigger(0);
 }
  public function addItem(i:Item):Void{
    orderOV.addItem(i);
    var temp:Item[];
    for(j in [0..<sizeof orderOV.getItems()]){temp[j]=orderOV.getItem(j);}
    delete items;
    items=temp;
    trigger(0);
 }
  public function editItem(i:Item,nQuantity:Integer):Void{
     orderOV.editQuantityInItem(i,nQuantity);
     trigger(0);
 }
  //}
  //searchBox controller function
  public function submitSearch(s:String,searchBoxType:Integer):Void{
    var cuQ=new CustomerQue();
    def cu:CustomerDB=
        if(searchBoxType==1){
            if(sizeof cuQ.searchByName(s)>0){
                cuQ.searchByName(s)[0];
            }
            else
                orderOV.getNullCustomer();
        }
        else{
            if(searchBoxType==2){
                if(sizeof cuQ.searchByAddress(s)>0){
                cuQ.searchByAddress(s)[0];
            }
            else
                orderOV.getNullCustomer();
            }
            else{
                if(searchBoxType==3){
                  if(sizeof cuQ.searchByTel(Integer.parseInt(s))>0){
                  cuQ.searchByTel(Integer.parseInt(s))[0];
            }
            else
                orderOV.getNullCustomer();
                }
                else{
                    if(searchBoxType==4){
                        if(sizeof cuQ.searchByCel(Integer.parseInt(s))>0){
                 cuQ.searchByCel(Integer.parseInt(s))[0];
            }
            else
                orderOV.getNullCustomer();
                    }
                    else{
                        if(searchBoxType==5){
                            if(sizeof cuQ.searchByEmail(s)>0){
                                cuQ.searchByEmail(s)[0];
            }
            else
                orderOV.getNullCustomer();
                        }
                        else{
                           if(sizeof cuQ.searchBytag(s)>0){
                                cuQ.searchBytag(s)[0];
            }
            else
                orderOV.getNullCustomer();
                        }

                    }

                }

            }

        }
        orderOV.setCustomer(cu);
        customer=orderOV.getCustomer();
        triggerC(0);
 }
  //order operations{
  public function print(){
    setCustomer();
    triggerO();
    orderOV.print(1);
}
  public function pay(){
    setCustomer();
    triggerO();
    orderOV.save();
    orderOV.print(1);
    OrderMagController.deleteOrder(orderOV);
}
  //this is the printing functionality of the pay method
  public function singlePrint(){
      orderOV.print(1);
  }

  //}
//}

public class OrderViewController {}
