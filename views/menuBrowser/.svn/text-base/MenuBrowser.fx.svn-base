/*
 * MenuBrowser.fx
 *
 * Created on Feb 8, 2010, 2:22:43 PM
 */

package views.menuBrowser;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import views.subcatView.SubCatView;

/**
 * @author vic
 */

public class MenuBrowser extends CustomNode {

    def subBar=SubCatView{
        layoutY:43
    }

    def menuList=MenuBrowserItems{
            layoutY:43
            layoutX:subBar.WIDTH+2
    }

    def bar=MenuBrowserBar{}

    public override function create(): Node {
        return Group {
                    content: [subBar,menuList,bar]
                };
    }
}
