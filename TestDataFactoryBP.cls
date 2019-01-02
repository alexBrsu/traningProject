@isTest
public class TestDataFactoryBP {
    
    public static List<Product_Table__c> createOrgData(){
        
        List<Product_Table__c> result = [SELECT Name, Unit_Price__c, Units_Available__c FROM Product_Table__c];
        
        return result;
    }
    
    public static PageReference getBuyProductPage(String email, String firstName, String lastName, String unitCount, Id URLID ){
        
        PageReference page = Page.BuyProductPage;
        
        page.getParameters().put('email', email);
        page.getParameters().put('firstName', firstName);
        page.getParameters().put('lastName', lastName);
        page.getParameters().put('unitCount', unitCount);
        page.getParameters().put('id', URLID);
        
        
        return page;
    }
}