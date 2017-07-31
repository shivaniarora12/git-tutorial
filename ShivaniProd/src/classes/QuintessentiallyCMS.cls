/**
*  @who    Shivani Arora 
*  @when   10/07/2016
*  @what   CMS to send SMS to CEO number (+447448672163) from Twilio number (+441400414047) via Twilio REST API.
*/
global class QuintessentiallyCMS {
    
    public static String BASEURL = 'https://api.twilio.com/2010-04-01/Accounts/';
    public static String SMSREQ = '/Messages.json/';        
    
    public static Integer timeout = 100000;  // Set timeout
    public static Map<Id, String> leadSMS { get; set; }
    
    
    @Future (callout = true)
    public static void leadsNotifications(Set<Id> leadIds, String toNumber){
        leadSMS = new Map<Id, String>();
        List<Lead> leads = [SELECT Id, Name, Company, AnnualRevenue, Lead_SMS_Status__c
                            FROM Lead
                            WHERE Id IN :leadIds];
        
        //For each lead send SMS to CEO
        for(lead leadRec :leads)
            sendSMSNotification(leadRec, toNumber);
        
        //Save status of API response on lead in custom field 'Lead_SMS_Status__c'
        List<Lead> leadsToUpdate = new List<Lead>();
        for(Lead lead :leads){
            if(leadSMS.containsKey(lead.Id)){
                lead.Lead_SMS_Status__c = leadSMS.get(lead.Id);
                leadsToUpdate.add(lead);
            }
        }
        
        try{
            if(leadsToUpdate.size() > 0){
                update leadsToUpdate;
            }
        }catch(DMLException ex){
            system.debug('An error has occured whilst updating leads ' + ex.getMessage());
        }
    }
    
    /** * @What: Send SMS via Twilio API**/
    public static void sendSMSNotification(Lead lead, String toNumber){
        
        Twilio_Settings__c settings = Twilio_Settings__c.getInstance('TWLogin'); //Custom settings for Twilio credentials.
        
        String url = BASEURL +  settings.Username__c + SMSREQ; //end point
        
        String username = settings.Username__c;
        String password = settings.Password__c;
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' +
            EncodingUtil.base64Encode(headerValue);
        
        //Body
        String fromNumber = settings.FromNumber__c; //twilio number
        String smsText = 'A new lead has been created in the system. Lead Name: ' + lead.Name + ',Company Name: ' + lead.Company + ',Lead Annual Revenue: ' + lead.AnnualRevenue;
        String body =  'To='+EncodingUtil.urlEncode(toNumber, 'UTF-8') + 
            '&From='+EncodingUtil.urlEncode(fromNumber, 'UTF-8') + 
            '&Body='+EncodingUtil.urlEncode(smsText, 'UTF-8');
        
        //Headers
        Map<String, String> headerMap = new Map<String, String>();
        headerMap.put('Authorization', authorizationHeader);
        
        //Return JSON from the callout
        String response = TwilioCtrl.doCallout(
            url,
            'POST',
            body,
            timeout,
            headerMap
        );
        
        system.debug('SMS response ' + response);
        
        //handle Response and store sms status in custom field 'Lead_SMS_Status__c'
        try{
            JSONParser parser = JSON.createParser(response);
            SMSResponse resSMS = (SMSResponse)parser.readValueAs(SMSResponse.class);
            
            String errorMessage = '';
            if(resSMS.error_code == null)
                errorMessage = 'SMS has been queued/sent.';
            else
                errorMessage = resSMS.error_code + ' ' + resSMS.error_message;      
            leadSMS.put(lead.Id, errorMessage);
            
        }catch(Exception e){
            System.debug(e.getLineNumber() + ' - ' + e.getMessage());
        }
    }
    
    public class SMSResponse{       
        String error_code;
        String error_message;     
    }
}