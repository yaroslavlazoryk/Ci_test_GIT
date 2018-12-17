/**
 * Created by new on 27.06.2017.
 */

@IsTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testMethod void testBehavior() {
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            leads.add(new Lead(LastName = 'LastName' + i, Company = 'Company' + i, Status = 'Closed'));
        }
        insert leads;
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
    }
}