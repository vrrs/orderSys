/*
 * Key.fx
 *
 * Created on Feb 20, 2010, 9:50:50 PM
 */

package views.titleMenu.tools.calculator.views;

/**
 * @author vic
 */


import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.CustomNode;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.paint.Paint;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.input.MouseEvent;

public def width = 50.0;
public def height = 37.0;

public class Key extends CustomNode {

    public var code = 0;
    public var selected = false;

    override var translateX = bind x;
    override var translateY = bind y;

    public var cellFill = LinearGradient {
        startX: 0.0, startY: 3.0, endX: 0.0, endY: 28.0
        proportional: false
        stops: [
            Stop { offset: 0.0 color: Color.GRAY },
            Stop { offset: 0.5 color: Color.BLACK }
        ]
    }

    public var cellSelFill = LinearGradient {
        startX: 0.0, startY: 0.0, endX: 0.0, endY: 28.0
        proportional: false
        stops: [
            Stop { offset: 0.0 color: Color.BLACK },
            Stop { offset: 0.3 color: Color.GRAY },
            Stop { offset: 0.99 color: Color.BLACK }
        ]
    }

    var bgRect = Rectangle {
        x: 0 y: 0
        width: width
        height: height
        fill: cellFill
        stroke: bind getStrokeColor(selected)
    };

    function getStrokeColor(selected : Boolean) : Paint {
        if(selected) {
            return Color.WHITE;
        } else {
            return Color.TRANSPARENT;
        }
    }

    var text : Text = Text {
        font: Font { name: "Bitstream Vera Sans Bold" size: 12 }
        translateX: 21
        translateY: 17
        content: bind content
        fill: Color.WHITE
        y: 5
    };

    public var x = 0.0;
    public var y = 0.0;
    public var content = "0";

    override function create() : Node {
        return Group {
            content: [ bgRect, text ]
        }
    }

    override var onMouseEntered = function(e:MouseEvent) {
        bgRect.fill = cellSelFill;
    }

    override var onMouseExited = function(e:MouseEvent) {
        bgRect.fill = cellFill;
    }

    public function setCellFill(selected : Boolean) {
        if(selected) {
            bgRect.fill = cellSelFill;
        } else {
            bgRect.fill = cellFill;
        }
    }
}

