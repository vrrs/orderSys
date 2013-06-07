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
import models.FXPadModel;

/**
 *
 * @author vic
 */

public class FXPadDataController {
    private FXPadModel model;

    public FXPadDataController(){
        read();
    }

    public FXPadDataController(int dummyVar){}

    public FXPadModel getModel() {
        return model;
    }

    private void write(){
        String fileName=DB.getFXPadModelFileName();
        try{
            FileOutputStream file=new FileOutputStream(fileName);
            ObjectOutputStream obj=new ObjectOutputStream(file);
            obj.writeObject(model);
            obj.close();
        }
        catch(IOException io){
            System.out.println("Error in FXPadDataController.write:"+io.getLocalizedMessage()
                    +".Posible cause:Error in writting the file.");
        }
    }

    private void read(){
        String fileName=DB.getFXPadModelFileName();
        try{
            FileInputStream file=new FileInputStream(fileName);
            ObjectInputStream obj=new ObjectInputStream(file);
            model=(FXPadModel) obj.readObject();
            obj.close();
        }
        catch(IOException io){
            System.out.println("Error in FXPadDataController.read:"+io.getLocalizedMessage()
                    +".Posible cause:Error in reading the file.");
        }
         catch(ClassNotFoundException c){
            System.out.println("Error in FXPadDataController.read:"+c.getLocalizedMessage()
                    +".Posible cause:the object has not been found.");
        }
    }

    public void save(FXPadModel m){
        model=m;
        write();
    }
    public void save(){
        write();
    }
}
