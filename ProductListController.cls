public class ProductListController {
    
    private List<Product_Table__c> prodTable;
    
    public ProductListController(){
        
        prodTable = Database.query('SELECT Image_Url__c, Name,Product_Description__c, Unit_Price__c   FROM Product_Table__c ');
    }
    
    public List<Product_Table__c> getProducts(){

        return prodTable;
    }
    

    
}