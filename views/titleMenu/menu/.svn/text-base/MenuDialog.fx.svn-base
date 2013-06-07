/*
 * MenuDialog.fx
 *
 * Created on Mar 1, 2010, 3:28:38 PM
 */

package views.titleMenu.menu;

import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import javafx.geometry.HPos;
import javafx.geometry.VPos;
import javafx.scene.Group;
import javafx.scene.control.Button;
import javafx.scene.control.TextBox;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Alert;
import models.subcategoryT.SubcategoryDB;
import models.subcategoryT.SubcategoryQue;
import models.menuT.MenuQue;
import models.menuT.MenuDB;
import javafx.ext.swing.SwingCheckBox;
import controllers.dataControllers.SettingsController;
import models.menuT.MenuOp;
import controllers.viewControllers.OrderViewController;
import controllers.viewControllers.MenuBrowserController;

/**
 * @author vic
 */

public class MenuDialog extends DialogBase{

   var toDisable=true;
   def searchBox:SearchBoxM=SearchBoxM{
       disable:bind toDisable
       getItems:function(inputText):String[]{
           def query=new MenuQue();
           def r=query.searchByProduct(inputText);
           return for(i in [0..<sizeof r]) r[i].getProduct();
       }

    }

   def menuL=Text{
        content:"Type new Product"
        font:Font{
            size:15
        }
    }
   def textboxS=[TextBox{},TextBox{},TextBox{translateY:15}];

   def priceL=Text{
       content:"Price"
       font:Font{
           size:15
       }
       translateY:15
   }  

   def name=VBox{
        content:[menuL,textboxS[0],priceL,textboxS[2]]
        spacing:5
    }

   var subcatOptions:SwingComboBoxItem[];
   var toDisableCat=false;
   def subcategories=SwingComboBox {
	layoutX:searchBox.layoutX+searchBox.layoutBounds.width+46
        layoutY:searchBox.layoutY+19
        disable:bind toDisableCat
        def query=new SubcategoryQue()
        def rows=query.searchAll();
        items: [SwingComboBoxItem {
			text: ""
			selected: true
		},
                subcatOptions=for(i in [0..<sizeof rows]){
                    SwingComboBoxItem {
                    	text: rows[i].getSubName()
			selected: false
                       value:rows[i]
                    }
                }
             ]
}
   var model=new SettingsController(0);
   bound function getItems(){
       return model.getSetting().getTaxedItems();
   }

   var subcategory:SubcategoryDB;
   var menuItem:MenuDB;
   var taxedItems=bind getItems();
   var subcatFlag=true;
   def updater=bind searchBox.value on replace{
       if(updater.compareTo("")!=0){
           def queryS=new SubcategoryQue();
           def queryM=new MenuQue();
           menuItem=queryM.searchByProduct(updater)[0];
           subcategory=queryS.searchByID(menuItem.getSubCaID());
           for(i in [0..<sizeof subcatOptions]){
                def optionT=subcatOptions[i].text;
                if(subcategory.getSubName().compareTo(optionT)==0){
                    subcatFlag=false;subcategories.selectedIndex=i+1;
                    break;
                }
           }
           textboxS[0].text=menuItem.getProduct();
           textboxS[1].text=menuItem.getProductDetail();
           textboxS[2].text=menuItem.getPrice().toString();
           taxedCheckbox.selected=isATaxedItem();
       }
   }
   def updateSubcat=bind subcategories.selectedIndex on replace{
       if(subcatFlag and updateSubcat>-1){
           subcategory=subcategories.selectedItem.value as SubcategoryDB
       }
       subcatFlag=true;
   }
   function isATaxedItem():Boolean{
       for(i in [0..<taxedItems.size()]){
           def temp=taxedItems.get(i).intValue();
           if(temp==menuItem.getId()){
               return true;
           }
       }
       false;
   }


   def detail=Text{
        content:"Details"
        font:Font{
            size:15
        }
    }
    def taxedCheckbox=SwingCheckBox {
	text: "Taxed Item"
        translateY:36
    }

   def det=VBox{
        content:[detail,textboxS[1],taxedCheckbox]
        spacing:5
    }

   def middle=HBox{
        layoutY:searchBox.layoutY+searchBox.layoutBounds.height+20
        spacing:47
        nodeVPos:VPos.TOP
        content:[name,det]
    }

