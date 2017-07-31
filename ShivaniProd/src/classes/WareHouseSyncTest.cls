@isTest
private class WareHouseSyncTest {

   // CRON expression: midnight on March 15.
   // Because this is a test, job executes
   // immediately after Test.stopTest().
   public static String CRON_EXP = '0 0 0 15 3 ? 2022';

   static testmethod void test() {
      Test.startTest();

      // Schedule the test job
      String jobId = System.schedule('WarehouseSyncSchedule',
                        CRON_EXP, 
                        new WarehouseSyncSchedule());
         
    

   }
}