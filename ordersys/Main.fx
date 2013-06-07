/*
 * Main.fx
 *
 * Created on Jan 17, 2010, 11:18:09 AM
 */

package ordersys;

import javafx.stage.Stage;
import javafx.scene.Scene;
import controllers.viewControllers.MenuBarController;

def gui=GUI{};

Stage {

    title: "OrderSys"
    width: 1280
    height: 750
    scene: Scene {
        content: [gui]
    }
    onClose:function(){
        MenuBarController.exit();
    }

}