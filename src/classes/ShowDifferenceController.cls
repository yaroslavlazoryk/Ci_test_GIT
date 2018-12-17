/**
 * Created by new on 06.07.2017.
 */

public with sharing class ShowDifferenceController {
    public OwnFiledsComparator__c difference = new OwnFiledsComparator__c();
    public Double first{get;set;}
    public Double second{get;set;}
    public String reason{get;set;}
    public Boolean vis{get;set;}

    public ShowDifferenceController(){
        //difference = [SELECT first__c, second__c, reason__c From OwnFiledsComparator__c Limit 1];

    }
    //public
    public void getDif(){

        if (first != null && second != null){
            if(first> second){
                reason = 'first>second';
                vis = true;
            }
            else if(first < second){
                reason = 'first<second';
                vis = true;
            }
            else{
                reason = 'equal';
                vis = false;
            }
        }
        System.debug(vis);
        //return reason;
    }
    public void save(){
        System.debug(difference);
        difference.name = 'name';
        difference.first__c = first;
        difference.second__c = second;
        difference.reason__c = reason;
        upsert difference;
    }

}