   var indexAct=0;
   def actionFs=[
                  function()   {
                    var errorFlag=false;var price:Double;
                    try{
                        price=Double.parseDouble(textboxS[2].text);
                    }
                    catch(NumberFormatException){
                        errorFlag=true;
                    }

                    if(textboxS[0].text.compareTo("")==0 or subcategories.selectedIndex==0 or errorFlag){
                        Alert.inform("Information", "You didnt type a name for the product or didnt select a subcategory or typed a letter in the price value. So, anything will be saved.");
                    }
                    else{
                        def product=new MenuDB();
                        product.setProduct(textboxS[0].text);
                        product.setProductDetail(textboxS[1].text);
                        product.setPrice(price);
                        product.setSubCaID(subcategory.getId());
                        def updater=new MenuOp();
                        updater.saveMenu(subcategory, product);

                        updater.closeConection();
                        def query=new MenuQue();
                        def index=query.searchByProduct(product.getProduct())[0].getId();
                        if(taxedCheckbox.selected){
                            model.getSetting().getTaxedItems().add(index);
                            model.save();
                        }

                        searchBox.clearTextbox();
                        textboxS[0].text="";
                        textboxS[1].text="";
                        textboxS[2].text="";
                        close();
                        newB.toClick();
                    }
                  },
                  function(){
                     var errorFlag=false;var price:Double;
                    try{
                        price=Double.parseDouble(textboxS[2].text);
                    }
                    catch(NumberFormatException){
                        errorFlag=true;
                    }
                     var update:MenuOp;
                     if(subcategory==null or errorFlag or textboxS[0].text.compareTo("")==0){
                         Alert.inform("Information", "You havent selected any subcategory or typed a letter in the price value. Please, try again.");
                     }
                     else{
                        menuItem.setProduct(textboxS[0].text);
                        menuItem.setProductDetail(textboxS[1].text);
                        menuItem.setPrice(price);
                        subcategory=subcategories.selectedItem.value as SubcategoryDB;
                        menuItem.setSubCaID(subcategory.getId());
                        update=new MenuOp();
                        update.editMenu(menuItem);
                        
                        def index=menuItem.getId();   
                        def find=function(j:Integer):Integer{
                            for(i in [0..<sizeof model.getSetting().getTaxedItems()]){
                                if(model.getSetting().getTaxedItems().get(i).intValue()==j){
                                    return i;
                                }
                            }
                            return -1;
                        }
                        
                        if((taxedCheckbox.selected and not isATaxedItem()) or (not taxedCheckbox.selected and isATaxedItem())){
                            if(taxedCheckbox.selected){
                                model.getSetting().getTaxedItems().add(index);
                            }
                            else{
                                model.getSetting().getTaxedItems().removeElementAt(find(index));
                            }
                            model.save();
                        }
                        
                        textboxS[0].text="";
                        textboxS[1].text="";
                        textboxS[2].text="";
                        searchBox.clearTextbox();
                        close();
                        newB.toClick();
                     }
                  },
                  function(){
                         if(menuItem==null){
                             Alert.inform("Information", "You havent selected any product. Please, try again.");
                         }
                         else{
                            def updater=new MenuOp();
                            updater.deleteMenu(menuItem);
                            textboxS[0].text="";
                            textboxS[1].text="";
                            textboxS[2].text="";
                            searchBox.clearTextbox();
                            close();
                            newB.toClick();
                        }
                  }
           ];

   def saveB=Button{
        text:"Save"
        action:function(){
            actionFs[indexAct]();
            OrderViewController.orderOV.updateTaxadValues();
            MenuBrowserController.loadDB();
        }

    }
   def cancel=Button{
        text:"Cancel"
        action:function(){
            textboxS[0].text="";
            textboxS[1].text="";
            textboxS[2].text="";
            searchBox.clearTextbox();
            close();
        }

    }
   def buttonsD=HBox{
        layoutY:middle.height+ middle.layoutY+35
        translateX:80
        spacing:35
        content:[saveB,cancel]
    }

   def panelContent=Group{
        content:[middle,buttonsD,searchBox,subcategories]
        translateX:6
        translateY:4
    }

   def background=Rectangle{
      fill:Color.WHITESMOKE
    }

   def panelD=Group{
       content:[background,panelContent]
   }

   def panel=VBox{
        layoutX:2
        layoutY:2
        nodeHPos:HPos.CENTER
        spacing:1
        content:[buttons,panelD]
   }

   override var windowWidth=386;
   override var windowHeight=330;

   override var newAct=function(){
       unClickedAll();
       toDisableCat=false;
       toDisable=true;
       indexAct=0;
       textboxS[0].editable=true;
       textboxS[1].editable=true;
   }
   override var editAct=function(){
       unClickedAll();
       toDisable=false;
       indexAct=1;
       toDisableCat=false;
       searchBox.requestFocus();
       textboxS[0].editable=true;
       textboxS[0].requestFocus();
       textboxS[1].editable=true;
   }
   override var deleteAct=function(){
       unClickedAll();
       toDisable=false;
       toDisableCat=true;
       indexAct=2;
       textboxS[0].editable=false;
       textboxS[1].editable=false;
   }

   override protected function createScene () : Boolean {
         newB.toClick();
         title="Product Managment";
         backgroundButtons.width=windowWidth-8;
         background.width=windowWidth-8;
         background.height=windowHeight-backgroundButtons.height-BAR_HEIGHT-10;
         sceneContent.content=panel;
         window=windowModel;
         window.toFront();
         true;
    }

   def run=createScene();

}

