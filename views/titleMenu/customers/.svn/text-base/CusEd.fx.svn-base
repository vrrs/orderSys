/*
 * CusEd.fx
 *
 * Created on Feb 24, 2010, 11:06:26 AM
 */

package views.titleMenu.customers;

import views.titleMenu.elements.FXDialog;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.control.TextBox;
import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.geometry.HPos;
import javafx.scene.control.ListView;
import javafx.scene.control.Button;
import javafx.scene.Group;
import javafx.scene.paint.Color;
import models.customerT.CustomerDB;
import models.customerT.CustomerQue;
import javafx.stage.Alert;
import models.customerT.CustomerOp;

/**
 * @author vic
 */
//this is a dialog that abstract the edit and delete dialogs for the customer section
public class CusEd extends FXDialog{

    public-init var editable:Boolean;
    public-init var label:String;
    public-init var actIndex:Integer;//0 means edit
    public-init var titleW:String;

    def ACTS=[function(){
                def updater=new CustomerOp();
                updateCustomer();
                updater.editCustomer(customer);
                close();
             },
             function(){
                def updater=new CustomerOp();
                updater.deleteCustomer(customer);
                close();
             }
            ];
    def act=ACTS[actIndex];

    def VSPACING_LABEL_TEXTBOX=10;
    def HSPACING_TEXTBOX_COMBOBOX=10;
    def HSPACING_TEXTBOXES=20;
    def VSPACING_TEXTBOXES=15;
    def VSPACING_SECTIONS=15;
    def HSPACING_BUTTONS=15;
    def LIST_HEIGHT=200;
    def LIST_WIDTH=[120,100];
    def SPACING_BACKGROUND_CONTENT=7;

    //top section
    def searchL=Text{
        content:"Search"
        font:Font{
            size:18
            embolden:true
        }
    }
    def searchBox:TextBox=TextBox{
        onKeyTyped:function(event){
            submitSearch(searchBox.rawText);
        }
        action:function(){
            submitSearch(searchBox.text);
        }
    }
    def comboBox= SwingComboBox  {
	items: [
		SwingComboBoxItem {
			text: "Name"
			selected: true
		}
                SwingComboBoxItem {
			text: "Address"
			selected: false
		}
                SwingComboBoxItem {
			text: "Telephone"
			selected: false
		}
                SwingComboBoxItem {
			text: "Cellphone"
			selected: false
		}
                SwingComboBoxItem {
			text: "TagName"
			selected: false
		}
                SwingComboBoxItem {
			text: "Email"
			selected: false
		}
	]
}
    def comboTextbox=HBox{
        spacing:HSPACING_TEXTBOX_COMBOBOX
        content:[searchBox,comboBox]
    }
    def top=VBox{
        nodeHPos:HPos.LEFT
        spacing:VSPACING_LABEL_TEXTBOX
        content:[searchL,comboTextbox]
    }

    //display_selected_row section
    def labelsN=["Name","Address","Telephone","Cellphone","Email","Tag"];
    def labels=for(i in [0..5]){
        Text{
            content:labelsN[i]
            font:Font{
                size:14
            }
        }
    }
    def textBoxes=for(i in [0..5]){ TextBox{editable:editable} };
    def display=VBox{
        layoutY:top.layoutX+top.height+VSPACING_SECTIONS
        spacing:VSPACING_TEXTBOXES
        content:for(rows in [0,2,4]){
            HBox{
                spacing:HSPACING_TEXTBOXES
                content:for(item in [0,1]){
                    VBox{
                        spacing:VSPACING_LABEL_TEXTBOX
                        content:[labels[rows+item],textBoxes[rows+item]]
                    }
                }
            }
        }
    }

    //display_all_rows section
    def labels2=for(i in [0..5]){
        Text{
            content:labelsN[i]
            font:Font{
                size:14
            }
        }
    }
    def lists=for(i in [0,0,1,1,1,0]) ListView{width:bind LIST_WIDTH[i] height:bind LIST_HEIGHT };
    def listDisplay=Group{
         var k=[SPACING_BACKGROUND_CONTENT,SPACING_BACKGROUND_CONTENT+120,SPACING_BACKGROUND_CONTENT+2*120-10,
         SPACING_BACKGROUND_CONTENT+2*120+100-10,SPACING_BACKGROUND_CONTENT+2*120+2*100-10,SPACING_BACKGROUND_CONTENT+2*120+3*100];
        layoutY:display.layoutY+display.height+VSPACING_SECTIONS
        content:for(i in [0..5] )
            VBox{
                layoutX:k[i]
                nodeHPos:HPos.CENTER
                content:[labels2[i],lists[i]]
        }
    }

    //buttons
    def accept=Button{
        text:label
        action:function(){
            act();
        }
    }
    def cancel=Button{
        text:"Cancel"
        action:function(){
            close();
        }

    }
    def buttons=HBox{
        layoutY:listDisplay.layoutY+listDisplay.layoutBounds.height+VSPACING_SECTIONS+15
        translateX:230
       spacing:HSPACING_BUTTONS
        content:[accept,cancel]
    }

    //content
    def contentW=Group{
        layoutX:SPACING_BACKGROUND_CONTENT
        layoutY:SPACING_BACKGROUND_CONTENT
        content:[top,display,listDisplay,buttons]
    }

