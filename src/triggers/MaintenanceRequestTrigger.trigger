/**
 * Created by new on 11.08.2017.
 */

trigger MaintenanceRequestTrigger on Case (after insert, after update) {
    if (Trigger.isAfter){
        if (Trigger.isUpdate){
            MaintenanceRequestHelper.afterUpdate(Trigger.new);
        }
    }
}