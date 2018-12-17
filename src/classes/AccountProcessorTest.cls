/**
 * Created by new on 27.06.2017.
 */

@IsTest
private class AccountProcessorTest {
    static testMethod void countContactsTest() {
        //List<Id> ids = new List<Id>{'0010Y00000VaoaO','0010Y00000ULOei'};
        Account testAcc= new Account();
        testAcc.Name = 'testName';
        insert testAcc;
        Contact cont = new Contact();
        cont.FirstName = 'contFirstName';
        cont.LastName = 'contLasName';
        cont.AccountId = testAcc.Id;

        List<id> ids = new List<Id>();
        ids.add(testAcc.Id);
        Test.startTest();
        AccountProcessor.countContacts(ids);
        Test.stopTest();
        Account acc= [SELECT Number_of_Contacts__c from Account where Id = :testAcc.Id Limit 1];
        System.assertEquals(1,Integer.valueOf( acc.Number_of_Contacts__c));
    }
}