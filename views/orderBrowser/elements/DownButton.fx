/*
 * DownButton.fx
 *
 * Created on Feb 17, 2010, 3:47:22 PM
 */

package views.orderBrowser.elements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.Cursor;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Circle;
import javafx.scene.transform.Transform;
import views.menuBrowser.Arrow;

/**
 * @author vic
 */

public class DownButton extends CustomNode {
    
    def WIDTH_BASE2=34;
    def DISTANCE_BETWEEN_BASES=1;

    public-read def HEIGHT=2*(WIDTH_BASE2/2+DISTANCE_BETWEEN_BASES);
    public-read def WIDTH=HEIGHT;

    public-init var mousePressedFunc:function();
    public-init var mouseClickedFunc:function();
    public-init var mouseReleasedFunc:function();

    def base1=Circle {
	centerX: WIDTH_BASE2/2, centerY: WIDTH_BASE2/2
	radius: WIDTH_BASE2/2+DISTANCE_BETWEEN_BASES
	fill: Color.WHITE
        stroke:Color.BLACK
        cursor:Cursor.HAND
        onMousePressed:function(event){
           if(mousePressedFunc!=null){
               mousePressedFunc();
           }
        }
        onMouseReleased:function(event){
            if(mouseReleasedFunc!=null){
               mouseReleasedFunc();
           }
        }
        onMouseClicked:function(event){
            if(mouseClickedFunc!=null){
                mouseClickedFunc();
            }
        }
}

    def base2=Circle {
	centerX: WIDTH_BASE2/2, centerY: WIDTH_BASE2/2
	radius: WIDTH_BASE2/2
	fill: LinearGradient{
            startX:0 startY:0
            endX:1 endY:0
            proportional:true
            stops:[Stop{
                        offset:0
                        color:Color.GRAY
                   }
                   Stop{
                        offset:0.4
                        color:Color.BLACK
                   }
                   Stop{
                        offset:0.6
                       color:Color.BLACK
                   }
                   Stop{
                        offset:1.0
                       color:Color.GRAY
                   }
                  ]
        }

}


    def arrow:Arrow=Arrow{
        layoutX:WIDTH_BASE2/2-5
        layoutY:24
        def x=arrow.x
        def y=arrow.y
        color:Color.RED
        transforms:[Transform.scale(.125,.125,x,y),Transform.rotate(-90, x, y)]
    }

    public override function create(): Node {
        return Group {
                    content: [base1,base2,arrow]
                };
    }
}
