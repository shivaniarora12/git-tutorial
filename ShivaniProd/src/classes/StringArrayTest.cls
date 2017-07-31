public class StringArrayTest {
    public static List<string> generateStringArray(Integer len){
        List<String> arr = new List<String>();
        for(integer i=0; i<len; i++){
            arr.add('Test '+i);
        }
        
        return arr;
    }
}