/*
 * SubcategoryDialog.fx
 *
 * Created on Mar 1, 2010, 9:27:54 AM
 */

package views.titleMenu.menu;

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
import models.subcategoryT.SubcategoryQue;
import models.subcategoryT.SubcategoryDB;
import models.subcategoryT.SubcategoryOp;
import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import models.categoryT.CategoryQue;
import models.categoryT.CategoryDB;
import models.menuT.MenuQue;
import models.menuT.MenuOp;
import controllers.viewControllers.MenuBrowserController;

/**
 * @author vic
 */

public class SubcategoryDialog extends DialogBase{

   var toDisable=true;
   def searchBox:SearchBoxM=SearchBoxM{
       disable:bind toDisable
       getItems:function(inputText):String[]{
           def query=new SubcategoryQue();
           def r=query.searchBysubName(inputText);
           return for(i in [0..<sizeof r]) r[i].getSubName();
       }

    }

   def subcategoryL=Text{
        content:"Type new Subcategory"
        font:Font{
            size:15
        }
    }
   def textboxS=[TextBox{},TextBox{}];
   def name=VBox{
        content:[subcategoryL,textboxS[0]]
        spacing:5
    }

   var catOptions:SwingComboBoxItem[];
   var toDisableCat=false;
   def categories=SwingComboBox {
	layoutX:searchBox.layoutX+searchBox.layoutBounds.width+59
        layoutY:searchBox.layoutY+19
        disable:bind toDisableCat
        def query=new CategoryQue()
        def rows=query.searchAllCategory();
        items: [SwingComboBoxItem {
			text: ""
			selected: true
		},
                catOptions=for(i in [0..<sizeof rows]){
                    SwingComboBoxItem {
                    	text: rows[i].getcName()
			selected: false
                       value:rows[i]
                    }
                }
             ]
}
   var subcategory:SubcategoryDB;
   var category:CategoryDB;
   def updater=bind searchBox.value on replace{
       if(updater.compareTo("")!=0){
           def queryS=new SubcategoryQue();
           def queryC=new CategoryQue();
           subcategory=queryS.searchByExactsubName(updater)[0];
           category=queryC.searchByID(subcategory.getCategoryID());
           for(i in [0..<sizeof catOptions]){
                def optionT=catOptions[i].text;
                if(category.getcName().compareTo(optionT)==0){
                    categories.selectedIndex=i+1;
                    break;
                }
           }
           textboxS[0].text=subcategory.getSubName();
           textboxS[1].text=subcategory.getSubDetail();
       }
   }

   def updateCat=bind categories.selectedIndex on replace{
       if(updateCat>-1){
           category=categories.selectedItem.value as CategoryDB
       }
   }


   def detail=Text{
        content:"Details"
        font:Font{
            size:15
        }
    }
    
   def det=VBox{
        content:[detail,textboxS[1]]
        spacing:5
    }

   def middle=HBox{
        layoutY:searchBox.layoutY+searchBox.layoutBounds.height+20
        spacing:30
        nodeVPos:VPos.BOTTOM
        content:[name,det]
    }

   var indexAct=0;
   def actionFs=[
                  function()   {
                    if(textboxS[0].text.compareTo("")==0 or categories.selectedIndex==0){
                        Alert.inform("Information", "You didnt type a name for the Subcategory or didnt select a category. So, anything will be saved.");
                    }
                    else{
                        def subcat=new SubcategoryDB();
                        subcat.setSubName(textboxS[0].text);
                        subcat.setSubDetail(textboxS[1].text);
                        def updater=new SubcategoryOp();
                        updater.saveSubcategory(category, subcat);
                        searchBox.clearTextbox();
                        textboxS[0].text="";
                        textboxS[1].text="";
                        close();
                        newB.toClick();
                    }
                  },
                  function(){
                     var update:SubcategoryOp;
                     if(subcategory==null){
                         Alert.inform("Information", "You havent selected any subcategory. Please, try again.");
                     }
                     else{
                        subcategory.setSubName(textboxS[0].text);
                        subcategory.setSubDetail(textboxS[1].text);
                        category=categories.selectedItem.value as CategoryDB;
                        update=new SubcategoryOp();
                        update.editSubcategory(category, subcategory);
                        textboxS[0].text="";
                        textboxS[1].text="";
                        searchBox.clearTextbox();
                        close();
                        newB.toClick();
                     }
                  },
                  function(){
                         if(subcategory==null){
                             Alert.inform("Information", "You havent selected any subcategory. Please, try again.");
                         }
                         else{
                            def updater=new SubcategoryOp();
                            moveToUnSubcategorized();
                            updater.deleteSubcategory(subcategory);
                            textboxS[0].text="";
                            textboxS[1].text="";
                            searchBox.clearTextbox();
                            close();
                            newB.toClick();
                        }
                  }
           ];

   function moveToUnSubcategorized():Void{
           def query=new SubcategoryQue();
           //determine the new unsubcategorized index
           def queryIndex=query.searchByExactsubName("UnSubcategorized")[0].getId();
           def newIndex:Integer=if(queryIndex>=0) {queryIndex;} else {0};
           //determine the current subcategory index
           def oldIndex=subcategory.getId();

           def menuQuery=new MenuQue();
           def menuUpdater=new MenuOp();
           def menuItems=menuQuery.searchBySubCategory(oldIndex);
           for(i in [0..<sizeof menuItems]){
               menuItems[i].setSubCaID(newIndex);
               menuUpdater.editMenu(menuItems[i]);
           }

   }

   def saveB=Button{
        text:"Save"
        action:function(){
            actionFs[indexAct]();
            MenuBrowserController.loadDB();
        }

    }
   def cancel=Button{
        text:"Cancel"
        action:function(){
            textboxS[0].text="";
            textboxS[1].text="";
            searchBox.clearTextbox();
            close();
        }

    }
   def buttonsD=HBox{
        layoutY:middle.height+ middle.layoutY+30
        translateX:80
        spacing:20
        content:[saveB,cancel]
    }

   def panelContent=Group{
        content:[middle,buttonsD,searchBox,categories]
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

   override var windowWidth=394;
   override var windowHeight=275;

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
         title="Subcategory Managment";
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
