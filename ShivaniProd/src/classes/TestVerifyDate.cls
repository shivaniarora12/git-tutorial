@isTest
public class TestVerifyDate {
    
    public static testMethod void testDates(){
        
        Date dt1 = system.today();
        Date dt2 = dt1.addDays(20);
        Date dt3 = dt1.addDays(32);
        
        VerifyDate.CheckDates(dt1, dt2);
        VerifyDate.CheckDates(dt1,dt3);
    } 
    
}