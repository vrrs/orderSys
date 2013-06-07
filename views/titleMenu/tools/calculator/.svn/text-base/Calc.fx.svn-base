/*
 * Calc.fx
 *
 * Created on Feb 20, 2010, 9:47:38 PM
 */

package views.titleMenu.tools.calculator;

/**
 * @author vic
 */


import javafx.stage.StageStyle;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import views.titleMenu.tools.calculator.views.FXCalculator;
import views.titleMenu.elements.StageDialog;
var stageDragInitialX:Number;
var stageDragInitialY:Number;

var w:Number = 221;
var h:Number = 249;
var bgColor = Color.TRANSPARENT;

var fxCalculator = FXCalculator { };

/*
// Fit screen for mobile
if("{__PROFILE__}" == "mobile") {
    w = javafx.stage.Screen.primary.bounds.width;
    h = javafx.stage.Screen.primary.bounds.height;
    def scaleW = w/221;
    def scaleH = h/249;
    bgColor = Color.BLACK;

    fxCalculator.transforms = Transform.scale(scaleW, scaleH);
}*/


// Drag Bar
var dragBar : Rectangle = Rectangle {
    width: bind fxCalculator.width
    height: 50
    fill: Color.TRANSPARENT
    visible: bind ("{__PROFILE__}" != "browser")
    onMousePressed: function(e) {
        stageDragInitialX = e.screenX - calculator.x;
        stageDragInitialY = e.screenY - calculator.y;
    }
     onMouseDragged: function(e) {
        calculator.x = e.screenX - stageDragInitialX;
        calculator.y = e.screenY - stageDragInitialY;
     }
}

var calculator:StageDialog = StageDialog {

    title: "Calculator"

    scene: Scene {
        content: [ dragBar, fxCalculator ]
        fill: bgColor
        width: w
        height: h
    }
    style: StageStyle.DECORATED
    visible:false
    resizable:false
}

public class Calc {
    public function getCalc(){
        return calculator;
    }
}