    def background=Rectangle{
        width:680+2*SPACING_BACKGROUND_CONTENT
        height:535+2*SPACING_BACKGROUND_CONTENT
        fill:Color.WHITESMOKE
    }

    def scene=Group{
        translateX:2
        content:[background,contentW]
    }

    var customers:CustomerDB[] on replace{
       if(customers!=null){
            for(i in [0..5]){
               textBoxes[i].text=customers[0].get(i+1);
               delete lists[i].items;
               lists[i].items=for(j in [0..<sizeof customers]) customers[j].get(i+1);
            }
       }
    }
    function submitSearch(s:String){
        def query=new CustomerQue();
        if(comboBox.selectedItem.text.compareTo("Name")==0){
            customers=query.searchByName(s);
        }
        else{
            if(comboBox.selectedItem.text.compareTo("Address")==0){
                customers=query.searchByAddress(s);
            }
            else{
                if(comboBox.selectedItem.text.compareTo("Telephone")==0){
                   var flag=true;  var ss=s; var num:Integer;
                   if(s.compareTo("")==0){
                       ss="0";
                   }
                   try{
                        num=Integer.parseInt(ss);
                    }
                    catch(NumberFormatException){
                        flag=false;
                        Alert.inform("Error","The telephone number must not contain letters. Please, try again.");
                    }
                    if(flag){
                        customers=query.searchByTel(num);
                    }
                }
                else{
                    if(comboBox.selectedItem.text.compareTo("Cellphone")==0){
                        var flag=true;  var ss=s; var num:Integer;
                        if(s.compareTo("")==0){
                            ss="0";
                        }
                        try{
                            num=Integer.parseInt(ss);
                        }
                        catch(NumberFormatException){
                            flag=false;
                            Alert.inform("Error","The Cellphone number must not contain letters. Please, try again.");
                        }
                        if(flag){
                            customers=query.searchByCel(num);
                        }
                    }
                    else{
                       if(comboBox.selectedItem.text.compareTo("Email")==0){
                            customers=query.searchByEmail(s);
                       }
                       else{
                           if(comboBox.selectedItem.text.compareTo("Tag")==0){
                                customers=query.searchBytag(s);
                           }
                       }
                    }
                }
            }
        }
    }
    

    override var windowWidth=702+SPACING_BACKGROUND_COMPS;
    override var windowHeight=556+SPACING_BACKGROUND_COMPS+BAR_HEIGHT;

    var selectedList:Integer=-1;
    var customer:CustomerDB=getCustomer(selectedList) on replace{
        if(customers!=null){
            for(i in [0..5]){
               textBoxes[i].text=customer.get(i+1);
            }
        }
    }
    function getCustomer(s:Integer):CustomerDB{
        if(s>-1){
            def row:Integer=lists[s].selectedIndex;
            return customers[row];
       }
       else{
           return null;
       }
    }
    function updateCustomer():Void{
        for(i in [0..5]){
            var  flag=true;
            if(i+1==3 or i+1==4){
                try{
                    def val=Integer.parseInt(textBoxes[i].text);
                }
                catch(NumberFormatException){
                    Alert.inform("Input Error","Either the telephone number or the cellphone number contain letters. Please, try again.");
                    flag=false;
                }

            }
            if(flag)    customer.set(i+1,textBoxes[i].text);
        }

    }

    bound function trigger():Integer{
        def binary:Integer[]=[if(lists[0].selectedIndex>-1){1;} else {0;},
                if(lists[1].selectedIndex>-1){1;}else {0;},if(lists[2].selectedIndex>-1) {1;} else {0;},
                if(lists[3].selectedIndex>-1){1;}else {0;},if(lists[4].selectedIndex>-1) {1;} else {0;},
                if(lists[5].selectedIndex>-1){1;}else {0;}];
        return binary[0]*32+binary[1]*16+binary[2]*8+binary[3]*4+binary[4]*2+binary[5]*1;
    }
    var clearSelectionFlag=true;
    def selectUpdater=bind trigger() on replace {
        if(selectUpdater>0 and clearSelectionFlag){
            //determine the columns selected
            var selectedlists:Integer[];
            for(i in [0..5]){
                if (lists[i].selectedIndex>-1) {insert i into selectedlists;}
            }
            if((sizeof selectedlists==1 and selectedlists[0]==selectedList)){customer=getCustomer(selectedList);} else{
            //enforce mutual exclusion between lists
            if(selectedList!=-1 and selectedlists[0]==selectedList){
                selectedList=selectedlists[1];
                customer=getCustomer(selectedList);
                if(sizeof selectedlists>1) {lists[selectedlists[0]].clearSelection();clearSelectionFlag=false;}
            }
            else{
                selectedList=selectedlists[0];
                customer=getCustomer(selectedList);
               if(sizeof selectedlists>1) {lists[selectedlists[1]].clearSelection();clearSelectionFlag=false;}
            }
        }}
        else{
            if(clearSelectionFlag) {selectedList=-1;customer=getCustomer(selectedList);}
            clearSelectionFlag=true;
        }
    }

    override protected function createScene () : Boolean {
        title=titleW;
        sceneContent.content=scene;
        window=windowModel;
        window.toFront();
        searchBox.requestFocus();
        true;
    }

    def run=createScene();

}