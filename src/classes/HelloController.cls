/**
 * Created by new on 05.07.2017.
 */

public with sharing class HelloController {
    //private final Account account;
    public String name{get;set;}
    //private final Account acct;
    public List<Contact> contacts{get;set;}
    public String idishnik{get;set;}
    public HelloController(ApexPages.StandardSetController stdController){
        List<Account> accounts = (List<Account>)stdController.getRecords();
    }
   /* public void getId(){
        id = [SELECT Id From Account];
    }*/
    public PageReference getContacts(){
        System.debug(idishnik);
        contacts = [SELECT Id, Name From Contact where AccountId =:idishnik];
        return null;
    }
    List<Account> accounts;

   /* public List<Account> getAccounts() {
        /*if(accounts == null)*/
       /* accounts = [SELECT Name FROM Account WHERE Name LIKE 'u%'];
        return accounts;
    }*/




}