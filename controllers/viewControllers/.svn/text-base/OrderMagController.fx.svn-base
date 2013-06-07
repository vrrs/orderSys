/*
 * OrderMagController.fx
 *
 * Created on Feb 11, 2010, 12:32:10 AM
 */

package controllers.viewControllers;

import controllers.dataControllers.OrderManag;
import controllers.dataControllers.Order;
import views.orderBrowser.elements.OrdersItem;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import views.orderBrowser.OrderBrowserView;
import javafx.stage.Alert;

/**
 * @author vic
 */

//properties{
 //order properties{
 
public var order:Order;

 def updater=bind OrderViewController.orderTrigger on replace{
     if(updater){
         trigger(1);
         OrderViewController.orderTrigger=false;
     }
 }

public var orderHasChanged=false;
function triggerOM(){
    orderHasChanged=true;
}


 public var orderListHasChanged=false;
 public var orderList:OrdersItem[];
 //}
 //provate properties
 var orderMag:OrderManag;
 var down:Boolean;
 //private final properties
 def time=Timeline{
    autoReverse:true
    repeatCount: Timeline.INDEFINITE
    keyFrames:[KeyFrame{
                      time:0s
                      action:function(){}
                      }
                KeyFrame{
                      time:0.5s
                      action:function(){
                           if(down){
                               orderMag.selectNextOrder();
                               trigger(0);
                               OrderBrowserView.orderItems.increment();
                           }
                           else{
                               orderMag.selectPreviousOrder();
                               trigger(0);
                               OrderBrowserView.orderItems.decrement();
                           }
                      }
                }
              ]
}
//}

//private operations
 function trigger(criteria:Integer){
    delete orderList;
    for(i in [0..<orderMag.size()]){
        orderList[i]=OrdersItem{model:orderMag.get(i) selectedState:i==orderMag.indexOf(orderMag.getSelectedOrder())}
    }
    
    order=orderMag.getSelectedOrder();
    if(criteria==0)triggerOM();
    orderListHasChanged=true;
}

//operations{
 //Upper buttons operations{
 /*      Move the scrollbar up. When the state is 0, it means that it shoud move the scrollbar up. When state==1,
   it means that it should stop moving up the scrollbar.
*/
 public function goUp(state:Integer):Void{
    down=false;
    if(state==0){
        OrderBrowserView.orderItems.setIncrementValue(0);
        time.playFromStart();
    }
    else{
        OrderBrowserView.orderItems.setIncrementValue(1);
        time.stop();
    }
}
 public function goDown(state:Integer):Void{
    down=true;
    if(state==0){
        OrderBrowserView.orderItems.setIncrementValue(0);
        time.playFromStart();
    }
    else{
        OrderBrowserView.orderItems.setIncrementValue(1);
        time.stop();
    }
}
 //}
 //Internal view operations{
 public function deleteOrder(o:Order):Void{
    orderMag.removeElementAt(orderMag.indexOf(o));
    trigger(0);
}
 public function setSelectedOrder(o:Order):Void{
    orderMag.setSelectedOrder(o);
    trigger(0);
}
 //}
 //Lower buttons operations{
 public function newOrder():Void{
    orderMag.newOrder();
    trigger(0);
}
 public function DeleteAll():Void{
    if(Alert.confirm("Cancell All","Are you sure that you want to cancell all the orders?")){
        orderMag.CancellAll();
        trigger(0);
    }
}
 //}
 //external operations
 public function openOrder(order:Order):Void{
     orderMag.add(order);
     orderMag.setSelectedOrder(order);
     trigger(0);
 }
//}

public class OrderMagController {  

    init{
        orderMag=new OrderManag();
        order=orderMag.getSelectedOrder();
        trigger(0);
    }

}
