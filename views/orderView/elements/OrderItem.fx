/*
 * OrderItem.fx
 *
 * Created on Feb 10, 2010, 3:43:43 PM
 */

package views.orderView.elements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import models.menuT.MenuDB;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.layout.HBox;
import javafx.geometry.VPos;
import javafx.scene.layout.VBox;
import javafx.scene.text.TextOrigin;
import controllers.viewControllers.OrderViewController;
import javafx.scene.control.TextBox;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import javafx.animation.Interpolator;
import java.lang.NumberFormatException;
import javafx.stage.Alert;
import controllers.dataControllers.Item;
import javafx.scene.Cursor;

/**
 * @author vic
 */

 public def WIDTH=260;
 public def HEIGHT=50;

public class OrderItem extends CustomNode {
    
    def WIDTH_BETWEEN_BASES=2;
    def WIDTH_TOP_BASES=WIDTH-WIDTH_BETWEEN_BASES*2;
    def HEIGHT_BETWEEN_BASES=2;
    def HEIGHT_TOP_BASES=(HEIGHT-HEIGHT_BETWEEN_BASES*2)/2;

    function price(s:String):String{
        return "${s}";
    }
    function title(s:String):String{
        def MAX_NUM_CHAR=34;
        if(s.length()<=MAX_NUM_CHAR){
            return s
        }
        else{
            var r=s.substring(0, MAX_NUM_CHAR-2);
            return "{r}..";
        }
    }
    public-init var item:Item;
    public-init var model:MenuDB=if(item!=null){item.getModel()} else null;
    public-init var quantity=if(item!=null){item.getQuantity()} else 1;

    var toDisable=true;
    var h=0;
    function hide(){
        time.pause();
        time.rate=-1;
        time.play();
    }

    function show(){
        if(time.running) {time.pause();}
        time.rate=1;
        time.playFromStart();
    }

    def time=Timeline{
        keyFrames:[
                    KeyFrame{
                        time:0s
                        values:[h=>0]
                        action:function(){
                            toDisable=not toDisable;
                        }
                    }
                    KeyFrame{
                        time:0.5s
                        values:[h=>16 tween Interpolator.LINEAR]
                    }
                ]
    }


    def base:Rectangle=Rectangle{
        width:WIDTH
        height:HEIGHT
        fill:Color.LIGHTGRAY
        arcWidth:15
        arcHeight:15
        onMouseClicked:function(event){
            show();
            qTextBox.requestFocus();
        }

    }

    def top=Rectangle{
        width:WIDTH_TOP_BASES
        height:HEIGHT_TOP_BASES
        fill:LinearGradient{
            startX:0 startY:0
            endX:0 endY:HEIGHT_TOP_BASES
            stops:[
                   Stop{
                       offset:1
                       color:Color.GRAY
                   }
               ]
        }
    }
    def down=Rectangle{
        layoutY:HEIGHT_TOP_BASES
        width:WIDTH_TOP_BASES
        height:HEIGHT_TOP_BASES
        fill:LinearGradient{
            startX:0 startY:HEIGHT_TOP_BASES
            endX:0 endY:HEIGHT_TOP_BASES*2
            stops:[
                   Stop{
                       offset:1
                       color:Color.BLACK
                   }
               ]
        }
   }

    def bases=Group{
        content:[top,down]
    }

    def deleteButton=Text{
        content:"X"
        translateX:bases.boundsInLocal.width-12
        font:Font{
            size:9
        }
        fill:Color.RED
        cursor:Cursor.HAND
        onMouseClicked:function(event){
            OrderViewController.deleteItem(item);
        }

    }
    def backgroundForDelete=Rectangle{
        width:30
        height:30
        cursor:Cursor.HAND
        translateX:bases.boundsInLocal.width-12-20
        opacity:0
        blocksMouse:true
        onMouseClicked:function(event){
            OrderViewController.deleteItem(item);
        }
    }

    def q=Text{
        content:"{quantity}"
        font:Font{
            size:11
        }
        fill:Color.WHITE
    }

    def row1=Group{
        content:[q,deleteButton]
    }


    var pos:Text;
    var product:Text;
    var texts:HBox=HBox{
        spacing:5
        nodeVPos: VPos.CENTER
        content:[
                product=Text{
                    content:title(model.getProduct())
                    textOrigin:TextOrigin.TOP
                    font:Font{
                        size:12
                    }
                    fill:Color.WHITE
                },
               pos=Text{
                    translateX:top.boundsInLocal.width-product.boundsInLocal.width-48
                    content:price(model.getPrice().toString())
                    textOrigin:TextOrigin.TOP
                     font:Font{
                        size:12
                    }
                    fill:Color.WHITE
                }
              ]
    }

   def contentT=VBox{
        spacing:7
        layoutY:2
        layoutX:2
        content:[row1,texts]
    }

    def qTextBox:TextBox=TextBox{
        disable:bind toDisable
        visible:bind not toDisable
        layoutY:base.layoutBounds.height+1
        translateX:2
        selectOnFocus:false
        text:"{quantity}"
        height:bind h
        action:function(){
            hide();
            var p;
            var flag=true;
            try{
                    p=Integer.parseInt(qTextBox.text);}
            catch(s:NumberFormatException){
                Alert.inform("Alert:Wrong Input","The quantity must be an integer number.Please, insert the value again,thanks.");
                p=quantity;
                flag=false;
            }
            quantity=p;
            if(flag){
                OrderViewController.editItem(item,quantity);
            }

            qTextBox.text="{quantity}";
        }
    }
    
    def focus=bind qTextBox.focused on replace oldValue{
        if((not toDisable) and (oldValue)){
            hide();
            var p;
            var flag=true;
            try{
                    p=Integer.parseInt(qTextBox.text);}
            catch(s:NumberFormatException){
                Alert.inform("Alert:Wrong Input","The quantity must be an integer number.Please, insert the value again,thanks.");
                p=quantity;
            }
            quantity=p;
            if(flag){
                OrderViewController.editItem(item,quantity);
            }
            qTextBox.text="{quantity}";
        }
    }

   def content=Group{
        layoutY:2
        layoutX:2
        content:[bases,backgroundForDelete,contentT]
    }


    public override function create(): Node {
        return Group {
                    content: [base,content,qTextBox]
                };
    }
}
