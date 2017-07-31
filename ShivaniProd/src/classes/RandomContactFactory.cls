public class RandomContactFactory {

    public static  List<Contact> generateRandomContacts(Integer ints, String str){
         List<Contact>  conts = new  List<Contact>();
        for ( Integer i = 0 ; i < ints ; i++ ) {
            Contact con = new Contact();
            con.FirstName  = 'Test'+Math.random();
            con.LastName = str;
           
            conts.add(con);
        }
        return conts;
    }
}