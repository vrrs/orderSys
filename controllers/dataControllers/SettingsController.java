package controllers.dataControllers;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Vector;
import models.DB;
import models.ModelSettings;

/**
 *
 * @author vic
 *
 * This class is intended to load the persistent obj modelSetting. Assumptions:
 *      1.the obj has been already created.
 *      2.the obj returned by the readObj() can be modified and reused
 */

public class SettingsController {

    private ModelSettings setting;

    public SettingsController(){}
    public SettingsController(int i){
        read();
    }

    private void read(){
        String fileName=DB.getSettingFileName();
        try{
            FileInputStream file=new FileInputStream(fileName);
            ObjectInputStream obj=new ObjectInputStream(file);
            setting=(ModelSettings) obj.readObject();
            obj.close();
        }
        catch(IOException io){
            System.out.println("Error in settingsController.read:"+io.getLocalizedMessage()
                    +".Posible cause:Error in reading the file.");
        }
         catch(ClassNotFoundException c){
            System.out.println("Error in settingsController.read:"+c.getLocalizedMessage()
                    +".Posible cause:the object has not been found.");
        }
    }

    private void write(){
        String fileName=DB.getSettingFileName();
        try{
            FileOutputStream file=new FileOutputStream(fileName);
            ObjectOutputStream obj=new ObjectOutputStream(file);
            obj.writeObject(setting);
            obj.close();
        }
        catch(IOException io){
            System.out.println("Error in settingsController.write:"+io.getLocalizedMessage()
                    +".Posible cause:Error in writting the file.");
        }
    }

    public void save(){
        write();
    }
    public void save(ModelSettings m){
        setting=m;
        write();
    }

    public ModelSettings getSetting(){
        return setting;
    }

    public static boolean isTaxedItem(Vector<Integer> v,int i){
        for(int j=0;j<v.size();j++){
            if(v.get(j).intValue()==i){
                return true;
            }
        }
        return false;
    }
}
