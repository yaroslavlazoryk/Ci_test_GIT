/**
 * Created by new on 22.06.2017.
 */

public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String incomeString){
        List<List<SObject>> listsAndContacts = [FIND :incomeString IN ALL FIELDS RETURNING Lead(FirstName, LastName), Contact(FirstName,LastName)];
        return listsAndContacts;
    }
}