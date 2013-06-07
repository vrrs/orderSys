/*
 * ModeB.fx
 *
 * Created on Feb 11, 2010, 4:14:44 AM
 */

package views.orderView.elements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.shape.Circle;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;
import javafx.scene.shape.Arc;
import javafx.scene.shape.ArcType;
import javafx.scene.effect.DropShadow;
import controllers.viewControllers.OrderViewController;

/**
 * @author vic
 */

 public def WIDTH=50;
 public def HEIGHT=50;

public class ModeB extends CustomNode {
    
    def COLORS=[Color.GRAY,Color.RED];
    def GAP_IN_CIRCLES=3;
    def GAP_TOPB_SYMBOL=10;
    def ANGLE=60;
    def EFFECT=[DropShadow{color:Color.BLACK},DropShadow{color:Color.RED}];

    //0 means OFF
    public var index=0 on replace oldValue{
        if(oldValue==0){
            OrderViewController.mode=true;
        }
        else{
            OrderViewController.mode=false;
        }

    }

    init{
        OrderViewController.mode=false;
    }

    def background=Circle{
        centerX:WIDTH/2
        centerY:HEIGHT/2
        radius:WIDTH/2
        fill:Color.BLACK
        strokeWidth:1
        stroke:Color.BLACK
        effect:bind EFFECT[index]
        onMouseClicked:function(event){
            if(index==0){
                index=1;
            }
            else{
                index=0;
            }
        }

    }

    def topB=Circle{
        centerX:WIDTH/2
        centerY:HEIGHT/2
        radius:WIDTH/2 - GAP_IN_CIRCLES
        stroke:bind COLORS[if(index==0){ 0;} else 1]
        fill:bind COLORS[index]
        effect:bind EFFECT[index]
    }

    def verticalLine=Line{
        startX:WIDTH/2 startY:GAP_IN_CIRCLES+GAP_TOPB_SYMBOL-5
        endX:WIDTH/2 endY:HEIGHT/2
        stroke:bind COLORS[if(index==0){ 1;} else 0]
    }
    def arc=Arc{
        centerX:WIDTH/2
        centerY:HEIGHT/2
        radiusX: WIDTH/2 - GAP_IN_CIRCLES-GAP_TOPB_SYMBOL  radiusY: WIDTH/2 - GAP_IN_CIRCLES-GAP_TOPB_SYMBOL
        startAngle: ANGLE  length: -(360-ANGLE)
        type: ArcType.OPEN
        stroke:bind COLORS[if(index==0){ 1;} else 0]
        fill:null
    }

    public override function create(): Node {
        return Group {
                    content: [background,topB,arc,verticalLine]
                };
    }
}
