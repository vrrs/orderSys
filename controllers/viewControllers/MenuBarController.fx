/*
 * MenuBarController.fx
 *
 * Created on Feb 20, 2010, 8:11:38 PM
 */


package controllers.viewControllers;

import views.titleMenu.tools.calculator.Calc;
import javafx.lang.FX;
import java.lang.Integer;
import java.lang.Void;
import views.titleMenu.customers.AddCustomer;
import java.lang.System;
import views.titleMenu.tools.FXpad.FXPad;
import views.titleMenu.tools.FXpad.OpenD;
import controllers.dataControllers.FXPadDataController;
import views.titleMenu.tools.FXpad.SaveD;
import views.titleMenu.main.MainOpen;
import views.titleMenu.main.MainSave;
import controllers.dataControllers.OrderDataController;
import views.titleMenu.customers.CusEd;
import views.titleMenu.menu.CategoryDialog;
import views.titleMenu.menu.SubcategoryDialog;
import views.titleMenu.menu.MenuDialog;
import views.titleMenu.tools.OptionsDialog;
import views.titleMenu.help.Help;
import views.titleMenu.tools.Statistics;

/**
 * @author vic
 */
 
 //Main Menu{
  //properties{
    def calc=Calc{};
    def calculator=calc.getCalc();
    def notepad=FXPad.getPad();
    var openOrder="null";
    def orderModel=new OrderDataController();
    def openMainWindow=MainOpen{};
    def saveWindow=MainSave{};
    def edit=CusEd{editable:true label:"Edit" actIndex:0 titleW:"Edit Customer"};
    def editW=edit.getWindow();
    def delet=CusEd{editable:false label:"Delete" actIndex:1 titleW:"Delete Customer"};
    def deleteW=delet.getWindow();
    def catMag=CategoryDialog{};
    def winCM=catMag.getWindow();
    def subMag=SubcategoryDialog{};
    def winSM=subMag.getWindow();
    def menuMag=MenuDialog{};
    def winMG=menuMag.getWindow();
    def stat=Statistics{}
    def winST=stat.getWindow();
    def opt=OptionsDialog{}
    def winOP=opt.getWindow();
   //}
  //methods{
    public function show(menuID:Integer):Void{
    def blocks:function()[]=[
            function(){
                openMain();
            }
            function(){
                saveMain();
            }
            function(){
                OrderViewController.singlePrint();
            }
            function(){
                exit();
            }
            function(){
                def cus=new AddCustomer();
                cus.main([]);
            }
            function(){
                editW.show();
            }
            function(){
                deleteW.show();
            }
            function(){
                winCM.show();
            }
            function(){
                winSM.show();
            }
            function(){
                winMG.show();
            }
            function(){
                calculator.show();
            }
            function(){
                notepad.show();
            }
            function(){
                winST.show();
            }
            function(){
                winOP.show();
            }
            function(){
                def winHelp=new Help();
                winHelp.main([]);
            }
    ];
    def exec:function()=blocks[menuID];
    exec();

 }
    public function openMain(){
        def win=openMainWindow.getWindow();
        win.show();
    }
    public function openMain(s:String){
        openOrder=s;
        def index=orderModel.getModel().getOrderNames().indexOf(s);
        def order=orderModel.getModel().getOrders().get(index);
        OrderMagController.openOrder(order);
    }
    public function saveMain(s:String){
        openOrder=s;
        orderModel.getModel().getOrderNames().add(s);
        orderModel.getModel().getOrders().add(OrderMagController.order);
        orderModel.save();
    }
    public function saveMain(){
        if(openOrder.compareTo("null")==0){
                def win=saveWindow.getWindow();
                win.show();
            }
            else{
                def index=orderModel.getModel().getOrderNames().indexOf(openOrder);
                def order=OrderMagController.order;
                orderModel.getModel().getOrders().setElementAt(order,index);
                orderModel.save();
            }
    }

    public function exit():Void{
     FX.exit();
     System.exit(0);
 }
  //}
 //}

 //notepad methods{
    //properties
    var openFile:String="null";
    def model= new FXPadDataController();
    def openWindow=OpenD{};
    def openW=openWindow.getWindow();
    def save=SaveD{}
    //methods
    public function FXPadNew(){
        openFile="null";
        FXPad.pad.setData("");
    }
    public function FXPadSave(data:String,criteria:Integer){
        if(criteria==0){
             if(openFile.compareTo("null")==0){
                def win=save.getWindow();
                win.show();
             }
             else{
                def index=model.getModel().getFileNames().indexOf(openFile);
                model.getModel().getData().setElementAt(data, index);
                model.save();
             }
        }
        else{
             openFile=data;
             model.getModel().getFileNames().add(data);
             model.getModel().getData().add(FXPad.pad.getData());
             model.save();
        }
    }
    public function FXPadOpen(data:String){
        openFile=data;
        def index=model.getModel().getFileNames().indexOf(data);
        FXPad.pad.setData(model.getModel().getData().get(index));
    }
    public function FXPadOpen(){
        openW.show();
    }
 //}

public class MenuBarController {}
