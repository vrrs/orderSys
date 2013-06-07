/*
 * MenuBrowserBar.fx
 *
 * Created on Feb 7, 2010, 7:38:02 PM
 */

package views.menuBrowser;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.layout.HBox;
import javafx.geometry.VPos;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.paint.Color;

/**
 * @author vic
 */

 public def HEIGHT=40;
 public def WIDTH=918;

public class MenuBrowserBar extends CustomNode {

    def back=BackB{}
    def forward=ForwardB{}
    def buttons=HBox{
        translateX:2
        spacing:15
        nodeVPos: VPos.CENTER
        content:[back,forward]
    }

    def categoryBar=CatBar{}

    def searchBox=SearchBox{}

    def content1=HBox{
        spacing:24
         nodeVPos: VPos.CENTER
        content:[buttons,categoryBar]
    }
    def contentTotal=HBox{
        spacing:24
        nodeVPos: VPos.TOP
        translateY:5
        translateX:3
        content:[content1, searchBox]
    }

    def background=Rectangle{
        height:HEIGHT
        width:WIDTH
        arcWidth:10
        arcHeight:10
        fill:LinearGradient{
            startX:0 startY:0
            endX:1 endY:1
            proportional:true
            stops:[ Stop{
                       offset:0
                       color:Color.LIGHTGRAY
                    }
                    Stop{
                       offset:0.85
                       color:Color.BLACK
                    }
                    Stop{
                       offset:1
                       color:Color.RED
                    }
                    ]
        }

    }

 
    public override function create(): Node {
		return Group {
			content: [background,contentTotal]
		};
	}
}
