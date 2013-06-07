/*
 * MenuBrowserController.fx
 *
 * Created on Feb 2, 2010, 9:24:42 PM
 */

package controllers.viewControllers;

import models.categoryT.CategoryDB;
import models.menuT.MenuDB;
import models.subcategoryT.SubcategoryDB;
import models.categoryT.CategoryQue;
import models.subcategoryT.SubcategoryQue;
import models.menuT.MenuQue;
import models.modelsDB;
import controllers.dataControllers.Item;
import views.menuBrowser.MenuItem;
import javafx.stage.Alert;


    var history:MenuItem[];
    var historyE:Integer[]; //history that stores the rowWidths
    var indexes:Integer[];

    //this var notify when one of the models has changed
    public var hasAnyModelChanged=false;

    //this map contain a category and MenuItem,extrarows and a subcategory and MenuITem,extrarows
    var map=new MapWrapper();

    //the row width in menubrowserItems
    public var rowWidth:Integer;

    //this var store what menu is currently being displayed
    public var current:Integer=0;

    //this var contain every displayable item
    public var viewItems:MenuItem[];
    //this var contain the value of extrarow in menuBrowserItem
    public var extraRow:Integer;

   //this methods are used by navigate through the different types of menu
    public function goBack():Void{
        if(current>0){
            current--;
            delete viewItems;
            viewItems=history[indexes[2*current]..indexes[2*current+1]];
            extraRow=historyE[current];
            trigger();
        }
    }
    public function goForward():Void{
        if(current<sizeof history-1){
           current++;
           delete viewItems;
           viewItems=history[indexes[2*current]..indexes[2*current+1]];
           extraRow=historyE[current];
           trigger();
        }
    }

    public function  display(model:CategoryDB):Void{
        delete viewItems;
        viewItems=(map.getCatM().get(model.getId()) as Wrapper).values;
        extraRow=map.getCatE().get(model.getId())as Integer;
        insert viewItems into history;
        insert extraRow into historyE;
        setupIndexes(sizeof viewItems);
        current++;
        trigger();
    }

    public function display(model:SubcategoryDB):Void{
        delete viewItems;
        viewItems=(map.getSubcatM().get(model.getId()) as Wrapper).values;
        extraRow=map.getSubcatE().get(model.getId())as Integer;
        insert viewItems into history;
        insert extraRow into historyE;
        setupIndexes(sizeof viewItems);
        current++;
        trigger();
    }
    //}

    //add an item to the order
    public function  display(model:MenuDB,quantity:Integer):Void{
        var item=new Item();
        item.setQuantity(quantity);
        item.setModel(model);
        OrderViewController.addItem(item);
    }

    function trigger():Void{
       hasAnyModelChanged=true;
    }

    public function getAllCategories():CategoryDB[]{
           def m=new CategoryQue();
           try{return m.searchAllCategory();}
           catch(Exception){
               return null;
           }

     }

    public function submitSearch(s:String,type:Integer):Void{
           def query=new MenuQue();
           var data:MenuDB[];
           try{
                if(type==0)  {
                    data=query.searchByProduct(s);}
                else
                    data=query.searchThisProduct(s);
            }
            catch(Exception){
                Alert.inform("Error loading data from the DB", "The software could not load some data from the Database. Please contact the software support.(MenuBrowserController.submitSearch())");
            }
           wrap_set(data);
           insert viewItems into history;
           insert extraRow into historyE;
           setupIndexes(sizeof viewItems);
           current++;
           trigger();
    }

    public function loadDB():Boolean{
        map.clear();
        var queryS;
        var subcategories;
        var queryM;
        var categories;
        try{
            queryS=new SubcategoryQue();
            subcategories=queryS.searchAll();
            queryM=new MenuQue();
            categories=getAllCategories();
        }
        catch(Exception){
            Alert.inform("Error loading the DB", "The Database could not be loaded. Please contact the software support.");
        }

        var rows=0;var wt=0;var w:Integer;var s:String;var item:MenuItem[];var extraRows:Integer;
        var models:modelsDB[];var mapM; var mapE;var subs:modelsDB[];
        for(i in [0..1]){
            if(i==0)  {
              models=categories;
              mapM=map.getCatM();
              mapE=map.getCatE();
            }
            else{
                models=subcategories;
                mapM=map.getSubcatM();
                mapE=map.getSubcatE();
            }
            for(model in models){
                try{
                    if(i==0){
                        subs=queryS.searchByCategory((model as CategoryDB).getId());
                    }
                    else{
                        subs=queryM.searchBySubCategory((model as SubcategoryDB).getId());
                    }
                }
                catch(Exception){
                     Alert.inform("Error loading data from the DB", "The software could not load some data from the Database. Please contact the software support.(MenuBrowserController.loadDB())");
                }
                for(sub in subs){
                    if(i==0){
                        s=(sub as SubcategoryDB).getSubDetail();
                    }
                    else{
                        s=(sub as MenuDB).getProductDetail();
                    }
                    w=MenuItem.getMaxWidth(s);
                    wt+=w;
                    if(wt>rowWidth){
                         wt=w;
                         rows++;
                    }
                    insert MenuItem{models:sub} into item;
                }
                rows++;
                if(rows>=3){
                    extraRows=rows-3;}
                else{
                    extraRows=0;}
                mapM.put(model.getId(),Wrapper{values:item});
                mapE.put(model.getId(),extraRows);
                delete item;
            }
        }
        true;
    }

    function wrap_set(models:MenuDB[]){
        var rows=0;var wt=0;var w:Integer;var s:String;var item:MenuItem[];var extraRows:Integer;
        for(model in models){
            s=model.getProductDetail();
            w=MenuItem.getMaxWidth(s);
            wt+=w;
            if(wt>rowWidth){
                  wt=w;
                  rows++;
            }
            insert MenuItem{models:model} into item;
            rows++;
            if(rows>=3){
                extraRows=rows-3;}
            else{
                extraRows=0;}
        }
        delete viewItems;
        viewItems=item;
        extraRow=extraRows;
    }

    function setupIndexes(length:Integer):Void{
        def indexIn=indexes[sizeof indexes-1]+1;
        def indexF=length+indexIn-1;
        insert indexIn into indexes;
        insert indexF into indexes;
    }

    public function initC():Boolean{
        loadDB();
        def query=new SubcategoryQue();
        var sub;
        try{
                sub=query.searchByID(0);
        }
        catch(Exception){
            Alert.inform("Error loading data from the DB", "The software could not load some data from the Database. Please contact the software support.(MenuBrowserController.initC())");
        }

        viewItems=(map.getSubcatM().get(sub.getId()) as Wrapper).values;
        rowWidth=map.getSubcatE().get(sub.getId()) as Integer;
        insert viewItems into history;
        indexes[0]=0;
        insert sizeof viewItems -1 into indexes;
        insert extraRow into historyE;
        current=0;
        trigger();
        true;
    }

    class Wrapper{
        public var values:MenuItem[];
    }
