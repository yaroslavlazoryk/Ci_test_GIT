/**
 * Created by new on 27.06.2017.
 */

public with sharing class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext ctx){
        List<Lead> leads = [Select id from Lead where LeadSource = null LIMIT 200];
        for(Lead leadl : leads){
            leadl.LeadSource = 'Dreamforce';
        }
        upsert leads;
    }
}