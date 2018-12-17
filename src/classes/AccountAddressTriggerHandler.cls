/**
 * Created by new on 12.07.2017.
 */

public with sharing class AccountAddressTriggerHandler {
    //public static String animalName ='';
    public static List<Contact> contactsList = new List<Contact>();
    //public static List<Account> accounts = new List<Account>();
    public static void beforeInsert(List<Account> newAccounts){
        createContact(newAccounts);
    }
    private static void createContact(List<Account> newAccounts){
        //String animalName = getAnimalName();
      //  accounts = newAccounts;
        Set<String> accs = new Set<String>();
        for (Account acc : newAccounts){
            accs.add(acc.Id);
        }
        getAnimalName(accs);
        System.debug('test');
       // System.debug(animalName);

       // upsert newAccounts;
    }
    @future(callout = true)
    private static void getAnimalName(Set<String> accounts){
        System.debug(accounts);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + 1);
        req.setMethod('GET');
        Map<String, Object> animal = new Map<String, Object>();
        HttpResponse res = http.send(req);
        System.debug(res.getStatusCode());
        if (res.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            animal = (Map<String, Object>) results.get('animal');
            String animalName = (String) animal.get('name');
            System.debug(animalName);
            System.debug(animalName + ' gg ');
            Contact c;

            //insert c;
            System.debug(c);
            // List<Account> thisAccs = new List<Account>(newAccounts);
            for (String acc : accounts){
                c = new Contact(LastName = animalName);
                System.debug(c);
                c.AccountId = acc;
                contactsList.add(c);
                // acc.Contacts.add(c);
            }
            insert contactsList;
        }
//        else{
//            getAnimalName();
//        }

    }
}