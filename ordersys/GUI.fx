/*
 * GUI.fx
 *
 * Created on Feb 19, 2010, 2:46:08 PM
 */

package ordersys;
import controllers.viewControllers.OrderMagController;
import views.orderView.OrderView;
import views.menuBrowser.MenuBrowser;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.CustomNode;
import views.orderBrowser.OrderBrowserView;
import controllers.viewControllers.OrderViewController;
import views.titleMenu.Menus;

/**
 * @author vic
 */

public var menuBrowser:MenuBrowser;
public var orderViewCon=OrderViewController{};
public var orderMagCon:OrderMagController;
public var currentOrder:OrderView;
public var orders:OrderBrowserView;
public var menuBar:Menus=Menus{layoutX:1 layoutY:1};

public class GUI extends CustomNode {

    def HSPACING_SCENE_COMPS=2;
    def HSPACING_CURRENTORDER_MENU_ERROR=-13;

    var bSign:BusinessSign;
    
    init{
        menuBrowser=MenuBrowser{layoutX:HSPACING_SCENE_COMPS layoutY:31};
        orderMagCon==OrderMagController{};
        currentOrder=OrderView{layoutX:menuBrowser.layoutBounds.width+HSPACING_CURRENTORDER_MENU_ERROR layoutY:74};
        orders=OrderBrowserView{
                layoutX:currentOrder.layoutX+currentOrder.WIDTH+HSPACING_SCENE_COMPS+2
                layoutY:currentOrder.layoutY
        }
        orderMagCon.newOrder();
        bSign=BusinessSign{
            layoutX:currentOrder.layoutX+4
            layoutY:menuBrowser.layoutY
        }

    }

    public override function create(): Node {
		return Group {
			content:bind [ menuBrowser,currentOrder,orders,menuBar,bSign]
		};
	}
}
