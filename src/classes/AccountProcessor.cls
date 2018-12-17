/**
 * Created by new on 27.06.2017.
 */

public with sharing class AccountProcessor {
    @future
    public static void countContacts(List<Id> idList){

        List<Account> accountsList = new List<Account>();
        accountsList = [SELECT Id, Number_of_Contacts__c,(SELECT id from Contacts) FROM Account WHERE Id IN :idList];

        for(Account acc : accountsList){

            List<Contact> contacts = new List<Contact>();
            acc.Number_of_Contacts__c = contacts.size();

        }
        update accountsList;
    }
}