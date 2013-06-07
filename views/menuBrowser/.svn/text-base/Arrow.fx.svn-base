/*
 * Arrow.fx
 *
 * Created on Feb 5, 2010, 1:25:08 PM
 */

package views.menuBrowser;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.transform.Transform;
import javafx.util.Math;

/**
 * @author vic
 */

public class Arrow extends CustomNode {
    //arrow.wide is aprox (.5^2)h+w
    public-read def x=5;
    public-read def y=5;

    public-init var w:Integer=100;
    public-init var h:Integer=50;
    public-init var color=Color.BLACK;

    def gap=3;
    def angle=45;
     //
    def base=Rectangle {
	x: x, y: y
	width: w, height: h
	fill: color
        translateY:11
        translateX:36.5
        arcWidth:15 arcHeight:15
}
    def sideUp1=Rectangle {
	x: x, y: y
	width: w, height: h
	fill: color
        transforms:[Transform.rotate(angle,x,y)]
}
     def sideUp2=Rectangle {
	x: x, y: y
	width: w+gap, height: h
	fill: color
        arcWidth:15 arcHeight:15
        transforms:[Transform.rotate(angle,x,y)]
}
    def sideDown1=Rectangle {
	x: x, y: y
	width: w, height: h
	fill: color
        transforms:[Transform.rotate(angle-90, x, y),Transform.translate((-w+gap+2)*Math.cos(angle-90),0)]
}
    def sideDown2=Rectangle {
	x: x, y: y
	width: w+gap, height: h
	fill: color
         arcWidth:15 arcHeight:15
        transforms:[Transform.rotate(angle-90, x, y),Transform.translate((-w+gap+2)*Math.cos(angle-90),0)]
}
    public override function create(): Node {
        return Group {
                    content: [sideUp1,sideUp2,sideDown1,sideDown2,base]
                };
    }
}
