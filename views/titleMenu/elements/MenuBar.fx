/*
 * MenuBar.fx
 *
 * Created on Feb 15, 2010, 10:07:33 PM
 */

package views.titleMenu.elements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;

/**
 * @author vic
 */
 
public def HEIGHT=27;      //It can hold menu with text of 19 px
public var BASE1_HEIGHT:Integer;

public class MenuBar extends CustomNode {

    def DISTANCE_BASE0_BASE1=2;
    def HSPACING_MENUS=23;
    def DISTANCE_BASE1_MENUS=2;
    public var WIDTH=1426;    //It covers the full screen
    init{
        BASE1_HEIGHT=HEIGHT-DISTANCE_BASE0_BASE1*2;
    }

    def base0=Rectangle{
        width:WIDTH
        height:HEIGHT
        fill:Color.BLACK
        arcWidth:10
        arcHeight:10
    }

    def base1=Rectangle{
        width:WIDTH-DISTANCE_BASE0_BASE1*2
        height:HEIGHT-DISTANCE_BASE0_BASE1*2
        layoutX:DISTANCE_BASE0_BASE1
        layoutY:DISTANCE_BASE0_BASE1
        arcWidth:10
        arcHeight:10
        fill:LinearGradient{
            startX:0 startY:0
            endX:1 endY:1
            proportional:true
            stops:[
                    Stop{ color:Color.GRAY offset:0}
                    Stop{ color:Color.BLACK offset:0.5}
                    Stop{ color:Color.RED offset:1}
                   ]
        }
    }

    def menus=Group{
        layoutX:DISTANCE_BASE1_MENUS
        layoutY:DISTANCE_BASE1_MENUS
    }

    public function addMenu(m:Menu):Void{
        if(sizeof menus.content==0) {insert m into menus.content;}
          else{
                def x=menus.content[sizeof menus.content -1].layoutX;
                def y=menus.content[sizeof menus.content -1].layoutY;
                def w=(menus.content[sizeof menus.content -1] as Menu).WIDTHL;
                insert m into menus.content;
                m.layoutX=x+w+HSPACING_MENUS;
                m.layoutY=y;
            }
    }

  public override function create(): Node {
                return Group {
                            content: [base0,base1,menus]
                        };
            }

}