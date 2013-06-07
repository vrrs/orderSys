
package models.categoryT;

import models.modelsDB;

public class CategoryDB implements modelsDB{
    private int id=0;
    private String cName="";
    private String detail="";
    private String[] columns={"IDcategory","category_name","category_detail"};

    public CategoryDB(){}

    @Override
    public modelsDB me(){
        return this;
    }
    public CategoryDB(int nId,String nCName,String nDetail){
        id=nId;
        cName=nCName;
        detail=nDetail;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    @Override
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String[] getColumns() {
        return columns;
    }


}
