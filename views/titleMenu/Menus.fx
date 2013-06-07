/*
 * Menu.fx
 *
 * Created on Feb 20, 2010, 1:58:12 PM
 */

package views.titleMenu;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import views.titleMenu.elements.Menu;
import views.titleMenu.elements.MenuBar;
import controllers.viewControllers.MenuBarController;

/**
 * @author vic
 */

public class Menus extends CustomNode {

    def m=MenuBarController{};
    //menubar
    def menuB=MenuBar{

    }

  //main menu{
    def main=Menu{
        label:"Main"
        widthLabel:36
    }
    //submenus
    def open=Menu{
        type:2
        label:"Open"
        widthLabel:22
        act:function(){
            MenuBarController.show(0);
        }
    }
    def save=Menu{
        type:2
        label:"Save"
        widthLabel:22
        act:function(){
            MenuBarController.show(1);
        }
    }
    def print=Menu{
        type:2
        label:"Print"
        widthLabel:30
        act:function(){
            MenuBarController.show(0);
        }
    }
    def exit=Menu{
        type:2
        label:"Exit"
        widthLabel:22
        act:function(){
            MenuBarController.show(3);
        }
    }
    //setup function
    function setMain(){
        def submenus=[open,save,print,exit];
        for(i in [0..3]){
            main.add(submenus[i]);
        }
    }
  //}
  //Customer Menu{
    def customer=Menu{
        label:"Customer"
        widthLabel:90
    }
    //submenus
    def add=Menu{
        type:2
        label:"Add Customer"
        widthLabel:80
        act:function(){
            MenuBarController.show(4);
        }
    }
    def edit=Menu{
        type:2
        label:"Edit Customer"
        widthLabel:84
        act:function(){
            MenuBarController.show(5);
        }
    }
    def remove=Menu{
        type:2
        label:"Delete Customer"
        widthLabel:150
        act:function(){
            MenuBarController.show(6);
        }
    }
    //setup function
    function setCustomer(){
        def submenus=[add,edit,remove];
        for(i in [0..2]){
            customer.add(submenus[i]);
        }
    }
  //}
  //product menu{
    def menu=Menu{
        label:"Menu"
        widthLabel:43
    }
    //submenus
    def category=Menu{
        type:2
        label:"Category"
        widthLabel:50
        act:function(){
            MenuBarController.show(7);
        }
    }
    def subCategory=Menu{
        type:2
        label:"Subcategory"
        widthLabel:70
        act:function(){
            MenuBarController.show(8);
        }
    }
    def product=Menu{
        type:2
        label:"Products"
        widthLabel:54
        act:function(){
            MenuBarController.show(9);
        }
    }
    //setup function
    function setMenu(){
        def submenus=[category,subCategory,product];
        for(i in [0..2]){
            menu.add(submenus[i]);
        }
    }
  //}
  //tools menu{
    def tool=Menu{
        label:"Tools"
        widthLabel:45
    }
    //submenus
    def calculator=Menu{
        type:2
        label:"Calculator"
        widthLabel:65
        act:function(){
            MenuBarController.show(10);
        }
    }
    def pad=Menu{
        type:2
        label:"Business Pad"
        widthLabel:80
        act:function(){
            MenuBarController.show(11);
        }
    }
    def statistics=Menu{
        type:2
        label:"Statistics"
        widthLabel:66
        act:function(){
            MenuBarController.show(12);
        }
    }
    def settings=Menu{
        type:2
        label:"Settings"
        widthLabel:66
        act:function(){
            MenuBarController.show(13);
        }
    }
    //setup function
    function setTools(){
        def submenus=[calculator,pad,statistics,settings];
        for(i in [0..3]){
            tool.add(submenus[i]);
        }
    }
  //}
  //help menu{
    def help=Menu{
        label:"Help"
        widthLabel:36
    }
    //submenus
    def about=Menu{
        type:2
        label:"About"
        widthLabel:34
        act:function(){
            MenuBarController.show(14);
        }
    }
    //setup function
    function setHelp(){
        def submenus=[about];
        help.add(submenus[0]);
    }
  //}
    //menubar setup
    function setMenuBar():Boolean{
        setMain();
        setCustomer();
        setMenu();
        setTools();
        setHelp();
        def menus=[main,customer,menu,tool,help];
        for(i in [0..4]){
            menuB.addMenu((menus[i]));
        }
        return true;
    }

    def setup=setMenuBar();

    public override function create(): Node {
        return Group {
                    content: [menuB]
                };
            }

}

