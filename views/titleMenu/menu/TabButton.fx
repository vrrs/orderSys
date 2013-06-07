/*
 * TabButton.fx
 *
 * Created on Feb 25, 2010, 9:26:52 PM
 */

package views.titleMenu.menu;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.Cursor;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.text.TextOrigin;

/**
 * @author vic
 */

public def WIDTH=50;
public def HEIGHT=40;

public class TabButton extends CustomNode {

    def SPACING_BASES=2;
    public-init var act:function();
    public-init var act1:function();
    public-init var labelVal:String;
    public-init var pos:Integer;

    public function toClick():Void{
        act();
        clicked();
    }
    public function toUnClicked():Void{
        clicked();
    }
    public function isClicked():Boolean{
        return index==1;
    }


    function clicked(){
        if(index==0){
            index=1;
        }
        else{
            index=0;
        }
    }

    var index:Integer;
    def fills=[LinearGradient{
           startX:0 startY:0
           endX:0 endY:1
           proportional:true
           stops:[Stop{
                    color:Color.LIGHTGRAY
                    offset:0
                  }
                  Stop{
                    color:Color.BLACK
                    offset:1
                  }
                 ]
        },Color.RED];

    def base1:Rectangle=Rectangle{
        width:WIDTH
        height:HEIGHT
        fill:Color.WHITESMOKE
        stroke:Color.BLACK
        cursor:Cursor.HAND
        onMouseClicked:function(event){
            base1.requestFocus();
            act();
            act1();
            clicked();
        }
    }
    def base2=Rectangle{
        layoutX:SPACING_BASES
        layoutY:SPACING_BASES
        width:WIDTH-SPACING_BASES
        height:HEIGHT-SPACING_BASES
        fill:bind fills[index]
    }
    
    def label=Text{
        content:labelVal
        font:Font{
            size:15
            embolden:true
        }
        textOrigin:TextOrigin.TOP
        layoutX:pos
        layoutY:15
    }

    public override function create(): Node {
        return Group {
                    content: [base1,base2,label]
                };
            }

}

