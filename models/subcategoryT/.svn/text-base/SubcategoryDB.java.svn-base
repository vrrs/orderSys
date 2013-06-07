
package models.subcategoryT;

import models.modelsDB;

public class SubcategoryDB implements modelsDB{
    private int id=0;
    private int categoryID=0;
    private String subName="";
    private String subDetail="";

    private String[] columns={"IDsubcategory","IDcategory","subcategory_name","subCategory_detail"};

     @Override
    public modelsDB me(){
        return this;
    }
     
    public SubcategoryDB(){}
    public SubcategoryDB(int nId,int nCategoryID,String nSubName,String nSubDetail){
        id=nId;
        categoryID=nCategoryID;
        subName=nSubName;
        subDetail=nSubDetail;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public String[] getColumns() {
        return columns;
    }

    @Override
    public int getId() {
        return id;
    }

    public String getSubDetail() {
        return subDetail;
    }

    public String getSubName() {
        return subName;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setSubDetail(String subDetail) {
        this.subDetail = subDetail;
    }

    public void setSubName(String subName) {
        this.subName = subName;
    }

    public void set(int column,String value){
        switch(column){
            case 0:id=Integer.parseInt(value);break;
            case 1:categoryID=Integer.parseInt(value);break;
            case 2:subName=value;break;
            default:subDetail=value;break;
        }
    }
    
}
