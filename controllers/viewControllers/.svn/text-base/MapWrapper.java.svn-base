/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package controllers.viewControllers;

import java.util.HashMap;

/**
 *
 * @author vic
 */
public class MapWrapper {

    private HashMap<Integer,Object> catM=new HashMap<Integer,Object>();
    private HashMap<Integer,Integer>catE=new HashMap<Integer,Integer>();
    private HashMap<Integer,Object> subcatM=new HashMap<Integer,Object>();
    private HashMap<Integer,Integer> subcatE=new HashMap<Integer,Integer>();

    public MapWrapper() {
    }

    public HashMap<Integer, Integer> getCatE() {
        return catE;
    }

    public HashMap<Integer, Object> getCatM() {
        return catM;
    }

    public HashMap<Integer, Integer> getSubcatE() {
        return subcatE;
    }

    public HashMap<Integer, Object> getSubcatM() {
        return subcatM;
    }
    
    public void clear (){
        if(!catM.isEmpty()){
            catM.clear();
            catE.clear();
            subcatM.clear();
            subcatE.clear();
        }
    }
}
