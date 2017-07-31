/**
*  @who    Shivani Arora 
*  @when   10/07/2016
*  @what   Test class for lead trigger.
*/
@isTest
private class Twilio_Test {
    private static testMethod void testCalloutWithStaticResources() {
        
        UserRole roleTest = [SELECT Id, Name FROM UserRole WHERE Name = 'CEO'];
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        User user = new User(
            LastName = 'testUser1',
            Phone = '+447448672163',
            MobilePhone = '+447448672163',
            UserRoleId = roleTest.Id,
            Username = 'testuse1r@gmail.com', 
            Email = 'testuser1@gmail.com', 
            Alias = 'tuser1', 
            EmailEncodingKey='UTF-8', 
            isActive = true, 
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US', 
            ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles'   
        );
        insert user;
        System.runAs(user){
            
            
            Twilio_Settings__c twSettings = new Twilio_Settings__c(
                Name = 'TWLogin',
                Username__c = 'username',
                Password__c = 'password',
                FromNumber__c = '+441400414047'
            );
            insert twSettings;
            
            Lead leadTest = new Lead();
            leadTest.LastName = 'testName';
            leadTest.Company = 'XYZ';
            leadTest.AnnualRevenue = 1100000;
            
            // Used StaticResourceCalloutMock built-in class to
            // specify fake response and include response body in a static resource.
            StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
            mock.setStaticResource('mockResponse');
            mock.setStatusCode(200);
            
            // Set the mock callout mode
            Test.setMock(HttpCalloutMock.class, mock);
            insert leadTest;  // trigger that performs the callout
            
            //Test if static resource does not exist
            Lead leadTest2 = new Lead();
            leadTest2.LastName = 'testName2';
            leadTest2.Company = 'XYZ';
            leadTest2.AnnualRevenue = 1100000;
            
            // Used StaticResourceCalloutMock built-in class to
            // specify fake response and include response body in a static resource.
            StaticResourceCalloutMock mock2 = new StaticResourceCalloutMock();
            mock2.setStaticResource('mockResponse2');
            mock2.setStatusCode(400);
            
            // Set the mock callout mode
            Test.setMock(HttpCalloutMock.class, mock2);
            insert leadTest2;  // trigger that performs the callout
        }
        
    }
    
}