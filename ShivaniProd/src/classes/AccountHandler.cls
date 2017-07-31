public class AccountHandler {
  
    public static Account insertNewAccount(String accName){
        Account acc = new Account();
        acc.Name = accName;
        try{
            insert acc;
            return acc;
        }catch(DMLException ex){
            system.debug('error: '+ex.getMessage());
            return null;
        }
        
    }

}