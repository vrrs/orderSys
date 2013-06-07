/*
 * BackB.fx
 *
 * Created on Feb 5, 2010, 12:39:17 PM
 */

package views.menuBrowser;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.shape.Circle;
import javafx.scene.paint.Color;
import javafx.scene.transform.Transform;
import controllers.viewControllers.MenuBrowserController;
import javafx.scene.Cursor;

public class BackB extends CustomNode {

    //properties
    def width=15;
    def height=width;

    def c= Circle {
	centerX:width/2, centerY: height/2
	radius: width
	fill: Color.BLACK
    }

    def arrow:Arrow=Arrow{
        layoutY:2
        def x=arrow.x
        def y=arrow.y
        transforms:Transform.scale(.125,.125,x,y) color:Color.RED
    }
	public override function create(): Node {
		return Group {
                        cursor:Cursor.HAND
                        onMouseClicked:function(event){
                            MenuBrowserController.goBack();
                        }
			content: [c,arrow]
		};;
	}
}


