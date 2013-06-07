/*
 * OrderBrowserView.fx
 *
 * Created on Feb 17, 2010, 1:52:02 PM
 */
package views.orderBrowser;

import javafx.scene.shape.Rectangle;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.paint.Color;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import views.orderBrowser.elements.UpButton;
import views.orderBrowser.elements.DownButton;
import javafx.scene.layout.HBox;
import javafx.geometry.VPos;
import javafx.scene.control.Button;
import controllers.viewControllers.OrderMagController;
import javafx.scene.text.TextOrigin;

/**
 * @author vic
 */
public-read def HEIGHT = 672;
public-read def WIDTH = 196;
public var orderItems:OrdersList;

public class OrderBrowserView extends CustomNode {

    //intersection constants
    def BACKGROUND_CONTENT_SPACING = 42;
    def HSPACING_TITLE_BUTTONS=35;
    def VSPACING_BUTTONS_ORDERLIST=28;
    def VSPACING_ORDERLIST_TITLES=25;
    def HSPACING_BACKGROUND=3;
    def VSPACING_TOTALT_ORDERLIST=20;

    //section constants
    def HSPACING_BETWEEN_BUTTONS=5;
    def HSPACING_BACKGROUND_BUTTONS=4;
    
    
    def background = Rectangle {
                width: WIDTH
                height: HEIGHT
                arcWidth: 10
                arcHeight: 10
                fill: LinearGradient {
                            startX: 1 startY: 0
                            endX: 0 endY: 1
                            proportional: true
                            stops: [Stop {
                                offset: 0
                                color: Color.RED
                            },
                            Stop {
                                offset: 0.14
                                color: Color.GRAY
                            },
                            Stop {
                                offset: 0.7
                                color: Color.BLACK
                            },
                            Stop {
                                offset: 1
                                color: Color.GRAY
                            }
                            ]
                        }
            }
    //content section{

    //title section
    def title=Text{
        content:"Orders"
        font:Font{
            size:19
            embolden:true
        }
        fill:Color.BLACK
    }
    //buttons
    def upB=UpButton{
            mousePressedFunc:function(){
                OrderMagController.goUp(0);
            }
            mouseReleasedFunc:function(){
                OrderMagController.goUp(1);
            }
    }
    def downB=DownButton{
        mousePressedFunc:function(){
                 OrderMagController.goDown(0);
        }
        mouseReleasedFunc:function(){
                OrderMagController.goDown(1);
        }
    }
    def buttons=HBox{
        spacing:HSPACING_BETWEEN_BUTTONS
        translateY:-27
        content:[upB,downB]
    }

    def titleSec=HBox{
        layoutY:BACKGROUND_CONTENT_SPACING
        layoutX:HSPACING_BACKGROUND
        spacing:HSPACING_TITLE_BUTTONS
        nodeVPos: VPos.BOTTOM
        content:[title,buttons]
    }
    //}

    init{
          orderItems=OrdersList{
                        layoutX:titleSec.layoutX
                        layoutY:titleSec.layoutY+titleSec.height+VSPACING_ORDERLIST_TITLES
                     }
         }

    //total orderSec
    def totalT=Text{
        content:bind "Total:...{sizeof orderItems.itemS} orders"
        font:Font{
            size:15
            embolden:true
        }
        fill:Color.WHITE
        textOrigin:TextOrigin.TOP
        layoutX:bind orderItems.layoutX+HSPACING_BACKGROUND_BUTTONS
        layoutY:bind orderItems.layoutY+orderItems.HEIGHT+VSPACING_TOTALT_ORDERLIST

    }

    //buttons section
    def button1=Button{
        text:"New Order"
        action:function(){
            OrderMagController.newOrder();
        }
    }
    def button2=Button{
        text:"Delete All"
        action:function(){
            OrderMagController.DeleteAll();
        }
    }
    def buttonSec=HBox{
        content:[button1,button2]
        spacing:20
        layoutX:bind totalT.layoutX+HSPACING_BACKGROUND_BUTTONS
        layoutY:bind totalT.layoutY+totalT.boundsInLocal.height+VSPACING_BUTTONS_ORDERLIST
    }

   public override function create(): Node {
		return Group {
			content: bind [background,titleSec,orderItems,totalT,buttonSec]
		};
	}
            
}
