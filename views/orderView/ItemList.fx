/*
 * ItemList.fx
 *
 * Created on Feb 11, 2010, 2:39:21 AM
 */

package views.orderView;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import views.orderView.elements.OrderItem;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.control.ScrollBar;
import controllers.dataControllers.Item;
import controllers.viewControllers.OrderViewController;
import javafx.scene.layout.ClipView;
import javafx.scene.layout.VBox;


/**
 * @author vic
 */
public var WIDTH;
public var HEIGHT;

public class ItemList extends CustomNode {

    def SPACING_BETWEEN_ITEM_SCROLLBAR=5;
    def SCROLLBAR_WIDTH=5;
    def SPACING_BETWEEN_SCROLLBAR_BACKGROUND=2;
    def BACKGROUND_WIDTH=OrderItem.WIDTH+SPACING_BETWEEN_ITEM_SCROLLBAR+SPACING_BETWEEN_SCROLLBAR_BACKGROUND+SCROLLBAR_WIDTH;
    def NUMBER_OF_VIEWEDITEMS=4;
    def VSPACING=3;
    def BACKGROUND_HEIGHT=(OrderItem.HEIGHT+VSPACING-1)*NUMBER_OF_VIEWEDITEMS+ 30;
    def SCROLLBAR_INITIAL_VALUE=(OrderItem.HEIGHT+VSPACING);
    init{
        WIDTH=BACKGROUND_WIDTH;
        HEIGHT=BACKGROUND_HEIGHT;
    }

    def background=Rectangle{
        width:BACKGROUND_WIDTH
        height:BACKGROUND_HEIGHT
        fill:Color.WHITESMOKE
    }
    
    var extraSpace:Integer;

    function getItems(it:Item[]):OrderItem[]{
        var r:OrderItem[];var k=0;
        for(j in [0..<sizeof it]){
           if(it[j]!=null){
                r[k++]=OrderItem{
                    item:it[j]}
            }
        }
        return r;
    }

    public var itemS:OrderItem[];

    def updater=bind OrderViewController.itemHasChanged on replace{
        if(OrderViewController.itemHasChanged){
            def ite=OrderViewController.items;
            delete itemS;
            itemS=getItems(ite);
            if(sizeof itemS>NUMBER_OF_VIEWEDITEMS){
                extraSpace=(sizeof itemS-NUMBER_OF_VIEWEDITEMS)*(OrderItem.HEIGHT+VSPACING)-VSPACING;
            }
            else
                extraSpace=SCROLLBAR_INITIAL_VALUE;
          OrderViewController.itemHasChanged=false;
        }
    }

    def scrollbar=ScrollBar{
        layoutX:background.boundsInLocal.width-(SCROLLBAR_WIDTH+SPACING_BETWEEN_SCROLLBAR_BACKGROUND)
        height:BACKGROUND_HEIGHT
        vertical:true
        min:0
        max:bind extraSpace
    }

    def items=VBox{
        width: OrderItem.WIDTH+2 // rows will be wrap
        spacing:VSPACING // vertical gap between rows
        translateY:bind -scrollbar.value
        content:bind itemS
   }

    def view=ClipView{
        clipX:0
        clipY:0
        width:OrderItem.WIDTH+2
        height:BACKGROUND_HEIGHT
        pannable:false
        node:items
    }
    
    def content=Group{
        content:[view,scrollbar]
    }

    public override function create(): Node {
        return Group {
                    content: [background,content]
                };
    }
}

