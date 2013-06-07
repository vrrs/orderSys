/*
 * DialogContent.fx
 *
 * Created on Mar 7, 2010, 11:07:48 AM
 */
package views.titleMenu.tools.statisticDialogElements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.layout.HBox;
import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import javafx.scene.control.RadioButton;
import javafx.scene.layout.VBox;
import controllers.dataControllers.StatisticsDataController;
import javafx.scene.control.ToggleGroup;
import javafx.geometry.VPos;

/**
 * @author vic
 */
public class DialogContent extends CustomNode {

    var finishLoading = false;
    var update = false;
    def salesCriteria = SwingComboBox {
                items: [
                    SwingComboBoxItem {
                        text: "Quantity"
                        selected: true
                        value: false
                    }
                    SwingComboBoxItem {
                        text: "Total Sales"
                        selected: false
                        value: true
                    }
                ]
            }
    def orderingCriteria = SwingComboBox {
                items: [
                    SwingComboBoxItem {
                        text: "Highest 20"
                        selected: true
                        value: true
                    }
                    SwingComboBoxItem {
                        text: "Lowest 20"
                        selected: false
                        value: false
                    }
                ]
            }
    def top = HBox {
                content: [salesCriteria, orderingCriteria]
                spacing: 30
            }
    var graphicPanel: GraphicPanel;
    def year = RadioButton {
                text: "Current Year"
                toggleGroup: groupCriteria
                selected: false
            }
    def monthB = RadioButton {
                text: "By Months"
                toggleGroup: groupCriteria
                selected: false
            }
    def m = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    def months = SwingComboBox {
                items: for (mo in m) {
                    SwingComboBoxItem {
                        text: mo
                        selected: if (mo.compareTo("January") == 0) {
                            true;
                        } else {
                            false
                        }
                        value: indexof mo + 1
                    }
                }
                disable: bind not monthB.selected
                translateX: 40
            }
    def monthG = VBox {
                spacing: 4
                content: [monthB, months]
            }
    def weekB = RadioButton {
                text: "By Weeks"
                toggleGroup: groupCriteria
                selected: false
            }
    def weeks = SwingComboBox {
                items: for (i in [1..52]) {
                    SwingComboBoxItem {
                        text: "Week {i}"
                        selected: if (i == 1) {
                            true
                        } else {
                            false
                        }
                        value: i
                    }
                }
                disable: bind not weekB.selected
                translateX: 40
            }
    def weekG = VBox {
                spacing: 4
                content: [weekB, weeks]
            }
    def today = RadioButton {
                text: "Today"
                toggleGroup: groupCriteria
                selected: true
            }
    def groupCriteria = ToggleGroup {
                }
    def side = VBox {
                spacing: 40
                content: [today, year, monthG, weekG]
            }
    def down = HBox {
                nodeVPos: VPos.CENTER
                spacing: 30
                content: [side]
            }
    def content = VBox {
                content: bind [top, down]
                spacing: 15
            }
    var model = new StatisticsDataController();
    var yName: String;

    function getGraphicPanel(): GraphicPanel {
        model.trigger();
        var r: Number[];
        if (model.isTotalSale()) {
            var size=sizeof model.getTotal();
            if(size>20){
                size=20;
            }
            for (i in [0..<size]) {
                r[i] = model.getTotal()[i] as Number;
            }
        }
        else {
            var size=sizeof model.getQuantity();
            if(size>20){
                size=20;
            }
            for (i in [0..<size]) {
                r[i] = model.getQuantity()[i] as Number;
            }
        }
        var snVal:String[];
        var sizeN=sizeof model.getQuantity();
        if(sizeN>20){
              sizeN=20;
            }
        if(sizeN==0) {
                snVal=[];
        }
        else {
                for (i in [0..<sizeN]) {
                    snVal[i]=model.getNames()[i] as String;
                }
        }
        def result = GraphicPanel {
                    title: "Statistics of Orders"
                    yName: yName
                    sx: r
                    sn:snVal
                }
        return result;
    }

    def updateDateFunction = function () {
                if (today.selected) {
                    model.setDates(model.today(), model.today());
                } else {
                    if (year.selected) {
                        model.setDates(model.firstDayOfTheYear(), model.lastDayOfTheYear());
                    } else {
                        if (monthB.selected) {
                            model.setDates(model.firstDayOfTheMonth(months.selectedItem.value as Integer), model.lastDayOfTheMonth(months.selectedItem.value as Integer));
                        } else {
                            model.setDates(model.firstDayOfWeek(weeks.selectedItem.value as Integer), model.lastDayOfWeek(weeks.selectedItem.value as Integer));
                        }
                    }
                }
            }
    def trigger0 = bind salesCriteria.selectedIndex on replace {
                if (trigger0 != -1) {
                    model.setTotalSale(salesCriteria.selectedItem.value as Boolean);
                    yName = salesCriteria.selectedItem.text;
                    update = true;
                }
            }
    def trigger1 = bind orderingCriteria.selectedIndex on replace {
                if (trigger1 != -1) {
                    model.setHighest(orderingCriteria.selectedItem.value as Boolean);
                    update = true;
                }
            }
    def trigger3 = bind weeks.selectedIndex on replace {
                updateDateFunction();
                update = true;
            }
    def trigger4 = bind months.selectedIndex on replace {
                updateDateFunction();
                update = true;
            }
    def trigger5 = bind today.selected on replace {
                if (trigger5) {
                    year.selected = false;
                    weekB.selected = false;
                    monthB.selected = false;
                    updateDateFunction();
                    update = true;
                }
            }
    def trigger6 = bind year.selected on replace {
                if (trigger6) {
                    today.selected = false;
                    weekB.selected = false;
                    monthB.selected = false;

                    updateDateFunction();
                    update = true;
                }
            }
    def trigger7 = bind weekB.selected on replace {
                if (trigger7) {
                    today.selected = false;
                    year.selected = false;
                    monthB.selected = false;

                    updateDateFunction();
                    update = true;
                }
            }
    def trigger8 = bind monthB.selected on replace {
                if (trigger6) {
                    today.selected = false;
                    weekB.selected = false;
                    year.selected = false;
                    updateDateFunction();
                    update = true;
                }
            }
    def mainTrigger = bind update on replace {
                if (finishLoading and update) {
                    model.trigger();
                    graphicPanel = getGraphicPanel();
                    if (not down.content[0].equals(side)) {
                        delete  down.content[0];
                    }
                    insert graphicPanel before down.content[0];
                    }
                    update=false;
            }
    
    init{
        year.selected=true;
        weekB.selected=true;
        monthB.selected=true;
        year.selected=false;
        weekB.selected=false;
        monthB.selected=false;
        finishLoading=true;
        today.selected=true;
    }

    public override function create(): Node {
        return Group {
                    content: bind [content]
                };
    }
}

