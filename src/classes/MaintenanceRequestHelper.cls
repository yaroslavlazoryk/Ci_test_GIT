public class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(){
        // update workorders
    }
    public static void afterUpdate(List<Case> newCases){
        Set<Case> cases = getCases(newCases);
        System.debug(cases);
        System.debug('sum');
    }

    public static void afterInsert(List<Case> newCases){

    }

    private static Set<Case> getCases(List<Case> cases){
        List<Case> selectedCases = new List<Case>([
                SELECT Type
                        , Status
                        , ContactId
                        , Equipment__c
                FROM Case
        ]);
        Set<Case> casesToInsert = new Set<Case>();
        for (Case aCase : cases){
            if (aCase.Type == 'Repair' && aCase.Status == 'Closed'){
                casesToInsert.add(new Case(Type = 'Routine Maintenance'
                , Subject = 'blablabla'
                , ContactId = aCase.ContactId
                , Equipment__c = aCase.Equipment__c
                , Date_Reported__c = date.today()
                , Status = 'New'));
            }
        }
        return casesToInsert;
    }
}