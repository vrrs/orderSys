
package views.menuBrowser;

import javafx.scene.CustomNode;
import models.menuT.MenuDB;
import javafx.animation.Interpolator;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.Node;
import javafx.scene.control.TextBox;
import javafx.scene.effect.DropShadow;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import java.lang.Boolean;
import java.lang.Void;
import javafx.scene.Group;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.text.TextOrigin;
import javafx.util.Math;
import javafx.scene.shape.Line;
import models.categoryT.CategoryDB;
import models.subcategoryT.SubcategoryDB;
import controllers.viewControllers.MenuBrowserController;
import javafx.stage.Alert;
import java.lang.NumberFormatException;

function getAncho(s:String):Integer{
        if (s.length()<=11){
            0;
        }
        else{
            if(s.length()>=21) {
                60;
            }
            else{
                Math.round((s.length()-11)*5.87);
            }
        }
    }

public function getMaxWidth(modelDetail:String):Integer{
    def baseDetailWide=78;
    def detailWidth=getAncho(modelDetail)+baseDetailWide;
    def baseR=114;
    def gap=3;
    return baseR+gap+detailWidth;
}

public class MenuItem extends CustomNode{


    public-init var models;
    var menuF=models.getClass().getName().compareTo("models.menuT.MenuDB")==0;
    var catF=models.getClass().getName().compareTo("models.categoryT.CategoryDB")==0;
    var subCatF=models.getClass().getName().compareTo("models.subcategoryT.SubcategoryDB")==0;
    //it contains the data from the model
    public-init var model:MenuDB=if(menuF)
                            {models as MenuDB}
                        else
                            null;
    public-init var model1:CategoryDB=if(catF)
                                {models as CategoryDB}
                            else
                                null;
    public-init var model2:SubcategoryDB=if(subCatF)
                                        {models as SubcategoryDB}
                                    else
                                        null;
    //this var containt the text that will be shown in the component
    var name:String=if(model!=null) {
                        getName(model.getProduct());}
                    else{
                        if(model1!=null){
                            getName(model1.getcName());
                        }
                        else{
                            getName(model2.getSubName());}
                    }
    //this var contain the price of the product
    var price:String=if(model!=null) {  getPrice(Double.toString(model.getPrice()));}
                        else
                            "";
    //this var set the image name for the image Path
    var imageN:String=if(menuF) {
                        getImageN("m",model.getId());}
                    else{
                        if(catF){
                            getImageN("c",model1.getId());
                        }
                        else{
                            getImageN("s",model2.getId());}
                    }

    var detail=if(model!=null) {
                        model.getProductDetail();}
                    else{
                        if(model1!=null){
                            model1.getDetail();
                        }
                        else
                            model2.getSubDetail();
                    }
    var ancho=getAncho(detail);
    var paragraph=getParagraph(detail);
    var row=getRow(paragraph);

   var quantity:Integer=1;//this is the var will store the quantity of this menuItem

    function getName(s:String):String{
        //this is the number of characters posible in the textArea
        def titleLength=18;
        var result:String;

        if(s.length()<titleLength){
            result=s;
        }
        else{
            result=s.substring(0,titleLength-1);
            def BIG_LETTERS=["W","Q","Z","M","H","O","D","U"];
            var uc=0;
            for(i in [0..sizeof BIG_LETTERS]) {if(s.indexOf(BIG_LETTERS[i])>0) {uc++;}}
            var lc=0;
            for(i in [0..sizeof BIG_LETTERS]) {if(s.indexOf(BIG_LETTERS[i].toLowerCase())>0) {lc++;}}
            if(uc>=2 or lc>=3 or (uc>0 and lc>=2)) result=result.substring(0,result.length()-1);
            result="{result}.";
          }
          return result;
    }

    function getPrice(s:String):String{
        return "${s}"
    }

    function getImageN(type:String,id:Integer):String{
       return "{type}{id}";
    }

    function getRow(s:String):Integer{
        var count=1;
        var k=0;
        while(s.indexOf("\n",k)>=0){
            count++;
            k=s.indexOf("\n",k)+2;
        }
        return count;
    }

    function getParagraph(s:String):String{
       if(s.length()<=21){
           return s;
       }
       else{
           var i=0;
           var sf:String;
           var si:String;
           si=s.substring(0,s.length());
           while(si.length()-i>21){
             sf=si.substring(i+21);
             si=si.substring(0,i+21);
             si=si.concat("\n{sf}");
             i+=23;
          }
          return si;
       }
    }

