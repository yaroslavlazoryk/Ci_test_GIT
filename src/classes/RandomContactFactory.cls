/**
 * Created by new on 23.06.2017.
 */

public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String lastName){
        List<Contact> conts = new List<Contact>();
        for (Integer i = 0; i < numberOfContacts; i++) {
            Contact cont = new Contact(FirstName = 'Test' + i, LastName = lastName);
            conts.add(cont);
        }
        return conts;
    }
}