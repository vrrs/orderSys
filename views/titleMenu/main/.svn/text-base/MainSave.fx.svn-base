/*
 * MainSave.fx
 *
 * Created on Feb 23, 2010, 7:40:03 PM
 */

package views.titleMenu.main;

import views.titleMenu.elements.FXDialog;
import javafx.scene.control.TextBox;
import controllers.viewControllers.MenuBarController;
import javafx.scene.control.Button;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.geometry.HPos;

/**
 * @author vic
 */

public class MainSave extends FXDialog{

    override var windowWidth=160;
    override var windowHeight=124;

    def BUTTON_WIDTH=15;
    def HSPACING_COMPS=15;

    def textbox:TextBox=TextBox{
        action:function(){
            MenuBarController.saveMain(textbox.text);
            textbox.text="";
        }
    }

    def save=Button{
       text:"Save"
       action:function(){
           textbox.commit();
           MenuBarController.saveMain(textbox.text);
           close();
           textbox.text="";
       }
    }
    def cancel=Button{
        text:"Cancel"
        action:function(){
            textbox.text="";
            close();
        }
    }
    def buttons=HBox{
        spacing:BUTTON_WIDTH
        content:[save,cancel]

    }

    def content=VBox{
        nodeHPos: HPos.CENTER
        spacing:HSPACING_COMPS
        content:[textbox,buttons]
    }

    override protected function createScene () : Boolean {
        sceneContent.content=content;
        title="Save";
        content.translateX=16;
        content.translateY=10;
        textbox.requestFocus();
        window=windowModel;
        window.toFront();
        true;
    }

    def run=createScene();
}