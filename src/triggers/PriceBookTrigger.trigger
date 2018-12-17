/**
 * Created by new on 29.06.2017.
 */

trigger PriceBookTrigger on PriceBook__c (before insert, before update) {
    for (PriceBook__c pb : Trigger.new) {

        if(Trigger.isInsert){
            if (pb.Owner__c == null) {
                pb.Status__c = 'new';
            }
            else {
                pb.Status__c = 'sold';
            }
        }
        if (Trigger.old != null) {
            if(pb.Owner__c !=null) {
                if (Trigger.old.get(Trigger.old.size() - 1).Owner__c == null) {

                    pb.Status__c = 'sold';
                } else {
                    pb.Status__c = 'used';
                }
            }

        }

    }
}