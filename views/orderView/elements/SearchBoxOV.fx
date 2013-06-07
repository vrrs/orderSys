/*
 * SearchBox.fx
 *
 * Created on Feb 8, 2010, 10:57:59 AM
 */

package views.orderView.elements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.control.TextBox;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.control.ListView;
import javafx.scene.input.KeyCode;
import models.customerT.CustomerQue;
import javafx.scene.layout.VBox;
import javafx.geometry.HPos;
import controllers.viewControllers.OrderViewController;
import javafx.stage.Alert;

public function getHeight():Integer{
    //this is the sum of the textBox.height+ label.height
    return 39;
}

public class SearchBoxOV extends CustomNode {
    
    public var columns=13;

    var toDisable:Boolean=true on replace oldValue{
          if(oldValue){
              this.parent.toFront();
              this.parent.parent.toFront();
          }

    }
        
    var options:String[];

    public-init var searchType:Integer;
    public-init var label:String;

    function getItems(s1:String):String[]{
        var s:String;
        if(s1.length()<=0){s="";} else s=s1;
        def query=new CustomerQue();
        var data=null;
        if(searchType==1){
            data=query.searchByName(s);
        }
        else{
            if(searchType==6){
                data=query.searchBytag(s);
            }
            else{
                if(searchType==2){
                    data=query.searchByAddress(s);
                }
                else{
                    if(searchType==3){
                        var r;var flag=true;
                        if(s.compareTo("")==0) {r=0;}
                         else{
                             try{r=Integer.parseInt(s);}
                             catch(NumberFormatException){
                                 flag=false;
                                 Alert.inform("Wrong Input","This is a telephone number. It must a number not a letter.");
                             }
                         }

                        if(flag) {data=query.searchByTel(r);}
                    }
                    if(searchType==5){
                        data=query.searchByEmail(s);
                    }
                    else{
                        if(searchType==4){
                            var r;var flag=true;
                        if(s.compareTo("")==0) {r=0;}
                         else{
                             try{r=Integer.parseInt(s);}
                             catch(NumberFormatException){
                                 flag=false;
                                 Alert.inform("Wrong Input","This is a Cellphone number.Thus, it must a number, not a letter.");
                             }
                         }

                        if(flag) {data=query.searchByCel(r);}
                        }
                    }
                }
            }
        }
        return if(data==null) {return null;} else{
                for(i in [0..sizeof data-1] where sizeof data>0 ){
            data[i].get(searchType);
        }
    }
}
    init{
        toDisable=true;
        if (label==null) {label="Search";}
    }
    def update=bind OrderViewController.customerTrigger on replace{
            if(OrderViewController.customerTrigger){
                    searchTextBox.commit();
                    searchTextBox.text="{OrderViewController.customer.get(searchType)}";
                    if(OrderViewController.triggerCount==5 ){OrderViewController.customerTrigger=false;OrderViewController.triggerCount=0;}
                        else
                            OrderViewController.triggerCount++;
            }
    }

    //width of the label=45
    def searchLabel=Text{
        content:label
        font:Font{ size:15 embolden:true}
    }

    //search component{
     public def  searchTextBox:TextBox=TextBox{
       columns:columns
       text:""
       onKeyTyped:function(event){
            if(OrderViewController.mode){
                if(toDisable) toDisable=false;
                delete options;
                searchListView.clearSelection();
                options=getItems(searchTextBox.rawText);
                searchListView.selectLastRow();
            }
        }
        action:function(){
            if(OrderViewController.mode){
                    toDisable=true;
                     if (sizeof options>0 and searchTextBox.text!=""){
                            OrderViewController.submitSearch(options[0],searchType);
                            delete options;
                            searchListView.clearSelection();
                       }
                searchTextBox.text="";
            }
        }
    }
    
    def searchListView:ListView=ListView{
        layoutY:searchTextBox.boundsInLocal.height+searchLabel.boundsInLocal.height+2
        layoutX:searchLabel.boundsInLocal.minX
        width:searchTextBox.boundsInLocal.width
        items:bind options
        height:bind (sizeof options)*19+19
        visible:bind not toDisable
        disable:bind toDisable
      onMouseClicked:function(event){
          if(event.clickCount==2){
              if (searchListView.selectedIndex!=-1){
                    if (sizeof options>0){
                        searchTextBox.text=options[searchListView.selectedIndex];
                        OrderViewController.submitSearch(options[searchListView.selectedIndex],searchType);
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
                        OrderViewController.submitSearch(options[searchListView.selectedIndex],searchType);
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
