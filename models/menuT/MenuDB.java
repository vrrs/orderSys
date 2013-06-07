package models.menuT;

import java.io.Serializable;
import models.modelsDB;

public class MenuDB implements modelsDB,Serializable{
    private int id=0;
    private int subCaID=0;
    private String product="";
    private String productDetail="";
    private double price=0;

    private String[] columns={"IDmenu","IDsubcategory","product_name","product_detail","price"};

    @Override
    public modelsDB me(){
        return this;
    }

    public MenuDB(){}
    public MenuDB(int nId,int nSubI,String nproduct,String ndetail,double nPrice){
        id=nId;
        subCaID=nSubI;
        product=nproduct;
        productDetail=ndetail;
        price=nPrice;
    }

    public String[] getColumns() {
        return columns;
    }

    @Override
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(String productDetail) {
        this.productDetail = productDetail;
    }

    public int getSubCaID() {
        return subCaID;
    }

    public void setSubCaID(int subCaID) {
        this.subCaID = subCaID;
    }

    public void set(int column,String value){
        switch(column){
            case 0:id=Integer.parseInt(value);break;
            case 1:subCaID=Integer.parseInt(value);break;
            case 2:product=value;break;
            case 3:productDetail=value;break;
            default:price=Double.parseDouble(value);
        }
    }


}
