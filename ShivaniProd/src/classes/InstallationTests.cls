/* 
 * This class can be safely deleted from your org. 
 * It was only used to ensure 100% test coverage
 * for the managed package installation.
 */

@IsTest
private class InstallationTests {
    static testmethod void testMaintenanceRequest() {
        Account acc = new Account();
        acc.Name = 'test acc';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'testConf';
        con.LastName = 'testConl';
        con.AccountId = acc.Id;
        insert con;
        
        Vehicle__c veh = new Vehicle__c();
        veh.Name = 'bus';
        insert veh;
        
        Product2 prod = new Product2();
        prod.Name = 'test prod1';
        prod.Cost__c = 100;
        prod.Maintenance_Cycle__c = 2;
        insert prod;
       
        Case cs1 = new Case();
        cs1.Subject = 'new case';
        cs1.Equipment__c = prod.Id;
        cs1.Product__c = prod.Id;
		cs1.Type = 'Repair';
    	cs1.Status = 'Closed';
        cs1.Vehicle__c = veh.Id;
        cs1.ContactId = con.Id;
        cs1.AccountId = acc.Id;
        insert cs1;
        
        Case cs2 = new Case();
        cs2.Subject = 'new case';
        cs2.Equipment__c = prod.Id;
        cs2.Product__c = prod.Id;
		cs2.Type = 'Repair';
    	cs2.Status = 'Closed';
        cs2.Vehicle__c = veh.Id;
        cs2.ContactId = con.Id;
        cs2.AccountId = acc.Id;
        insert cs2;
        
        cs2.Type = 'Repair';
    	cs2.Status = 'Closed';
        update cs2;
        
        Map<Id, Case> cases = new Map<Id, Case>([SELECT Id, Subject, Equipment__c, Product__c, Type, Status, Vehicle__c,
                                                 ContactId, AccountId, AssetId, Date_Reported__c
                                                 FROM Case
                                                ]);
        MaintenanceRequestHelper.updateWorkOrders(cases);
	 }
    
    static testmethod void testWarehouseSync() {
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }    
}