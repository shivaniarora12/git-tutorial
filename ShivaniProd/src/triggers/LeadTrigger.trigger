/**
*  @who    Shivani Arora 
*  @when   10/07/2016
*  @what   Trigger to send SMS to CEO when a new Lead is inserted.
*/
trigger LeadTrigger on Lead (after insert) {
    Double annualRevenue = 100000;
    if(trigger.isAfter){
        if(trigger.isInsert){
           
            Set<Id> leadIds = new Set<Id>();
            for(lead ld :trigger.new){
                if( ld.AnnualRevenue > annualRevenue ) //Check if annual revenue is > £100,000
                    leadIds.add(ld.Id);
            }
            
            if(leadIds.size() > 0){
                String numberCEO;
                User user = [SELECT Id, Name, Phone, MobilePhone FROM USER WHERE UserRole.Name = 'CEO' LIMIT 1]; 
                numberCEO = user.MobilePhone;
                QuintessentiallyCMS.leadsNotifications(leadIds, numberCEO); //Send lead ids to CMS to be able to send SMS to CEO via Twilio
            }
        }
    }
    
}