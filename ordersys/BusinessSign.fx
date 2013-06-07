/*
 * BusinessSign.fx
 *
 * Created on Mar 14, 2010, 7:27:39 PM
 */
package ordersys;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.paint.Color;
import javafx.scene.text.TextOrigin;

/**
 * @author vic
 */
public class BusinessSign extends CustomNode {

    def base = Rectangle {
                width: 642
                height: 38
                fill: LinearGradient{
                    startX:0 startY:0
                    endX:1 endY:1
                    proportional:true
                    stops:[
                        Stop{
                            offset:0
                            color:Color.BLACK
                        }
                        Stop{
                            offset:1
                            color:Color.RED
                        }
                    ]
                }
                arcWidth:15
                arcHeight:15
            }

    def text = Text {
                content: "A. Hamilton Cafe. Tel:973-653-3866"
                font: Font {
                        size:19
                    }
                translateY:9
                translateX:12
                fill:Color.WHITESMOKE
                textOrigin:TextOrigin.TOP
                }

    public override function create(): Node {
        return Group {
                    content: [base,text]
                };
    }

}
