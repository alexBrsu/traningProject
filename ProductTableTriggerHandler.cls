public with sharing class ProductTableTriggerHandler {
    
    public static void handleBeforeInsert( List<Product_Table__c> products ){
        
        List<Warehouse__c> warehousesInsert = new List<Warehouse__c>();
        List<Warehouse__c> warehousesDatabase = [SELECT Period_Start__c, Period_End__c FROM Warehouse__c];
        
        Boolean itHaveWarehouse;
        
        Warehouse__c newWarehouse;
        
        OrgConfiguration__c orgConf = new OrgConfiguration__c( Period_Term__c = 100 );
        
        Decimal PeriodTermDecimal = orgConf.Period_Term__c;
        Integer PeriodTerm = Integer.valueOf(PeriodTermDecimal);
        
        for( Product_Table__c product : products ){
            
            itHaveWarehouse = false;
            
            if ( product.Added_Date__c == null ){
                product.Added_Date__c = Date.today();
            }
            
            for ( Warehouse__c warehouse : warehousesDatabase ){
                
                if ( product.Added_Date__c >= warehouse.Period_Start__c && product.Added_Date__c <= warehouse.Period_End__c ){
                    
                    product.Warehouse__c = warehouse.Id;
                    itHaveWarehouse = true;
                    
                    break;
                }
                
            }
            
            if ( !itHaveWarehouse ){
                newWarehouse = new Warehouse__c ( Name = 'Warehouse '+product.Added_Date__c+', '+PeriodTerm,
                                                 Period_Start__c = product.Added_Date__c,
                                                 Period_End__c = product.Added_Date__c + PeriodTerm);
                
                warehousesInsert.add(newWarehouse);
                //product.Warehouse__c = newWarehouse.Id;
				//itHaveWarehouse = true;                
            }
            
        }
        
        insert warehousesInsert;
        
        // Второй раз прохожу по продуктам, потому что выше в первом блоке закомментированный код не работает.
        // Подходящий склад уже создан. Мы его просто присваиваем к продукту без склада.
        for ( Product_Table__c product : products ){
            if ( product.Warehouse__c == null ){
                for ( Warehouse__c warehouse : warehousesInsert ){
                    
                    if ( product.Added_Date__c >= warehouse.Period_Start__c && product.Added_Date__c <= warehouse.Period_End__c ){
                        
                        product.Warehouse__c = warehouse.Id;
                        itHaveWarehouse = true;
                        
                        break;
                    }      
                }   
            }
        }
        
        
    }
    
}