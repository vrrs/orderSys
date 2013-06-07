/*
 * SubCatView.fx
 *
 * Created on Mar 26, 2010, 5:06:23 PM
 */

package views.subcatView;

import javafx.scene.CustomNode;
import javafx.scene.paint.Color;
import javafx.scene.paint.Stop;
import models.subcategoryT.SubcategoryQue;
import javafx.scene.Cursor;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.effect.DropShadow;
import javafx.scene.layout.ClipView;
import javafx.scene.layout.VBox;
import javafx.scene.paint.LinearGradient;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import controllers.viewControllers.MenuBrowserController;
import views.orderBrowser.elements.DownButton;
import views.orderBrowser.elements.UpButton;

/**
 * @author vic
 */
//10
public def HEIGHT=672;
public def WIDTH=146;

public class SubCatView extends CustomNode {

    def VSPACING_COMPS_BACKGROUND=12;

    def query=new SubcategoryQue();
    def model=query.searchAll();

    def background:Rectangle=Rectangle {
	width:WIDTH , height: HEIGHT
	fill: LinearGradient{
            startX:0 startY:0
            endX:1 endY:1
            stops:[
                    Stop{
                       color:Color.LIGHTGRAY
                       offset:0
                    }
                    Stop{
                        offset:1
                        color:Color.BLACK
                    }
            ]
        }
        arcWidth:10
        arcHeight:10
        onMouseClicked:function(event){
            background.requestFocus();
        }
    }

    //item section

    function formatText(s:String):String{
        if(s.length()>15){
            def r="{s.substring(0,13)}..";
            return r;
        }
        else{
            return s;
        }
    }

    def list=Group{
        content:for(i in [0..< sizeof model]){
           Group{
                def sub=model[i]
                layoutY:i*22
                content:[
                        Rectangle{
                            arcWidth:5
                            arcHeight:5
                            height:17
                            width:92
                            effect:DropShadow{
                                color:Color.BLACK
                            }
                            fill:LinearGradient{
                                startX:0 startY:0
                                endX:1 endY:1
                                stops:[
                                        Stop{
                                            color:Color.GRAY
                                            offset:0
                                        }
                                        Stop{
                                            color:Color.BLACK
                                            offset:1
                                        }
                                ]
                            }
                            strokeWidth:1
                            stroke:Color.BLACK
                            cursor:Cursor.HAND
                            onMouseClicked:function(event){
                                MenuBrowserController.display(sub);
                            }
                        }
                        Text{
                            layoutY:2
                            layoutX:3
                            textOrigin:TextOrigin.TOP
                            content:formatText(sub.getSubName())
                            cursor:Cursor.HAND
                            fill:Color.WHITESMOKE
                            onMouseClicked:function(event){
                                MenuBrowserController.display(sub);
                            }
                            font:Font{
                                size:12
                            }
                        }
                ]
            }
        }
    }
        
    def view=ClipView {
        node:list
        width:100
        height:569
        pannable:false
        translateY:38
        clipX:0
        clipY:0
    }
    
    //button section
    def upB=UpButton{
        mouseClickedFunc:function(){
            list.translateY+=5;
        }        
    }
    def downB=DownButton{
        mouseClickedFunc:function(){
            list.translateY-=5;
        }  
    }
    def buttons=VBox{
        spacing:573
        layoutX:view.layoutX+ view.width+1
        content:[upB,downB]
    }

    def content=Group{
        layoutY: VSPACING_COMPS_BACKGROUND
        layoutX: 4
        content:[view,buttons]
    }

    public override function create(): Node {
        return Group {
                    content: [background,content]
                };
            }

}
