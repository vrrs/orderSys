/*
 * Statistics.fx
 *
 * Created on Mar 7, 2010, 12:57:09 PM
 */

package views.titleMenu.tools;
import views.titleMenu.elements.FXDialog;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.Group;
import views.titleMenu.tools.statisticDialogElements.DialogContent;

/**
 * @author vic
 */

public class Statistics extends FXDialog{

    override var windowWidth=984;
    override var windowHeight=704;

    def background=Rectangle{
        width:windowWidth-6
        height:windowHeight-35
        fill:Color.WHITE
    }

    def g=Group{
        content:[background,DialogContent{translateY:4 translateX:4 }]
    }


    override protected function createScene () : Boolean {
        title="Statistics";
        sceneContent.content=g;
        window=windowModel;
        window.toFront();
        true;
    }

    def run=createScene();
}
