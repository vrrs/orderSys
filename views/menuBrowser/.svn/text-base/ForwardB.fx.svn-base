/*
 * ForwardB.fx
 *
 * Created on Feb 7, 2010, 6:02:35 PM
 */

package views.menuBrowser;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.transform.Transform;
import controllers.viewControllers.MenuBrowserController;
import javafx.scene.Cursor;

public class ForwardB extends CustomNode{
     //properties
    def width=15;
    def height=width;

    def c= Circle {
	centerX:width/2, centerY: height/2
	radius: width
	fill: Color.BLACK
    }

    def arrow:Arrow=Arrow{
        layoutY:11
        layoutX:14
        def x=arrow.x
        def y=arrow.y
        transforms:[Transform.scale(.125,.125,x,y),Transform.rotate(180, x, y)]
        color:Color.RED
    }
	public override function create(): Node {
		return Group {
                        cursor:Cursor.HAND
                        onMouseClicked:function(event){
                            MenuBrowserController.goForward();
                        }
			content: [c,arrow]
		};;
	}
}
