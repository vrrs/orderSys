/*
 * Menu.fx
 *
 * Created on Feb 16, 2010, 8:46:39 AM
 */

package views.titleMenu.elements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import javafx.scene.control.ListView;
import javafx.scene.text.Font;

/**
 * @author vic
 */

/*  this class only enforce good focus behavior with one submenu. After that, it close the n menu, when
  n+1 menu is clicked.
*/

public class Menu extends CustomNode {

    def DISTANCE_LABEL_TEXTBASE=2;
    def DISTANCE_TEXTBASE_LIST=2;
    def HEIGHT_CELL=22;

    public-init var label:String;
    public-init var colorIndex=0;
    public-init var widthLabel:Integer;
    public-init var type:Integer;       //type==0 means a menu,type==1 means a submenu,type==2 means menuitem

    public var act:function():Void;
    public-read var WIDTHL=0;  //this is the width of the textbase

    var index:Integer=0;
    var fillIndex:Integer=0;
    var toDisable:Boolean=true;

    public function open(){
        toDisable=false;
    }
    public function close(){
        toDisable=true;
    }
    public function isOpen():Boolean{
        return not toDisable;
    }



    init{
        if (label==null){label="Menu";}
        if(widthLabel==0){widthLabel=26;}
        if(act==null) {act=function(){};}
        WIDTHL=widthLabel+2*DISTANCE_LABEL_TEXTBASE;
    }


    def opacityS=[0,.5,1];
    def fillS=[null,Color.RED];
    def textbase:Rectangle=Rectangle{
        height:MenuBar.BASE1_HEIGHT
        width:widthLabel+2*DISTANCE_LABEL_TEXTBASE
        opacity:bind opacityS[index]
        stroke:Color.WHITE
        fill:bind fillS[fillIndex]
        disable:if(type==0){false;} else {true;}
        visible:if(type==0){true;} else {false;}
        onMouseEntered:function(event){
            if(type==0){
                index=1;
            }
            else{
                index=2;
                fillIndex=1;
            }
        }
        onMouseExited:function(event){
            if(event.clickCount==0){
                index=0;
                if(type>0){
                    fillIndex=0;
                    if(type==1) {close();}
                }
            }
        }
        onMouseClicked:function(event){
            if(type<2){
                open();
                list.requestFocus();
            }
            else{
                 act();
                 index=0;
                 fillIndex=0;
                 close();
            }
        }
    }
    var labelColor=[Color.WHITE,Color.BLACK];
    def labelT=Text{
        content:label
        layoutY:DISTANCE_LABEL_TEXTBASE
        layoutX:DISTANCE_LABEL_TEXTBASE
        textOrigin:TextOrigin.TOP
        disable:if(type==0){false;} else {true;}
        visible:if(type==0){true;} else {false;}
        fill:bind labelColor[colorIndex]
        font:Font{
            size:19
        }

    }

    def list:ListView=ListView{
        layoutX:if(type==0) {0;} else {textbase.width;}
        layoutY:if(type==0) {textbase.height+DISTANCE_TEXTBASE_LIST;} else {0;}
        disable:bind toDisable
        visible:bind not toDisable
        height:bind (sizeof items)*HEIGHT_CELL
        onMouseClicked:function(event){
            for(i in [0..sizeof items]){
                if(items[i].isOpen()){
                    items[i].close();
                    break;
                }
            }
            if(items[list.selectedIndex].type==2){
               items[list.selectedIndex].act() ;
               close();
            }
            else{
                items[list.selectedIndex].open();
                }
        }
    }

    def focusUpdater= bind not list.focused on replace{
        if(focusUpdater){
            index=0;
            fillIndex=0;
            close();
        }
    }

    var items:Menu[];

    def listOfLists=Group{
        content:bind items
        layoutX:list.layoutX+list.width
        layoutY:list.layoutY
    }


    public function add(m:Menu){
        insert m.label into list.items;
        def n=sizeof items;
        insert m into items;
        m.translateY=n*HEIGHT_CELL;
        m.translateX=-m.textbase.width;       
    }

   public override function create(): Node {
         return Group {
                       content: [textbase,labelT,list,listOfLists]
                        };
            }

}