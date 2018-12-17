/**
 * Created by new on 21.06.2017.
 */

public with sharing class ContactSearch {
    public static List<Contact> searchForContacts(String LName, String MailingPostalCode) {
        List<Contact> listOfContacts = [SELECT Id,Name FROM Contact WHERE LastName = :LName AND MailingPostalCode = :MailingPostalCode];

        return listOfContacts;
    }

}