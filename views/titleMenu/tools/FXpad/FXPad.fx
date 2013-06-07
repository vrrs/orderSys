/*
 * FXPad.fx
 *
 * Created on Feb 22, 2010, 1:07:16 PM
 */

package views.titleMenu.tools.FXpad;

import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import views.titleMenu.elements.StageDialog;
import javafx.stage.StageStyle;

/**
 * @author vic
 */
 var stageDragInitialX:Number;
 var stageDragInitialY:Number;
 // Drag Bar
var dragBar : Rectangle = Rectangle {
    width: bind notepad.width
    height: 50
    fill: Color.TRANSPARENT
    visible: bind ("{__PROFILE__}" != "browser")
    onMousePressed: function(e) {
        stageDragInitialX = e.screenX - notepad.x;
        stageDragInitialY = e.screenY - notepad.y;
    }
     onMouseDragged: function(e) {
        notepad.x = e.screenX - stageDragInitialX;
        notepad.y = e.screenY - stageDragInitialY;
     }
}

public var pad=FXPadContent{};

var notepad:StageDialog=StageDialog {
    title: "BusinessPad"
    scene: Scene {
        width: 684.0
        height: 596.0
        fill:Color.LIGHTGRAY
        content:[dragBar,pad]
    }
    style:StageStyle.UNDECORATED
    visible:false
    resizable:false
}

public function getPad():StageDialog{
    return notepad;
}

public function close(){
    notepad.close();
}

public class FXPad{}