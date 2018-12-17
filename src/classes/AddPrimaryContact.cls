/**
 * Created by new on 27.06.2017.
 */

public with sharing class AddPrimaryContact implements Queueable{
    Contact cont = new Contact();
    String stateAbbreviation;
    public AddPrimaryContact(Contact cont, String stateAbbreviation)
    {
        this.cont = cont;
        this.stateAbbreviation = stateAbbreviation;
    }

    public void execute(QueueableContext context){
        List<Account> accs = [SELECT Name, Id From Account WHERE BillingState = :stateAbbreviation LIMIT 200];
        for(Account acc : accs){
            acc.Contacts.add(cont);
        }
        update accs;
    }
}