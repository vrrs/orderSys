 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package controllers.dataControllers;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import models.DB;

/**
 *
 * @author vic
 */
public class OrderDataController {

    private OrderModel model;

    public OrderDataController(){
        read();
    }

    public OrderDataController(int dummyVar){}

    private void write(){
        String fileName=DB.getOrderModelFileName();
        try{
            FileOutputStream file=new FileOutputStream(fileName);
            ObjectOutputStream obj=new ObjectOutputStream(file);
            obj.writeObject(model);
            obj.close();
        }
        catch(IOException io){
            System.out.println("Error in OrderDataController.write:"+io.getLocalizedMessage()+","+io.getCause()
                    +".Posible cause:Error in writting the file.");
        }
    }

    private void read(){
        String fileName=DB.getOrderModelFileName();
        try{
            FileInputStream file=new FileInputStream(fileName);
            ObjectInputStream obj=new ObjectInputStream(file);
            model=(OrderModel) obj.readObject();
            obj.close();
        }
        catch(IOException io){
            System.out.println("Error in OrderDataController.read:"+io.getLocalizedMessage()
                    +".Posible cause:Error in reading the file.");
        }
         catch(ClassNotFoundException c){
            System.out.println("Error in OrderDataController.read:"+c.getLocalizedMessage()
                    +".Posible cause:the object has not been found.");
        }
    }

    public void save(OrderModel m){
        model=m;
        write();
    }
    public void save(){
        write();
    }

    public OrderModel getModel() {
        return model;
    }

    public void setModel(OrderModel model) {
        this.model = model;
    }

    public OrderModel getOrderModelObj(){
        return new OrderModel();
    }
}