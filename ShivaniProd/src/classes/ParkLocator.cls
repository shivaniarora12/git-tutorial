public class ParkLocator {

   public static List<String> country(String loc) {
                 ParkService.ParksImplPort park = new ParkService.ParksImplPort();
                return park.byCountry(loc);
   }
}