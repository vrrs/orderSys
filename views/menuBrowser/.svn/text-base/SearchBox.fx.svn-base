/*
 * SearchBox.fx
 *
 * Created on Feb 8, 2010, 10:57:59 AM
 */

package views.menuBrowser;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.control.TextBox;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.control.ListView;
import models.menuT.MenuQue;
import models.menuT.MenuDB;
import controllers.viewControllers.MenuBrowserController;
import javafx.scene.input.KeyCode;
import javafx.scene.layout.HBox;
import javafx.geometry.VPos;

public class SearchBox extends CustomNode {

    public var toDisable:Boolean=true;
        
    var options:String[];

    function getItems(s:String):String[]{
        def query=new MenuQue();
        def data:MenuDB[]=query.searchByProduct(s);
        return for(i in [0..sizeof data-1] where sizeof data>0){
            data[i].getProduct();
        }
    }

    function setFirstUpperCase(s:String):String{
        if(s.length()>0){
            var r=s.substring(1,s.length());
            def firstChar=s.substring(0, 1).toUpperCase();
            return firstChar.concat(r);}
        else
            return s;
    }

    init{
        toDisable=true;
    }

    //width of the label=45
    def searchLabel=Text{
        content:"Search"
        font:Font{ size:15 embolden:true}
    }

    //search component{
    def searchTextBox:TextBox=TextBox{
       columns:15
       text:""
       onKeyTyped:function(event){
            if(toDisable) toDisable=false;
            options=getItems(setFirstUpperCase(searchTextBox.rawText));
        }
        action:function(){
            toDisable=true;
            if (sizeof options>0 and searchTextBox.text!=""){
                MenuBrowserController.submitSearch(setFirstUpperCase(searchTextBox.text),0);
            }
            searchTextBox.text="";
        }
    }

    def searchListView:ListView=ListView{
        layoutY:searchTextBox.height
        layoutX:searchLabel.boundsInLocal.width+5
        width:searchTextBox.boundsInLocal.width
        items:bind options
        visible:bind not toDisable
        disable:bind toDisable
      onMouseClicked:function(event){
          if(event.clickCount==2){
              if (searchListView.selectedIndex!=-1){
                    searchTextBox.text="";
                    toDisable=true;
                    if (sizeof options>0){
                        MenuBrowserController.submitSearch(options[searchListView.selectedIndex],1);
                    }
                }
          }

      }
      onKeyPressed:function(event){
            if(event.code==KeyCode.VK_ENTER){
                if (searchListView.selectedIndex!=-1){
                    searchTextBox.text="";
                    toDisable=true;
                    if (sizeof options>0){
                        MenuBrowserController.submitSearch(options[searchListView.selectedIndex],1);
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

    def searchComp=HBox {
                    nodeVPos: VPos.CENTER
                    spacing:5
                    content:[searchLabel,searchTextBox]
                };
    //}

    public override function create(): Node {
        return Group {
                    content:[searchComp,searchListView]
                };
    }
}
