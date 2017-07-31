@isTest
public class MaintenanceRequestTest {

    static void testMaintenance(){
    	//Arrange
    	Vehicle__c veh = new Vehicle__c();
        veh.Name = 'bus';
        insert veh;
        
        Product2 prod = new Product2();
        prod.Name = 'test prod1';
        prod.Cost__c = 100;
        insert prod;
       
        Case cs = new Case();
        cs.Subject = 'new case';
        cs.Equipment__c = prod.Id;
        cs.Product__c = prod.Id;
        insert cs;
    	
        cs.Type = 'Repair';
    	cs.Status = 'Closed';
    	update cs;
    		
    }
}