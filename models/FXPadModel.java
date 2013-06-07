/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package models;

import java.io.Serializable;
import java.util.Vector;

/**
 *
 * @author vic
 */
public class FXPadModel implements Serializable{
    private Vector<String> fileNames=new Vector<String>();
    private Vector<String> data=new Vector<String>();

    public FXPadModel(){ }
    
    public Vector<String> getData() {
        return data;
    }

    public void setData(Vector<String> data) {
        this.data = data;
    }

    public Vector<String> getFileNames() {
        return fileNames;
    }

    public void setFileNames(Vector<String> fileNames) {
        this.fileNames = fileNames;
    }
}
