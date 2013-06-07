/*
 * OrdersItem.fx
 *
 * Created on Feb 17, 2010, 5:42:51 PM
 */

package views.orderBrowser.elements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import controllers.dataControllers.Order;
import controllers.viewControllers.OrderMagController;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.layout.VBox;
import javafx.stage.Alert;
import javafx.scene.Cursor;
import javafx.scene.text.TextOrigin;
import javafx.scene.effect.DropShadow;
import javafx.util.Math;

/**
 * @author vic
 */

public-read def WIDTH=167;
public-read def HEIGHT=145;

public class OrdersItem extends CustomNode {

    def SPACING_BASE0_BASE1=2;
    def YTRANSLATION_TOTAL=7;
    def XTRANSLATION_TOTAL=35;
    def HSPACING_TEXTS=5;
    def SPACING_BASE1_TEXTS=5;//this is the spacing between the delete button and the texts
    def SPACING_OF_NONPRODUCTNAME=84;
    def DELETEBUTTONWIDTH=10;

    var cname:String;
    var caddress:String;
    var cTel:String;
    var quantity:Integer;
    var productName:String;
    var productTotal:Number;
    var total:Number;

    public var model:Order on replace{
        if(model!=null){
            cname=rowWidthFixer(model.getCustomer().getName(),0);
            caddress=rowWidthFixer(model.getCustomer().getAddress(),0);
            cTel=rowWidthFixer(Integer.toString(model.getCustomer().getTelephone()),0);
            quantity=model.getMainProduct().getQuantity();
            productName=rowWidthFixer(model.getMainProduct().getModel().getProduct(),1);
            productTotal=round(model.getMainProduct().getPrice()*model.getMainProduct().getQuantity());
            total=round(model.getTotal());
        }
    }

    public var selectedState:Boolean on replace{
        if(selectedState){
            setEffectOfSelection(0);
        }
    }


    //cut the strings, so they can fix in the component. Criteria==0 means that is a customer.text
    function rowWidthFixer(s:String,criteria:Integer):String{
       var result=s;
       def size=s.length();
       def MAXNUMOFCHAR=  if(criteria==0){(WIDTH-4*SPACING_BASE0_BASE1)/6;}
                            else {(WIDTH-4*SPACING_BASE0_BASE1-SPACING_OF_NONPRODUCTNAME)/6;}
       if(size>MAXNUMOFCHAR){
               def r=s.substring(0,MAXNUMOFCHAR-2);
               result="{r}..";
           }
        return result;
    }

   function round(n:Double):Number{
        def n1=(Math.round(n*100));
        var d:Double=n1 mod 100;
        d=d/100;
        def m=n1/100;
        return m+d;
 }


   public function setEffectOfSelection(criteria:Integer):Void{
        if(criteria==0){
            base1.effect=DropShadow{
                    color:Color.RED
                    offsetY:2
                }
                fillIndex=1;
        }
        else{
            base1.effect=null;
            fillIndex=0;
        }
    }

     def fillBase=[Color.BLACK,Color.RED];
     var fillIndex=0;

    //backgrounds
    def base0=Rectangle{
        width:WIDTH
        height:bind HEIGHT
        arcWidth:15
        arcHeight:15
        fill:bind fillBase[fillIndex]
        stroke:bind fillBase[fillIndex]
        strokeWidth:1
        onMouseClicked:function(event){
            if(event.clickCount==2){
                setEffectOfSelection(0);
                OrderMagController.setSelectedOrder(model);
            }
        }
    }

     def base1=Rectangle{
        width:WIDTH-2*SPACING_BASE0_BASE1
        height:bind HEIGHT-2*SPACING_BASE0_BASE1
        layoutY:SPACING_BASE0_BASE1
        layoutX:SPACING_BASE0_BASE1
        arcWidth:15
        arcHeight:15
        stroke:bind fillBase[fillIndex]
        strokeWidth:1
        fill:LinearGradient{
            startX:0 startY:1
            endX:1 endY:0
            proportional:true
            stops:[Stop{
                        offset:0
                        color:Color.BLACK
                   }
                   Stop{
                        offset:0.4
                        color:Color.LIGHTGRAY
                   }
                   Stop{
                        offset:1
                        color:Color.BLACK
                   }
                    ]
        }
    }

    //delete button
    def deleteBackground=Rectangle{
        arcWidth:5
        arcHeight:5
        width:20
        height:20
        fill:Color.RED
        cursor:Cursor.HAND
        onMouseClicked:function(event){
            if(Alert.confirm("Cancel Order","Are you sure that you want to cancel this order?")){
                OrderMagController.deleteOrder(model);
            }
        }
    }
    def deleteT=Text{
        content:"X"
        layoutX:5
        layoutY:5
        textOrigin:TextOrigin.TOP
        font:Font{
            size:10
        }
        fill:Color.WHITE
        cursor:Cursor.HAND
    }
    def deleteB=Group{
        content:[deleteBackground,deleteT]
        layoutX:bind base1.width+base1.layoutX-25
        layoutY:base1.layoutY

    }


    //content
    //customer data
    def name=Text{
        content:bind cname
        font:Font{
            size:12
        }
        fill:Color.WHITE
    }

    def address=Text{
        content:bind caddress
        font:Font{
            size:12
        }
        fill:Color.WHITE
    }

    def tel=Text{
        content:bind cTel
        font:Font{
            size:12
        }
        fill:Color.WHITE
    }

    def mp=Text{
        content:"Main Product"
        font:Font{
            size:13
            embolden:true
        }
        fill:Color.WHITE
    }

    def mProduct=Text{
        content:bind " {quantity} {productName}..${productTotal}"
        font:Font{
            size:12
        }
        fill:Color.WHITE
    }

    def totalT=Text{
        content:bind "Total.......${total}"
        font:Font{
            size:13
            embolden:true
        }
        fill:Color.WHITE
        translateY:YTRANSLATION_TOTAL
        translateX:XTRANSLATION_TOTAL
    }

    def content=VBox{
        content:[name,address,tel,mp,mProduct,totalT]
        layoutX:base1.layoutX+SPACING_BASE1_TEXTS
        layoutY:deleteB.layoutY+SPACING_BASE1_TEXTS+DELETEBUTTONWIDTH
        spacing:HSPACING_TEXTS
    }

    public override function create(): Node {
        return Group {
                    content: [base0,base1,deleteB,content]
                };
    }
}
