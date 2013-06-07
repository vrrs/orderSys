package models;

import java.io.Serializable;
import java.util.Vector;

/**
 *
 * @author vic
 */

public class ModelSettings implements Serializable{

    private double taxrate;
    private final double DEFAULT_TAXRATE=0.07;

    //items IDs that have already taxes
    private Vector<Integer> taxedItems;

    //the constructor initialize each instance with their respective default values
    public ModelSettings(){
        taxrate=DEFAULT_TAXRATE;
        taxedItems=new Vector<Integer>();
    }

    public Vector<Integer> getTaxedItems() {
        return taxedItems;
    }

    public double getTaxrate() {
        return taxrate;
    }

    public void setTaxrate(double taxrate) {
        this.taxrate = taxrate;
    }
}
