@isTest
public class BuyProductPageControllerTest {
    
    @isTest
    public static void getProductTest(){
        
        TestDataFactoryBP.createOrgData();
        
        Product_Table__c product = new Product_Table__c();
        product.Name = 'example';
        insert product;
        
        PageReference ref = Page.BuyProductPage;
        
        ref.getParameters().put('id', product.id);
        
        Test.setCurrentPage(ref);
        
        BuyProductPageContrioller control = new BuyProductPageContrioller();
        
        System.assertEquals(product, control.getProduct());
    }
    
    @isTest
    public static void SuccessfulByingTest(){
        
        TestDataFactoryBP.createOrgData();        
        
        Product_Table__c product = new Product_Table__c(); 
        product.Units_Available__c = 333; 
        product.Unit_Price__c = 1000;
        insert product; 
        
        PageReference ref = TestDataFactoryBP.getBuyProductPage('lalal@lala.la', 
                                                                  'FirstName', 
                                                                  'LastName', 
                                                                  '33', 
                                                                  product.Id);
        
        Test.setCurrentPage(ref);
        
        BuyProductPageContrioller controllerBuy = new BuyProductPageContrioller();

        controllerBuy.buyProduct();

        System.assertEquals(true, controllerBuy.isBying);
        
        //testing update 
		BuyProductPageContrioller controllerBuyUpdate = new BuyProductPageContrioller();

        controllerBuyUpdate.buyProduct();
        System.assertEquals(true, controllerBuyUpdate.isBying);
        
    }
    
    // unitCount > Units_Available__c ; 
    @isTest
    public static void UNsuccessfulByingTest(){
        
        TestDataFactoryBP.createOrgData();        
        
        Product_Table__c product = new Product_Table__c(); 
        product.Units_Available__c = 2; 
        product.Unit_Price__c = 1000;
        insert product; 
        
        PageReference ref = TestDataFactoryBP.getBuyProductPage('lalal@lala.la', 
                                                                  'FirstName', 
                                                                  'LastName', 
                                                                  '30', 
                                                                  product.Id);
        
        Test.setCurrentPage(ref);
        
        BuyProductPageContrioller controllerBuy = new BuyProductPageContrioller();

        controllerBuy.buyProduct();


        System.assertEquals(false, controllerBuy.isBying);

    }

}