    var w=0;
    var h1=0;
    var vClose=false;
    var vTitle=false;
    var vPara=false;
    var vFondo=false;
    var value=true;

    def timeDet=Timeline{
		keyFrames:[
            KeyFrame{
                time:0s
                values:[h1=>0,w=>0]
				action:function(){
					vFondo=value;
				}
            }
            KeyFrame{
                time:0.2s
				action:function(){
					vTitle=value;
				}
                values:[h1=>17 tween Interpolator.LINEAR,w=>46 tween Interpolator.LINEAR]
                }
			KeyFrame{
                time:0.4s
				action:function(){
					vClose=value;
				}
                values:[h1=>35 tween Interpolator.LINEAR,w=>78 tween Interpolator.LINEAR]
                },
                            KeyFrame{
				time:0.6s
                                action:function(){
                                        vPara=value;
                                    }
				values:[h1=>row*12+35 tween Interpolator.LINEAR,w=>78+ancho tween Interpolator.LINEAR]
                                    }
                                 

            ]
    }

    function hideDetail():Void{
    value=false;
    timeDet.pause();
    timeDet.rate=-1;
    timeDet.play();
}

    function showDetail():Void{
    value=true;
    if(timeDet.running) timeDet.pause();
    timeDet.rate=1;
    timeDet.playFromStart();
}

    def closeB=Text{
		content:"X"
		fill:Color.RED
		font:Font{ size:11}
		textOrigin:TextOrigin.TOP
		layoutX:bind w-11
		visible:bind vClose
		disable:bind not vClose
	}

    def title=Text{
                textOrigin:TextOrigin.TOP
		content:"Detail"
		fill:Color.BLACK
                effect:DropShadow{
                    color:Color.BLACK
                }

		font:Font{ size:15 embolden:true}
		disable:bind not vTitle
		visible:bind vTitle
	}

    def para=Text{
		content:paragraph
		
		layoutY:30
		font:Font{ size:12 }
		disable:bind not vPara
		visible:bind vPara
	}

    def con=Group{
		layoutX:2
		layoutY:2
		content:[title,closeB,para]
	}

    def fondo:Rectangle=Rectangle{
		var wi=bind w
                var he=bind h1
                width:bind wi
		height:bind he
                arcWidth: 10  arcHeight: 10
                
		fill:LinearGradient {
            startX: wi, startY: 0.0, endX: 0.0, endY:he
            proportional: true
            stops: [ Stop { offset: 0.0 color: Color.LIGHTGRAY },
                     Stop { offset: 1.0 color: Color.LIGHTBLUE} ]
        }
		disable:bind not vFondo;
	}

   def detailDisplayer= Group{
                blocksMouse:true
                 onMouseClicked:function(event){
			hideDetail();
		}
		content:[fondo,con]
		layoutX:117
	}

   //change the height of the rectangles and textbox
        var h:Integer=0;
        var hText:Integer=0;

        //enable the textBox
        var toDisable=true;

        //timeline for textbox and increase rectangles.height animation
        def timeL=Timeline{
            keyFrames:[
            KeyFrame{
                time:0s
                values:[h=>0,hText=>0]
                }
            KeyFrame{
                time:0.4s
                values:[h=>24 tween Interpolator.LINEAR,hText=>20 tween Interpolator.LINEAR]
                }
            ]
        }
          //open the textbox
        function open():Void{
            toDisable=false;
            if(timeL.running) timeL.pause();
            timeL.rate=1;
            timeL.playFromStart();
}
        //close the textBox
        function close():Void{
            timeL.pause();
            timeL.rate=-1;
            timeL.play();
            toDisable=true;
        }
        //ilumination effect
     function lightsON (n1:Rectangle,n2:Rectangle):Void{
	n1.effect=DropShadow{
				color:Color.RED
			}
	n2.effect=DropShadow{
				color:Color.RED
			}
        }
     function lightsOFF(n1:Rectangle,n2:Rectangle):Void{
	n1.effect=null;
	n2.effect=null
        }
     var r:Rectangle;
     var r1:Rectangle;
     
     //When loose focus, the component close the textbox by updating x
    function changeFocus(focus:Boolean):Boolean{
      if(not focus) {
		if(not toDisable) {
                        close();
                        lightsOFF(r,r1);
                        q.text="{quantity}";
                    }
            return true;
         }
        return false;
    }
       //the quantity textBox
       var q:TextBox;
       
