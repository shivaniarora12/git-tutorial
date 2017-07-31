@isTest
public class TestRestrictContactByName {
    
    public static testMethod void testcontrigger(){
        Contact con1 = new Contact(LastName = 'testcon');
        insert con1;
        
        try{
            Contact con2 = new Contact(LastName = 'INVALIDNAME');
            insert con2;
        }
        catch(Exception e) {
            System.Assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));
               }
        
    }
}