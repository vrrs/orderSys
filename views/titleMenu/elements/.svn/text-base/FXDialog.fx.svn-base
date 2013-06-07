/*
 * FXDialog.fx
 *
 * Created on Feb 22, 2010, 6:08:24 PM
 */
package views.titleMenu.elements;

import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.stage.StageStyle;
import javafx.scene.Group;
import javafx.scene.text.Font;
import javafx.scene.text.TextOrigin;
import javafx.util.Math;

/**
 * @author vic
 */

   

public abstract class FXDialog {

    var stageDragInitialX: Number;
    var stageDragInitialY: Number;
    protected def BAR_HEIGHT = 27;
    protected var windowWidth: Number = 500;
    protected var windowHeight: Number = 500;
    protected var dragBarHeight: Integer = 50;
    protected var SPACING_BACKGROUND_COMPS = 2;
    protected var title:String;

    protected var window:StageDialog;
    protected abstract function createScene():Boolean;
    
    def menuB = MenuBar {
                WIDTH: bind Math.round(windowWidth)
            }
    //closeButton{
    protected def closeBackground: Rectangle = Rectangle {
                layoutX: bind windowWidth - 25
                onMouseClicked: function (event): Void {
                    close();
                }
                fill: Color.BLACK
                width: 25.0
                height: 25.0
                arcWidth: 15.0
                arcHeight: 15.0
            }
    protected def closeT = javafx.scene.text.Text {
                layoutX: bind windowWidth - 15
                layoutY: 4
                blocksMouse: false
                textOrigin: TextOrigin.TOP
                font: Font { size: 14 embolden: true }
                content: "X"
                fill: Color.WHITESMOKE
            }
    protected def bar = Group {
                content: [menuB, closeBackground, closeT]
            }
  //  protected var window:StageDialog;

    protected var sceneContent:Group;

    // Drag Bar
    var dragBar: Rectangle = Rectangle {
                width: bind window.width
                height: dragBarHeight
                fill: Color.TRANSPARENT
                visible: bind ("{__PROFILE__}" != "browser")
                onMousePressed: function (e) {
                    stageDragInitialX = e.screenX - window.x;
                    stageDragInitialY = e.screenY - window.y;
                }
                onMouseDragged: function (e) {
                    window.x = e.screenX - stageDragInitialX;
                    window.y = e.screenY - stageDragInitialY;
                }
            }
 protected var windowModel: StageDialog = StageDialog {
                title: bind title
                scene: Scene {
                    width: windowWidth
                    height: windowHeight
                    fill: Color.LIGHTGRAY
                    content:[dragBar, bar, sceneContent=Group {
                            layoutY: menuB.HEIGHT + SPACING_BACKGROUND_COMPS
                            layoutX: SPACING_BACKGROUND_COMPS
                        }
                    ]
                }
                style: StageStyle.UNDECORATED
                visible: false
                resizable: false
            }

    public function getWindow(): StageDialog {
        return window;
    }

    public function close(): Void {
        window.close();    ;

               }

public function open():Void{
        window.visible=true;
    }

}
