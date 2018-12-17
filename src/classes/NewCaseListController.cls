/**
 * Created by new on 23.06.2017.
 */

public with sharing class NewCaseListController {
    public List<Case> getNewCases(){
        List<Case> casesResults = new List<Case>();
        casesResults = Database.query('Select Case.Id, Case.CaseNumber From Case Where Status = \'New\'');
        return casesResults;
    }

}