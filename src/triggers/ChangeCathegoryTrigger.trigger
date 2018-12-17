/**
 * Created by new on 29.06.2017.
 */

trigger ChangeCathegoryTrigger on MyCar__c (before insert, before update) {
    for (MyCar__c car : Trigger.new) {
        if (car.Speed__c < 150){
            car.Cathegory__c = 'truck';
        }
        else if(car.Speed__c > 250){
            car.Cathegory__c = 'sport';
        }
        else{
            car.Cathegory__c = 'passenger';
        }
    }

}