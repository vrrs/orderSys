/*
 * MultilineTextBox.fx
 *
 * Created on Feb 22, 2010, 9:53:21 AM
 */

package views.titleMenu.elements;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javax.swing.JEditorPane;
import javafx.ext.swing.SwingComponent;

/**
 * @author vic
 */

public class MultilineTextBox extends CustomNode {

    public-init var swingTextbox: JEditorPane = new JEditorPane("text/plain","");
    var textbox:SwingComponent;

    public function getSwingTextbox(){
        return swingTextbox;
    }

    public function setSwingTextbox(t:JEditorPane){
        swingTextbox=t;
    }


    function createNode(){
        swingTextbox.setBackground(new java.awt.Color(0,0,0,0));
        textbox=SwingComponent.wrap( swingTextbox );
        true;
    }

    public function getTextbox():SwingComponent{
        return textbox;
    }

    def initiate=createNode();

    public override function create(): Node {
       def output= bind textbox;
       return output;
            }

}
