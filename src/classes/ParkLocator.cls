/**
 * Created by new on 04.07.2017.
 */

public with sharing class ParkLocator {
    public static string[] country(String country) {
        
        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
        return park.byCountry(country);
    }
}