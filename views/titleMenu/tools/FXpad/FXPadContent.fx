/*
 * FXPadContent.fx
 *
 * Created on Feb 22, 2010, 1:07:57 PM
 */

package views.titleMenu.tools.FXpad;

import javafx.scene.CustomNode;
import views.titleMenu.elements.Menu;
import views.titleMenu.elements.MenuBar;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.TextOrigin;
import controllers.viewControllers.MenuBarController;
import views.titleMenu.elements.MultilineTextBox;

/**
 * @author vic
 */

public class FXPadContent extends CustomNode {

//menuSec{
def menuB=MenuBar{
    WIDTH:684
}
def menu=Menu{
    label:"File"
    widthLabel:38
}
def newFile=Menu{
    type:2
    label:"New"
    widthLabel:27
    act:function(){
        MenuBarController.FXPadNew();
    }

}
def open=Menu{
    type:2
    label:"Open"
    widthLabel:28
    act:function(){
        MenuBarController.FXPadOpen();
    }

}
def save=Menu{
    label:"Save"
    widthLabel:28
    type:2
    act:function(){
       MenuBarController.FXPadSave(textbox.swingTextbox.getText(),0);
    }

}
def exit=Menu{
    label:"Exit"
    widthLabel:28
    type:2
    act:function(){
        FXPad.close();
    }

}

function setMenu():Boolean{
    menu.add(newFile);
    menu.add(open);
    menu.add(save);
    menu.add(exit);
    menuB.addMenu(menu);
    true;
}
def setup=setMenu();
//}

//closeButton{
def closeBackground=Rectangle{
    layoutX: 684-25
    onMouseClicked: function(event):Void{
        FXPad.close();
    }
    fill: Color.BLACK
    width: 25.0
    height: 25.0
    arcWidth: 15.0
    arcHeight: 15.0
}
def closeT = javafx.scene.text.Text {
            layoutX: 684-15
            layoutY: 4
            blocksMouse: false
            textOrigin:TextOrigin.TOP
            font: Font{size:14 embolden:true}
            content: "X"
            fill:Color.WHITESMOKE
        }
def closeB=Group{
    content:[closeBackground,closeT]
}
//}
def base=Rectangle{
    width:682
    height:597-35
    fill:Color.WHITESMOKE
    
}

def textbox=MultilineTextBox{};
def g=Group{
    content:[base,textbox]
    layoutY:menuB.HEIGHT+2
}

public function getData():String{
    textbox.swingTextbox.getText();
}
public function setData(s:String):Void{
      textbox.swingTextbox.setText(s);
}


  public override function create(): Node {
        return Group {
                    content: [g,menuB,closeB]
                };
            }

}
