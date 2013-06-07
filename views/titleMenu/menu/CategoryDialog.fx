/*
 * CategoryDialog.fx
 *
 * Created on Feb 25, 2010, 10:31:56 PM
 */

package views.titleMenu.menu;

import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.control.TextBox;
import javafx.scene.layout.VBox;
import javafx.scene.control.Button;
import javafx.scene.layout.HBox;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import models.categoryT.CategoryQue;
import javafx.stage.Alert;
import models.categoryT.CategoryDB;
import models.categoryT.CategoryOp;
import javafx.geometry.HPos;
import javafx.scene.Group;
import javafx.geometry.VPos;
import models.subcategoryT.SubcategoryQue;
import models.subcategoryT.SubcategoryOp;
import controllers.viewControllers.MenuBrowserController;

/**
 * @author vic
 */

public class CategoryDialog extends DialogBase{

   var toDisable=true;
   def searchBox:SearchBoxM=SearchBoxM{
       disable:bind toDisable
       getItems:function(inputText):String[]{
           def query=new CategoryQue();
           def r=query.searchByCategory(inputText);
           return for(i in [0..<sizeof r]) r[i].getcName();
       }

    }

   def categoryL=Text{
        content:"Type new category"
        font:Font{
            size:15
        }
    }
   def textboxS=[TextBox{},TextBox{}];
   def name=VBox{
        content:[categoryL,textboxS[0]]
        spacing:5
    }

   var category:CategoryDB;
   def updater=bind searchBox.value on replace{
       if(updater.compareTo("")!=0){
           def query=new CategoryQue();
           category=query.searchByCategory(updater)[0];
           textboxS[0].text=category.getcName();
           textboxS[1].text=category.getDetail();
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
                    if(textboxS[0].text.compareTo("")==0){
                        Alert.inform("Information", "You didnt type a name for the Category. So, anything will be saved.");
                    }
                    else{
                        def cat=new CategoryDB();
                        cat.setcName(textboxS[0].text);
                        cat.setDetail(textboxS[1].text);
                        def updater=new CategoryOp();
                        updater.saveCategory(cat);
                        searchBox.clearTextbox();
                        textboxS[0].text="";
                        textboxS[1].text="";
                        close();
                    }
                  },
                  function(){
                     if(category==null){
                         Alert.inform("Information", "You havent selected any category. Please, try again.");
                     }
                     else{
                        category.setcName(textboxS[0].text);
                        category.setDetail(textboxS[1].text);
                        def updater=new CategoryOp();
                        updater.editCategory(category);
                        textboxS[0].text="";
                        textboxS[1].text="";
                        searchBox.clearTextbox();
                        close();
                     }
                  },
                  function(){
                         if(category==null){
                             Alert.inform("Information", "You havent selected any category. Please, try again.");
                         }
                         else{
                            def updater=new CategoryOp();
                            moveToUnCategorized();
                            updater.deleteCategory(category);
                            textboxS[0].text="";
                            textboxS[1].text="";
                            searchBox.clearTextbox();
                            close();
                        }
                  }
           ];
   function moveToUnCategorized():Void{
           def query=new CategoryQue();
           //determine the new uncategorized index and obj
           def queryIndex=query.searchByCategory("Uncategorized")[0].getId();
           def newIndex:Integer=if(queryIndex>=0) {queryIndex;} else {0};
           def newCategoryTemp=query.searchByCategory("Uncategorized")[0];
           def newCategory=if(newCategoryTemp!=null) {newCategoryTemp} else {query.searchByID(0)}
           //determine the current subcategory index
           def oldIndex=category.getId();

           def subCatQuery=new SubcategoryQue();
           def subCatUpdater=new SubcategoryOp();
           def subCatItems=subCatQuery.searchByCategory(oldIndex);
           for(i in [0..<sizeof subCatItems]){
               subCatItems[i].setCategoryID(newIndex);
               subCatUpdater.editSubcategory(newCategory,subCatItems[i]);
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
        content:[middle,buttonsD,searchBox]
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
   
   override var windowWidth=320;
   override var windowHeight=275;
   
   override var newAct=function(){
       unClickedAll();
       toDisable=true;
       indexAct=0;
       textboxS[0].editable=true;
       textboxS[1].editable=true;
   }
   override var editAct=function(){
       unClickedAll();
       toDisable=false;
       indexAct=1;
       searchBox.requestFocus();
       textboxS[0].editable=true;
       textboxS[0].requestFocus();
       textboxS[1].editable=true;
   }
   override var deleteAct=function(){
       unClickedAll();
       toDisable=false;
       indexAct=2;
       textboxS[0].editable=false;
       textboxS[1].editable=false;
   }

   override protected function createScene () : Boolean {
         newB.toClick();
         title="Category Managment";
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
