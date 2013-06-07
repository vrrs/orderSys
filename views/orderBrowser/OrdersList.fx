/*
 * OrdersList.fx
 *
 * Created on Feb 17, 2010, 5:43:25 PM
 */

package views.orderBrowser;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.shape.Rectangle;
import views.orderBrowser.elements.OrdersItem;
import javafx.scene.paint.Color;
import javafx.scene.control.ScrollBar;
import javafx.scene.layout.ClipView;
import controllers.viewControllers.OrderMagController;
import javafx.scene.layout.VBox;

/**
 * @author vic
 */


public class OrdersList extends CustomNode {

    def NUMBEROFORDERS=3;
    def SCROLLBARWIDTH=5;
    def HSPACING_ERROR=11;
    def VSPACING_ERROR=20;
    def HSPACING_VIEW_ITEM=0;
    def VSPACING_ITEMS=3;

    public-read def HEIGHT=NUMBEROFORDERS*(OrdersItem.HEIGHT+VSPACING_ITEMS)+VSPACING_ERROR;
    public-read def WIDTH=SCROLLBARWIDTH+OrdersItem.WIDTH+HSPACING_ERROR+HSPACING_VIEW_ITEM;

    def background=Rectangle{
        width:WIDTH
        height:HEIGHT
        fill:Color.WHITESMOKE
    }

    public var itemS:OrdersItem[];
    var toDisable=true;

    var extraSpace=0;
    def updater=bind OrderMagController.orderListHasChanged on replace{
        if(updater){
            delete itemS;
            itemS=OrderMagController.orderList;
            if(sizeof itemS>NUMBEROFORDERS){
                  extraSpace=(sizeof itemS-NUMBEROFORDERS)*(OrdersItem.HEIGHT+VSPACING_ITEMS+VSPACING_ERROR/4);
                  toDisable=false;
            }
            OrderMagController.orderListHasChanged=false;
        }
    }

    def items=VBox{
        content:bind itemS
        spacing:VSPACING_ITEMS
        layoutX:HSPACING_VIEW_ITEM
        translateY:bind -scrollbar.value
    }
 
    def scrollbar=ScrollBar{
        height:HEIGHT
        vertical:true
        min:0
        max:bind extraSpace
        disable:bind toDisable
        layoutX:WIDTH-SCROLLBARWIDTH
    }

    var scrollbarValue:Number;
    public function increment(){
        scrollbar.increment();
    }
    public function decrement(){
        scrollbar.decrement();;
    }
    public function setIncrementValue(criteria:Integer){
        def unitIncrement=OrdersItem.HEIGHT*1.3;
        if(criteria==0){
            scrollbarValue=scrollbar.unitIncrement;
            scrollbar.unitIncrement=unitIncrement;
        }
        else{
            scrollbar.unitIncrement=scrollbarValue;
        }

    }

    def view=ClipView{
        node:items
        clipX:0
        clipY:0
        width:WIDTH-SCROLLBARWIDTH
        layoutX:HSPACING_VIEW_ITEM
        height:HEIGHT
        pannable:false
    }

    public override function create(): Node {
        return Group {
                    content: [background,view,scrollbar]
                };
    }
}

