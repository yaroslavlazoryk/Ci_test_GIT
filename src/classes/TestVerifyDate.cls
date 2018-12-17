/**
 * Created by new on 22.06.2017.
 */

@IsTest
private class TestVerifyDate {

    @IsTest static void testCheckDates(){

        Date firstDay = Date.newInstance(2017,10,11);
        Date trueLastDay = Date.newInstance(2017,10,12);
        Date falseLastDay = Date.newInstance(2017,12,11);
       // Date res = VerifyDate.CheckDates(firstDay, lastDay);
        System.assertEquals(trueLastDay, VerifyDate.CheckDates(firstDay, trueLastDay));
        System.assertEquals(Date.newInstance(2017,10,31),VerifyDate.CheckDates(firstDay, falseLastDay));
       /* System.assertEquals('12.10.2017', v.CheckDates(Date.newInstance('11.10.2017'),Date.newInstance('12.10.2017')));
        System.assertEquals(false, DateWithin30Days('11.10.2017','11.9.2017'));
        System.assertEquals(false, DateWithin30Days('11.10.2017','11.12.2017'));
        System.assertEquals(true, DateWithin30Days('11.10.2017','12.10.2017'));
        System.assertEquals('31.10.2017', SetEndOfMonthDate('11.10.2017'));*/
    }

}