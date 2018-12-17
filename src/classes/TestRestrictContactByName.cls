/**
 * Created by new on 22.06.2017.
 */

@IsTest
private class TestRestrictContactByName {
    static testMethod void testBehavior() {
        Contact ct = new Contact(LastName = 'INVALIDNAME');
        //insert ct;
        Test.startTest();
        Database.UpsertResult result = Database.upsert(ct, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
    }
}