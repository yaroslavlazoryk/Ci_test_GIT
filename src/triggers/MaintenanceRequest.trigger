/**
 * Created by new on 11.08.2017.
 */

trigger MaintenanceRequest on Case (after insert, after update) {
    if (Trigger.isAfter){
        if (Trigger.isUpdate){
            MaintenanceRequestHelper.afterUpdate(Trigger.new);
        }
    }
}