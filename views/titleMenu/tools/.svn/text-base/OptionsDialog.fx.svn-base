/*
 * OptionsDialog.fx
 *
 * Created on Mar 2, 2010, 1:05:09 PM
 */

package views.titleMenu.tools;

import views.titleMenu.elements.FXDialog;
import javafx.geometry.HPos;
import javafx.scene.control.Button;
import javafx.scene.control.TextBox;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.stage.Alert;
import controllers.dataControllers.SettingsController;

/**
 * @author vic
 */

public class OptionsDialog extends FXDialog{

    override var windowWidth=160;
    override var windowHeight=154;

    def BUTTON_WIDTH=15;
    def HSPACING_COMPS=15;

    def label=Text{
        content:"Sales Tax Rate"
        font:Font{
            size:15
        }

    }

    function setNewTaxRate():Void{
        var flag=true;var taxrate:Double;
        try{
            taxrate=Double.parseDouble(textbox.text);
        }
        catch(NumberFormatException){
            flag=false;
            Alert.inform("Input Error", "The sales tax rate must be a number. Please,try again.");
        }
        if(flag){
            def model=new SettingsController(0);
            model.getSetting().setTaxrate(taxrate);
            model.save();
        }
    }


    def textbox:TextBox=TextBox{
        def model=new SettingsController(0);
        text:"{model.getSetting().getTaxrate()}"
        action:function(){
            setNewTaxRate();
            textbox.text="";
            close();
        }
    }

    def save=Button{
       text:"Save"
       action:function(){
           textbox.commit();
           setNewTaxRate();
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
        content:[label,textbox,buttons]
    }

    override protected function createScene () : Boolean {
        sceneContent.content=content;
        title="Options";
        content.translateX=16;
        content.translateY=10;
        textbox.requestFocus();
        window=windowModel;
        window.toFront();
        true;
    }

    def run=createScene();
}

