public class BuyProductPageContrioller {
    
    private Product_Table__c product;
    public Boolean isBying{get; set;}
    
    
    public BuyProductPageContrioller (){
        
        String URLID = ApexPages.currentPage().getParameters().get('Id');
        
        product = [SELECT Name, Unit_Price__c, Units_Available__c FROM Product_Table__c WHERE Id = :URLID ];
        
        isBying = false;
    }
    
    public Product_Table__c getProduct(){
        return product;
    }
    
    public PageReference buyProduct (){ 
        
        String email = ApexPages.currentPage().getParameters().get('email');
        String firstName = ApexPages.currentPage().getParameters().get('firstName');
        String lastName = ApexPages.currentPage().getParameters().get('lastName');
        Integer unitCount = Integer.valueOf(ApexPages.currentPage().getParameters().get('unitCount'));  
        
        List<Contact> contacts = [SELECT FirstName, LastName FROM Contact WHERE Email = :email LIMIT 1];
        
        if(!contacts.isEmpty()){
            contacts[0].FirstName = firstName;
            contacts[0].LastName = lastName;
        }else{
            Contact cont = new Contact();
            cont.FirstName = firstName;
            cont.LastName = lastName;
            cont.Email = email;
            
            contacts.add(cont);
        }
        
        Order_Table__c orderTable = new Order_Table__c ( Product__c = product.Id, 
                                                         Units__c = unitCount,
                                                         Order_Amount__c = unitCount*product.Unit_Price__c);
        
        Decimal leftProducts = product.Units_Available__c - unitCount;
        
        if(leftProducts >= 0){
            
            upsert contacts;
            insert orderTable;
            
            product.Units_Available__c = leftProducts;
            update product;
            
            isBying = true;
        }else{
            isBying = false;
        }
        
        return null;
    }
    
    
}