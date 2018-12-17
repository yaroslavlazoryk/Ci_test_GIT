/**
 * Created by new on 04.08.2017.
 */

public with sharing class AsyncExecutionExample implements Queueable{
    public void execute(QueueableContext context){
        Account a = new Account(Name = 'Acme', Phone = '(415) 555-1212');
        insert a;
      //  Id jobID = System.enqueueJob(new AsyncExecutionExample());
      //  AsyncApexJob jobInfo = [SELECT Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobID];
      //  System.debug(jobInfo);
    }
}