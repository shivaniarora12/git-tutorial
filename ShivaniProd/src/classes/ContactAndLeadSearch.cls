public class ContactAndLeadSearch {
    public static   List<List<sObject>> searchContactsAndLeads(String str){
        List<List<sObject>> searchList = [FIND :str IN ALL FIELDS 
                                          RETURNING Lead(FirstName,LastName),Contact(FirstName,LastName)];
        Lead[] searchLeads = (Lead[])searchList[0];
        Contact[] searchContacts = (Contact[])searchList[1];
      
        return searchList;
    }
    
}