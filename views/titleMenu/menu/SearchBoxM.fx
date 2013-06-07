/*
 * SearchBoxM.fx
 *
 * Created on Feb 26, 2010, 9:48:52 PM
 */

package views.titleMenu.menu;

import javafx.scene.CustomNode;
import javafx.geometry.HPos;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.control.ListView;
import javafx.scene.control.TextBox;
import javafx.scene.input.KeyCode;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.Text;

/**
 * @author vic
 */
 
public function getHeight():Integer{
    //this is the sum of the textBox.height+ label.height
    return 39;
}

public class SearchBoxM extends CustomNode {

   public var columns=13;

   var toDisable:Boolean=true on replace oldValue{
          if(oldValue){
              this.parent.parent.parent.parent.parent.toFront();
              this.searchListView.toFront();
          }
    }

   var options:String[];

   public-init var label:String;

   public var getItems:function(:String):String[];
   public var actionF:function();
   public-read var value:String;
   public-read var inputText:String=bind searchTextBox.rawText;

   public function clearTextbox():Void{
       searchTextBox.text="";
   }


    init{
        toDisable=true;
        if (label==null) {label="Search";}
    }
    //width of the label=45
    def searchLabel=Text{
        content:bind label
        font:Font{ size:15 embolden:true}
    }

    //search component{
     def searchTextBox:TextBox=TextBox{
       columns:columns
       text:""
       onKeyTyped:function(event){
                if(toDisable) toDisable=false;
                delete options;
                searchListView.clearSelection();
                options=getItems(searchTextBox.rawText);
                searchListView.selectLastRow();
            
        }
        action:function(){
            actionF();
        }
    }
    function heightC(n:Integer):Integer{
        if(n<=8){
            return n*19+19
        }
        else{
            return 152;
        }

    }

    def searchListView:ListView=ListView{
        layoutY:searchTextBox.boundsInLocal.height+searchLabel.boundsInLocal.height+13
        layoutX:searchLabel.boundsInLocal.minX
        width:searchTextBox.boundsInLocal.width
        items:bind options
        height:bind heightC(sizeof options)
        visible:bind not toDisable
        disable:bind toDisable
      onMouseClicked:function(event){
          if(event.clickCount==2){
              if (searchListView.selectedIndex!=-1){
                    if (sizeof options>0){
                        searchTextBox.text=options[searchListView.selectedIndex];
                        value=options[searchListView.selectedIndex];
                         toDisable=true;
                        delete options;
                        searchListView.clearSelection();
                    }
                }
          }

      }
      onKeyPressed:function(event){
            if(event.code==KeyCode.VK_ENTER){
                if (searchListView.selectedIndex!=-1){
                    toDisable=true;
                    if (sizeof options>0){
                        searchTextBox.text=options[searchListView.selectedIndex];
                        value=options[searchListView.selectedIndex];
                         delete options;
                        searchListView.clearSelection();
                    }
                }
            }
        }
    }

    def focusSB=bind searchTextBox.focused on replace oldValue{
        if(oldValue){
            toDisable=true;
        }
    }

    def focusLV=bind searchListView.focused on replace oldValue{
            if(not oldValue) toDisable=false;
        }

    def searchComp=VBox {
                    nodeHPos: HPos.LEFT
                    spacing:2
                    content:[searchLabel,searchTextBox]
                };
    //}

    public override function create(): Node {
        return Group {
                    content:[searchComp,searchListView]
                };
    }
}

