/**
 * Created by new on 27.06.2017.
 */

@IsTest
private class LeadProcessorTest {
    @testSetup
    static void setup(){
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'LastName' + i, Company = 'Company' + i, Status = 'Closed'));
        }
        insert leads;
    }
    static testMethod void testBehavior() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        System.assertEquals(200, [Select count() from Lead where LeadSource = 'Dreamforce']);
    }
}