@isTest
public class ShowProductListTest {
    
    @isTest
    public static void getProductTest(){
        
        TestDataFactoryBP.createOrgData();
        
        List<Product_Table__c> products = new List<Product_Table__c>();
        
        Product_Table__c prod = new Product_Table__c();
        
        for (Integer i=0; i<10; i++){
            prod.Name = 'name'+i;
            products.add(prod);
            prod = new Product_Table__c();
        }

        insert products;
        
        PageReference ref = Page.ShowProductList;
        
        Test.setCurrentPage(ref);
        
        ProductListController control = new ProductListController();
        
        System.assertEquals(products, control.getProducts());
    }
    

}