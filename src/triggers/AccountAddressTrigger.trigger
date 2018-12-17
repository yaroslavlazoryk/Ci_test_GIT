/**
 * Created by new on 22.06.2017.
 */

trigger AccountAddressTrigger on Account (after insert) {
//    for(Account a : Trigger.new)
//    {
//        //if (a.Match)
//        if (a.BillingPostalCode != null && a.Match_Billing_Address__c){
//            //System.debug(a.BillingPostalCode IN null && a.Match_Billing_Address__c == true);
//            a.ShippingPostalCode = a.BillingPostalCode;
//        }
//
//    }
    if (Trigger.isAfter){
        if (Trigger.isInsert){
            AccountAddressTriggerHandler.beforeInsert(Trigger.new);
        }
    }
}