/**
*  @who    Shivani Arora 
*  @when   10/07/2016
*  @what   Controller to make callouts to Twilio API.
*/
public class TwilioCtrl {
    
    public static String doCallout(String url, String method, String body, Integer callTimeout, Map<String, String> headerMap){
        try {
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod(method);
            req.setTimeout(callTimeout);
            
            // Set request body if present
            if(body != null)
                req.setBody(body);
            
            // If headerMap is not empty
            if(headerMap != null && headerMap.size() > 0){
                // Iterate through headerMap
                for(String s : headerMap.keySet()){
                    // Set request headers
                    if(s != null && headerMap.get(s) != null)
                        req.setHeader(s, headerMap.get(s));
                }
            }
            
            // Send response
            HttpResponse res = new HttpResponse();
            res = h.send(req);
            
            // Return the response body to the mehtod that made the call
            if(res.getStatusCode() == 200){
                return res.getBody();
            }
            return res.getBody();
            
        } catch(Exception e){
            System.debug(e.getLineNumber() + ' - ' + e.getMessage());
            return JSON.serialize(new Error(
                true,
                e.getLineNumber() + ' - ' + e.getMessage()
            ));
        }
    }
    
    public class Error {
        public Boolean isError;
        public String error;
        public Error(Boolean isError, String error){
            this.isError = isError;
            this.error = error;
        }
    }
}