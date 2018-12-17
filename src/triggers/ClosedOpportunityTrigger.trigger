/**
 * Created by new on 22.06.2017.
 */

trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
    //Task t = [SELECT Id FROM Task where Subject = 'Follow Up Test Task'];
    List<Task> tasks = new List<Task>();
    for (Opportunity o : Trigger.new){
        if(o.StageName == 'Closed Won'){
            //Task ta = new Task(Ob)
            Task t = new Task(Subject = 'Follow Up Test Task', WhatId = o.Id);
            tasks.add(t);
            //o.Tasks.add(t);
           // o.Discount_Percent__c = 1;

        }
    }
    insert tasks;
}