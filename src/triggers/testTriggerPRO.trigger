trigger testTriggerPRO on Task (after insert, after update, after delete) {
    
    system.debug('ggg ');
 List<id> accIdList = new List<id>();
    if(Trigger.isInsert || Trigger.isUpdate){
        For(Task con1 : Trigger.new){
            accIdList.add(con1.WhatId);
        }
    }
	if(Trigger.isDelete){
        For(Task con1 : Trigger.old){
            accIdList.add(con1.WhatId);
        }
    }
    List<Account> accUpdateList = new List<Account>();
    For(Account acc : [SELECT numberOfTasks__c,(SELECT id FROM Tasks) FROM Account WHERE id =: accIdList]){
        acc.numberOfTasks__c = acc.Tasks.size();
        accUpdateList.add(acc);
    }
    try{
        update accUpdateList;
    }Catch(Exception e){
        System.debug('Exception :'+e.getMessage());
    }
}