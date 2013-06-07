/*
 * MainOpen.fx
 *
 * Created on Feb 23, 2010, 6:56:34 PM
 */

package views.titleMenu.main;

import views.titleMenu.elements.FXDialog;
import javafx.scene.control.ListView;
import javafx.scene.control.TextBox;
import javafx.scene.control.Button;
import controllers.viewControllers.MenuBarController;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.geometry.HPos;
import controllers.dataControllers.OrderDataController;

/**
 * @author vic
 */

public class MainOpen extends FXDialog{

  override var windowWidth=130+SPACING_BACKGROUND_COMPS;
  override var windowHeight=505+SPACING_BACKGROUND_COMPS+BAR_HEIGHT;

   def LISTVIEW_HEIGHT=100;
   def BUTTON_HSPACING=10;
   def VSPACING_CONTENT=15;

   def model=new OrderDataController();
   var data:String[];

   function getData(s:String):String[]{
       var result:String[];var k=0;
       for(i in [0..<model.getModel().getOrders().size()]){
           def value=model.getModel().getOrderNames().get(i);
           if(value.startsWith(s)){
               result[k++]=value;
           }
       }
       return result;
   }

   def textbox:TextBox=TextBox{
        onKeyPressed:function(event){
            data=getData(textbox.rawText);
        }
        action:function(){
            if(list.selectedIndex==-1){
                MenuBarController.openMain(list.items[0] as String);
            }
            else{
                MenuBarController.openMain(list.items[list.selectedIndex]as String);
            }
            textbox.text="";
            close();
        }
   }

   def list=ListView{
       items:bind data
       width:textbox.width
       height:LISTVIEW_HEIGHT
   }

   def openButton=Button{
       text:"Open"
       action:function(){
           textbox.commit();
           textbox.action();
       }
   }
   def closeButton=Button{
       text:"Close"
       action:function(){
           textbox.text="";
           close();
       }
   }
   def buttons=HBox{
       spacing:BUTTON_HSPACING
       content:[openButton,closeButton]
   }

   def content=VBox{
       nodeHPos: HPos.CENTER
       spacing:VSPACING_CONTENT
       content:[list,textbox,buttons]
   }

   override function createScene():Boolean{
        content.translateX=6;
        content.translateY=4;
        title="Open";
        sceneContent.content=content;
        textbox.requestFocus();
        window=windowModel;
        window.toFront();
        content.requestFocus();
        true;
   }

   def run=createScene();
}