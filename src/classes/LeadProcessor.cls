/**
 * Created by new on 27.06.2017.
 */

global class LeadProcessor implements
                Database.Batchable<sObject>, Database.Stateful{
    global Integer ghjghgj = 0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
                'SELECT LastName, Company, Status, LeadSource FROM Lead'
        );
    }
    global void execute(Database.BatchableContext bc, List<Lead> scopes)
    {
        List<Lead> leads = new List<Lead>();
        For(Lead leadScope : scopes){
            //if (leadScope.LeadSource == 'Dreamforce'){
            leadScope.LeadSource = 'Dreamforce';
            leads.add(leadScope);

            //}
        }
        update leads;
    }
    global void finish(Database.BatchableContext bc){

    }
}