/**
 * Created by new on 27.06.2017.
 */

@IsTest
private class AddPrimaryContactTest {

    static testMethod void testBehavior() {
        List<Account> accsNY = new List<Account>();
        List<Account> accsCA = new List<Account>();
        for (Integer i = 0; i < 50; i++){
            accsNY.add(new Account(Name = 'Name' + i, BillingState = 'NY'));
            accsCA.add(new Account(Name = 'Name' + i, BillingState = 'CA'));
        }
        insert accsNY;
        insert accsCA;
        Contact cont = new Contact();
        cont.FirstName = 'FirstName';
        cont.LastName = 'LastName';
        insert cont;
        String state = 'CA';
        AddPrimaryContact apc = new AddPrimaryContact(cont, state);
        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();
    }

}