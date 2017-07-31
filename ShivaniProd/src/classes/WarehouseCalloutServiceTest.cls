@isTest
private class WarehouseCalloutServiceTest {
 // implement your mock callout test here
    testMethod Static void test(){
      
        List<Product2> listProduct = new List<Product2>();
        Product2 p = new Product2();
        p.Replacement_Part__c = true;
        p.Name = 'testing';
        p.Cost__c = 10;
        p.Current_Inventory__c = 5;
        p.Lifespan_Months__c = 2;
        p.Maintenance_Cycle__c = 60;
        p.Warehouse_SKU__c = '10001';
        listProduct.add(p);
        insert listProduct;

        //Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        WarehouseCalloutService.runWarehouseEquipmentSync();
        
       
    }
}