/*
 * OrderView.fx
 *
 * Created on Feb 11, 2010, 12:31:37 AM
 */

package views.orderView;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import views.orderView.elements.SearchBoxOV;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import views.orderView.elements.ModeB;
import javafx.geometry.HPos;
import javafx.geometry.VPos;
import controllers.viewControllers.OrderViewController;
import javafx.scene.control.Button;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.paint.Color;
import javafx.scene.text.TextOrigin;

/**
 * @author vic
 */
public var WIDTH;
public var HEIGHT;
public var boxes:SearchBoxOV[];

public class OrderView extends CustomNode {

    //section internal consts
    def SPACING_BETWEEN_TEXTBOXES=10;
    def VSPACING_BETWEEN_TEXTBOXES=15;
    def VSPACING_BETWEEN_PRODUCTTITLE_ITEMS=5;
    def SPACING_BETWEEN_SUBTOTAL_TOTAL=14;
    def SPACING_BETWEEN_BUTTONS=50;

    //inter-section consts{
    def VSPACE_BETWEEN_BACKGROUND_COMPS=7;
    def SPACING_BETWEEN_BACKGROUND_COMPS=5;
    def VSPACING_BETWEEN_TITLE_TEXTBOXES=15;
    def VSPACING_BETWEEN_TEXTBOXES_PRODUCTLIST=25;
    def VSPACING_BETWEEN_PRODUCTLIST_TOTALSEC=15;
    def VSPACING_BETWEEN_TOTALSEC_BUTTONS=20;
    //}
    def TOTAL=VSPACE_BETWEEN_BACKGROUND_COMPS+VSPACING_BETWEEN_TITLE_TEXTBOXES+
              VSPACING_BETWEEN_TEXTBOXES_PRODUCTLIST+VSPACING_BETWEEN_PRODUCTLIST_TOTALSEC+
              VSPACING_BETWEEN_TOTALSEC_BUTTONS;

    var w:Number=0;    //buttonSec width translation updater

    var subtotalT:String="Subtotal...............................$0.00";
    var taxT:String="Sales Tax............................$0.00";
    var totalT:String="         Total....................$0.00";

    def updater=bind OrderViewController.itemHasChangedOV on replace{
        if(updater){
            subtotalT="Subtotal...............................${OrderViewController.getSubTotal()}";
            totalT="         Total....................${OrderViewController.getTotal()}";
            taxT="Sales Tax............................${OrderViewController.getTax()}";
            OrderViewController.itemHasChangedOV=false;
        }
    }

    init{
       HEIGHT=TOTAL+top.layoutBounds.height+searchs.layoutBounds.height+productList.layoutBounds.height+
              totalsSec.layoutBounds.height+buttonSec.layoutBounds.height+2*VSPACE_BETWEEN_BACKGROUND_COMPS;
       WIDTH=productList.layoutBounds.width+2* SPACING_BETWEEN_BACKGROUND_COMPS;
       background.width=WIDTH;
       background.height=HEIGHT;
       w=(WIDTH-buttonSec.width)/2;
    }

    def background:Rectangle=Rectangle{
	arcWidth:10
        arcHeight:10
        fill:LinearGradient{
            proportional:true;
            startX:0 startY:0 endX:0 endY:1
            stops:[
                    Stop{
                     color:Color.GRAY
                     offset:0
                   }
                    Stop{
                     color:Color.BLACK
                     offset:0.76
                   }
                   Stop{
                     color:Color.GRAY
                     offset:.8
                   }
                   Stop{
                     color:Color.BLACK
                     offset:1
                   }
                 ]
        }
    }

    //title section{
    def title=Text{
        content:"Current Order"
        font:Font{ size:19 embolden:true}
    }
    def modeB:ModeB=ModeB{ translateX:50 }
    def top=HBox{
        layoutY:VSPACE_BETWEEN_BACKGROUND_COMPS
        nodeVPos: VPos.BOTTOM
        content:[title,modeB]
    }
    //}

    //searchBoxes section{
    def titles=["Name","Tag","Address","Telephone","Email","Cellphone"];
    def searchTypes=[1,6,2,3,5,4];
    def searchs=Group{
        layoutY:top.layoutY+top.height+VSPACING_BETWEEN_TITLE_TEXTBOXES
        content:for(i in [0,2,4])
                HBox{
                    layoutY:(VSPACING_BETWEEN_TEXTBOXES+SearchBoxOV.getHeight())*(i/2)
                    spacing:SPACING_BETWEEN_TEXTBOXES
                    nodeVPos:VPos.TOP
                    content:[boxes[i]=SearchBoxOV{
                                 searchType:searchTypes[i]
                                 label:titles[i]
                                 id:titles[i]
                             },
                             boxes[i+1]=SearchBoxOV{
                                 searchType:searchTypes[i+1]
                                 label:titles[i+1]
                                 id:titles[i]
                             }

                    ]
                }

    }
    //}
    //productList section{
    def productL=Text{
        content:"Products"
        textOrigin:TextOrigin.TOP
        font:Font{ size:17 embolden:true}
    }
    def items=ItemList{layoutY:productL.boundsInLocal.height+VSPACING_BETWEEN_PRODUCTTITLE_ITEMS}
    def productList=Group{
        layoutY:searchs.layoutY+searchs.boundsInLocal.height+VSPACING_BETWEEN_TEXTBOXES_PRODUCTLIST
        content:[productL,items]
    }
    //}

    //totals section{
    def subtotal=Text{
        content:bind subtotalT
        textOrigin:TextOrigin.TOP
        font:Font{
            size:16
        }
    }
    def salesTax=Text{
        content:bind taxT
        textOrigin:TextOrigin.TOP
        font:Font{
            size:16
        }
    }
    def g=VBox{
        spacing:3
        content:[subtotal,salesTax]
    }

    def total=Text{
        content:bind totalT
        textOrigin:TextOrigin.TOP
        font:Font{
            size:16
        }
    }
    def totalsSec=VBox{
        layoutY:productList.layoutY+productList.boundsInLocal.height+VSPACING_BETWEEN_PRODUCTLIST_TOTALSEC
        spacing:SPACING_BETWEEN_SUBTOTAL_TOTAL
        nodeHPos: HPos.RIGHT
        content:[g,total]
    }
    //}

    //buttons section{
    def print=Button {
	text: "Print"
	action: function() {
		OrderViewController.print();
	}
        font:Font{
            size:16
        }

    }
    def pay=Button {
	text: "Pay"
	action: function() {
		OrderViewController.pay();
	}
        font:Font{
            size:16
        }
    }
    def buttonSec=HBox{
        layoutY:totalsSec.layoutY+totalsSec.height+VSPACING_BETWEEN_TOTALSEC_BUTTONS
        translateX:bind w
        spacing:SPACING_BETWEEN_BUTTONS
        content:[print,pay]
    }

    //all the components
    def content=Group{
        layoutX:SPACING_BETWEEN_BACKGROUND_COMPS
        content:[top,searchs,productList,totalsSec,buttonSec]
    }

    public override function create(): Node {
        return Group {
                    content: [background,content]
                }
    }
}
