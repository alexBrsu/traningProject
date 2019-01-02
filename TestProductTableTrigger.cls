@isTest
public class TestProductTableTrigger { 
    
    @isTest 
    //Product with Added_Date
    //Warehouse NOT exist
    public static void testInsertProductWithDate(){
        
        Product_Table__c product = new Product_Table__c ( Name = 'NameTest', Added_Date__c = Date.newInstance(2018, 10, 10) );
        
        insert product;
        
        List<Warehouse__c> warehouses = [SELECT Period_Start__c, Period_End__c FROM Warehouse__c WHERE 
                                         Period_Start__c <= :product.Added_Date__c AND 
                                         Period_End__c >= :product.Added_Date__c ];
        
        Boolean isHaveWarehouse = false;
        
        // на начало теста Warehouses пустой, если сейчас он не пуст, то создался новый warehouse
        if ( !warehouses.isEmpty()){
            isHaveWarehouse = true;
        }
        
        System.assertEquals(true, isHaveWarehouse);
        
    }
    
    @isTest
    // Product witohut Added_Date
    // Warehouse exist
    public static void testInsertProductWITHOUTDate(){
        
        Warehouse__c newWarehouse = new Warehouse__c ( Name = 'NameWA',  Period_Start__c = Date.today(), Period_End__c = Date.today() +10 );
        
        insert newWarehouse;
        
        Product_Table__c product = new Product_Table__c ( Name = 'NameTest' );
        
        insert product;
        
        List<Warehouse__c> warehouses = [SELECT Name, Period_Start__c, Period_End__c FROM Warehouse__c WHERE 
                                         Period_Start__c <= :product.Added_Date__c AND 
                                         Period_End__c >= :product.Added_Date__c ];
        
        System.assertEquals(warehouses[0].Name, newWarehouse.Name);
        
    }
    
}