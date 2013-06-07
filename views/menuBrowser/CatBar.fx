/*
 * CatBar.fx
 *
 * Created on Feb 7, 2010, 9:27:00 PM
 */

package views.menuBrowser;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import models.categoryT.CategoryDB;
import javafx.scene.layout.HBox;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import controllers.viewControllers.MenuBrowserController;
import javafx.scene.layout.ClipView;
import javafx.scene.shape.Polygon;
import javafx.scene.paint.Color;
import javafx.geometry.VPos;
import javafx.scene.Cursor;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.TextOrigin;

/**
 * @author vic
 */

public class CatBar extends CustomNode {

    def model:CategoryDB[]=bind MenuBrowserController.getAllCategories();
    def totalWidth=592;
    def buttonWidth=15;
    def buttonWidthSpacing=2;
    def maxWidthPerTitle=150; //enough to hold 25 character of size 12
    def maxNumOfChar=maxWidthPerTitle/6;
    def spacingBetweenTitles=10;
    def viewWidth=totalWidth-(buttonWidth + buttonWidthSpacing)*2;

    //constants to be initialized
    var sizeOfContent:Integer;
    var size:Integer;
    var sum:Integer=0;//represent the total size of the content

    var current:Integer;

    //1 char of size 12 has 6 px in width
    function title(s:String):String{
       if(s!=null){
        var result:String;
        sum+=s.length()*6;
        if(s.length()*6>maxWidthPerTitle){
               result=s.substring(0, maxNumOfChar-2);
               result="{result}..";
       }
       else
            result=s;
            return result;
        }
      else{
          return "";
      }
    }

    init{
        sizeOfContent=sum+((sizeof model) - 1)*spacingBetweenTitles+30;
        size=if(viewWidth<sizeOfContent){ sizeOfContent;} else viewWidth;
        current=viewWidth;
    }

    def content=HBox{
        spacing:spacingBetweenTitles
        nodeVPos: VPos.CENTER
        content:[for(i in [0..sizeof model])
                    Group{
                          def pos=i
                          def t=Text{ content:title(model[i].getcName())
                            font:Font{ size:12}
                            cursor:Cursor.HAND
                            textOrigin:TextOrigin.TOP
                            onMouseClicked:function(event){
                                MenuBrowserController.display(model[pos]);
                        }
                         }
                         def r=Rectangle{
                                width:t.boundsInLocal.width
                                height:t.boundsInLocal.height
                                opacity:0
                                blocksMouse:true
                                cursor:Cursor.HAND
                                onMouseClicked:function(event){
                                    MenuBrowserController.display(model[pos]);
                        }
                         }
                       content:[r,t]
                    }
        ]
    }

    def view=ClipView{
        layoutX:buttonWidth+buttonWidthSpacing
        width:viewWidth
        node:content
        pannable:false
    }

    def left=Polygon{
        points:[
            buttonWidth,0,
            0,buttonWidth/2,
            buttonWidth,buttonWidth
            ]
        fill:Color.RED
        cursor:Cursor.HAND
        blocksMouse:true
        onMouseClicked:function(event){
            if(size!=viewWidth){
                if(size>current){
                    current+=6;
                    content.translateX+=-6;
                }
            }
        }
    }
    def right=Polygon{
        def pos=viewWidth+buttonWidthSpacing*2+buttonWidth;
        points:[
            pos,0,
            pos+buttonWidth,buttonWidth/2,
            pos,buttonWidth
            ]
        fill:Color.RED
        cursor:Cursor.HAND
        blocksMouse:true
        onMouseClicked:function(event){
            if(size!=viewWidth){
                if(current>viewWidth){
                    current-=6;
                    content.translateX+=6;
                }
            }
        }
    }


    public override function create(): Node {
        return Group {
                    content: [left,view,right]
                };
    }
}