       def x=bind changeFocus(q.focused);

    

   protected override function create(): Node{
        

      
        //base rectangle
        r=Rectangle{
		width:114;
		height:bind h +148;
		stroke:Color.BLACK;
		strokeWidth:1
		arcWidth:15
		arcHeight:15
		fill:Color.WHITE
		onMouseClicked:function(event){
                    r.requestFocus();
                }

               }
          def focus=bind r.focused on replace oldValue{
              close();
              lightsOFF(r,r1);
          }

            //top rectangle
            r1=Rectangle{
		x:2
		y:2
		arcWidth:15
		arcHeight:15
		width:110
		height:bind h + 144
		fill:Color.LIGHTGRAY
		strokeWidth:1
		stroke:Color.WHITESMOKE
            }
            //background image
            def imagenFondo=ImageView{
                        layoutX:2
                        layoutY:2
                        fitWidth:110
                        fitHeight:bind h+144
                        preserveRatio:false
                    image: Image{
                            def s="resources/background.png";
                            url:"{__DIR__}{s}";
                    }
			}
            //image
            def imagen=ImageView{
                layoutX:2
                layoutY:2
                fitWidth:100
                fitHeight:100
                preserveRatio:false
                image: Image{
                     def s="resources/images/";
                    url: "{__DIR__}{s}{imageN}.jpg";
                }
			}

            //text displayed on the component.Its the product name
            def text=Text{
			content:name
			font:Font{
                                    size:12
				    embolden:true
				}
			fill:Color.WHITE
			wrappingWidth:110
                        layoutY:116
			layoutX:4
			
		}
            //price text
            def priceT=Text{
			content:price
			font:Font{
				size:17
				embolden:true
				}
			fill:Color.WHITE
			layoutY:132
			layoutX:4
			wrappingWidth:100
		}

            //indicator
            def indi=Circle{
		centerX:8
		centerY:8
		radius:5
		fill:Color.RED
		stroke:Color.GRAY
		effect:DropShadow{color:Color.RED}
		visible:false
	}
        //max button{
        def cir=Circle{
		centerX:96
		centerY:8
		radius:5
		fill:Color.GREEN
		stroke:Color.GRAY
		effect:DropShadow{color:Color.GREEN}
}
        def line1=Line{
		startX:96 startY:3
		endX:96 endY:13
}
        def line2=Line{
		startX:91 startY:8
		endX:101 endY:8
}
        def maxB=Group{
            blocksMouse:true
            onMouseClicked:function(event){
                showDetail();
            }

            content:[cir,line1,line2]
}
        //Quantity textBox
         q=TextBox {
		layoutX:6
                 layoutY:137
                 text: "1"
		columns: 9
                selectOnFocus: true
		height:bind hText
                disable:bind toDisable
                action:function(){
                       if(not toDisable) {close();}
                       lightsOFF(r,r1);
                       var p;
                       try{
                                p=Integer.parseInt(q.text);
                                indi.visible=true;}
                            catch(s:NumberFormatException){
                                Alert.inform("Alert:Wrong Input","The quantity must be an integer number.Please, insert the value again,thanks.");
                                p=quantity;
                            }
                      quantity=p;
                      q.text="{quantity}";
                      if(model!=null){ 
                            MenuBrowserController.display(model,quantity);
                            quantity=1;
                            q.text="{quantity}";
                      }
                }
           }
       //}

        //it has the content of the component
        def vContent=Group{
		layoutX:5;
		layoutY:5;
		content:[imagen,text,q,indi,priceT,maxB]
	}

        def g=Group{


             onMouseClicked:function(event){
			if(event.clickCount==2){
				if(model!=null){
                                    indi.visible=true;
                                    MenuBrowserController.display(model,quantity);
                                    quantity=1;
                                    q.text="{quantity}";
                                    close();}
                                else{
                                        if(model1!=null){ MenuBrowserController.display(model1);}
                                            else{
                                                if(model2!=null){ MenuBrowserController.display(model2);}}}
				lightsOFF(r,r1);
			}
			else{
				if(event.clickCount==1){
                                    if(model!=null){
                                            if(toDisable) open();}
                                    lightsON(r,r1);
                               }
                       }
                    }
		content:[r,r1,imagenFondo,vContent,detailDisplayer];
			}
     
     return g;
   }

}
