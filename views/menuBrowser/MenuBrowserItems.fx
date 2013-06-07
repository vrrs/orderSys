/*
 * MenuBrowserItems.fx displays the menuItems in the GUI
 *
 * Created on Feb 2, 2010, 9:56:28 AM
 */

package views.menuBrowser;

import javafx.scene.CustomNode;
import javafx.scene.layout.Flow;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.paint.Color;
import javafx.scene.Node;
import javafx.scene.layout.ClipView;
import javafx.scene.control.ScrollBar;
import javafx.scene.Group;
import controllers.viewControllers.MenuBrowserController;

public class MenuBrowserItems extends CustomNode{

    //component dimensions=(w,h)=(764,727)
    //window dimensions=(w,h)=(1280,750)
    //These are maximum sizes
    def menuItemHspacing=10;
    def menuItemWidth=181;
    def scrollbarWidth=5;
    def menuItemVspacing=5;
    def menuItemHeight=172;
    def gapContentScrollbar=5;
    def numberItemsPerRow=4;
    def numberOfgapBetweenItems=numberItemsPerRow-1;
    def GENERAL_TRANSLATION=-31;
    def SCROLLVAR_INITIAL_VALUE=(menuItemVspacing+menuItemHeight)*3;
    def ROW_WIDTH=menuItemHspacing*numberOfgapBetweenItems+menuItemWidth*numberItemsPerRow;


    def m0=MenuBrowserController.rowWidth=ROW_WIDTH;
    def m1=MenuBrowserController.initC();
    var items:MenuItem[];

    def updater=bind MenuBrowserController.hasAnyModelChanged on replace {
        if(MenuBrowserController.hasAnyModelChanged){
            extraRows=MenuBrowserController.extraRow;
            delete items;
            items=MenuBrowserController.viewItems;
        }
        MenuBrowserController.hasAnyModelChanged=false;
    }

    var extraRows:Integer;

    //elements of the component graphical representation{
    def background=Rectangle{
        def w=menuItemHspacing*numberOfgapBetweenItems+menuItemWidth*numberItemsPerRow+scrollbarWidth+gapContentScrollbar
        def h=menuItemVspacing*numberOfgapBetweenItems+menuItemHeight*numberItemsPerRow+GENERAL_TRANSLATION
        width:w
        height:h
        arcWidth:10
        arcHeight:10
        fill:LinearGradient{
            startX:0,startY:0
            endX:w,endY:h
            proportional:false
            def colors=[Color.RED,Color.BLACK,Color.GRAY]
            def seq=[0,1,0,2,1,0,1,0,2,1,0,1,0,2,1,0,1,0,2,2];
            stops:[for(i in [0..19])Stop{
                         color:colors[seq[i]]
                         offset:i/19
                         }
                ]
        }
   }

    def content=Flow{
         translateY:bind -scrollbar.value
         hgap:menuItemHspacing
         vgap:menuItemVspacing
         width:menuItemHspacing*numberOfgapBetweenItems+menuItemWidth*numberItemsPerRow
         content:bind items;
     }

    def scrollbar=ScrollBar{
        layoutX:menuItemHspacing*numberOfgapBetweenItems+menuItemWidth*numberItemsPerRow+gapContentScrollbar
        height:menuItemVspacing*numberOfgapBetweenItems+menuItemHeight*numberItemsPerRow+GENERAL_TRANSLATION
        translateX:-3
        min:0
        max:bind extraRows*(menuItemVspacing+menuItemHeight)+SCROLLVAR_INITIAL_VALUE
        vertical:true
    }

    def contentViewed=ClipView{
        width:menuItemHspacing*numberOfgapBetweenItems+menuItemWidth*numberItemsPerRow
        height:menuItemVspacing*numberOfgapBetweenItems+menuItemHeight*numberItemsPerRow+GENERAL_TRANSLATION
        pannable:false
        clipX:0
        clipY:0
        node:content
        translateX:2
        translateY:2
    }
    //}

   override function create():Node{
        return Group{
                    content:bind [background,contentViewed,scrollbar]
        }
    }

}
