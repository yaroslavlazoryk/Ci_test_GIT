/**
 * Created by new on 05.07.2017.
 */
@RestResource(urlMapping='/Account/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substringBetween('Accounts/', '/contacts');
        //Map<String, String> IdToName = new Map<String, String>();
        //List<Account> accountName = [SELECT Name From Account WHERE Id = :accountId Limit 1];
        Account result = [SELECT Id,Name, (SELECT Id, Name From Contacts) FROM Account WHERE Id = :accountId];
        return result;
    }
   /* @HttpGet
    global static Case getCaseById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String caseId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/')+1);
        Case result =  [SELECT CaseNumber,Subject,Status,Origin,Priority
        FROM Case
        WHERE Id = :caseId];
        return result;
    }*/
}