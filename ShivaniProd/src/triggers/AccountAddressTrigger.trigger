trigger AccountAddressTrigger on Account (before insert, before update) {

    if(trigger.isBefore){
        if(trigger.isInsert){
            for(account acc :trigger.new){
                if(acc.BillingPostalCode!= null && acc.Match_Billing_Address__c == true){
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
            }
        }
         else if(trigger.isUpdate){
            for(account acc :trigger.old){
                if(acc.BillingPostalCode!= null && acc.Match_Billing_Address__c == true){
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
            }
        }
    }
}