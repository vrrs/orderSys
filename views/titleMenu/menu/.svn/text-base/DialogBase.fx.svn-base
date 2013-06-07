/*
 * DialogBase.fx
 *
 * Created on Feb 25, 2010, 9:19:41 PM
 */

package views.titleMenu.menu;

import views.titleMenu.elements.FXDialog;
import javafx.scene.layout.HBox;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.Group;

/**
 * @author vic
 */

public abstract class DialogBase extends FXDialog{

    protected var newAct:function();
    protected var editAct:function();
    protected var deleteAct:function();

    protected var SPACING_BUTTONS=10;

    protected def newB=TabButton{act:newAct labelVal:"New" pos:12 }
    def editB=TabButton{act:editAct labelVal:"Edit" pos:8 }
    def deleteB=TabButton{act:deleteAct labelVal:"Delete" pos:3 }

    protected def backgroundButtons=Rectangle{
        fill:Color.LIGHTBLUE
        height:54
    }

   protected function unClickedAll():Void{
        if(newB.isClicked()){
            newB.toUnClicked();
        }
        else{
            if(editB.isClicked()){
                editB.toUnClicked();
            }
            else{
               if(deleteB.isClicked()) deleteB.toUnClicked();
            }
        }
    }


    def buttonG=HBox{
        translateX:75
        spacing:SPACING_BUTTONS
        content:[newB,editB,deleteB]
    }
    protected def buttons=Group{
        content:[backgroundButtons,buttonG]
    }

}