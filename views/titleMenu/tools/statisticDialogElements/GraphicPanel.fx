/*
 * GraphicPanel.fx
 *
 * Created on Mar 4, 2010, 11:31:00 AM
 */
package views.titleMenu.tools.statisticDialogElements;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.part.NumberAxis;
import javafx.scene.text.Font;
import javafx.util.Sequences;
import javafx.scene.chart.part.CategoryAxis;
import javafx.util.Math;

 public def HEIGHT= 500;
 public def WIDTH= 800;

/**
 * @author vic
 *    this class display the data in the order as it was entered.
 */
public class GraphicPanel extends CustomNode {

    public var sx: Number[];
    public var sn: String[];
    public var yName: String;
    public var title: String;
    def DIFFERENCE_GREATESTVALUE_UPPERBOUND = 2;

    function getUpperBound(): Number {
        return if(sizeof sx>0){(Sequences.max(sx) as Number)+DIFFERENCE_GREATESTVALUE_UPPERBOUND;} else {0};
    }

    function getLowerBound(): Number {
        return 0;
    }

    function getIncrementUnit(): Number {
       var sum:Number=0;
       for(i in [1..<sizeof sx]){
          sum+=Math.abs(sx[i]-sx[i-1]);
       }
       def r=sum/(sizeof sx-1);
       return  Math.round(r);
    }

    var barChart: BarChart = BarChart {
                title: bind title
                titleFont: Font { size: 24 }
                height:HEIGHT
                width:WIDTH
                categoryAxis: CategoryAxis {
                    categories:[""]
                }
                valueAxis: NumberAxis {
                    label: bind yName
                    lowerBound: getLowerBound()
                    upperBound: getUpperBound()
                    tickUnit: getIncrementUnit()
                }
                data:for (s in sx) {
                    BarChart.Series {
                        name: sn[indexof s]
                        data: [
                            BarChart.Data {
                                value: s
                                category:""
                            }
                        ]
                    }
                }
            }

    public override function create(): Node {
        return Group {
                    content: [barChart]
                };
    }

}

