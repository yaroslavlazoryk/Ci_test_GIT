/**
 * Created by new on 21.02.2018.
 */

public with sharing class CampingListController {
    @AuraEnabled
        public static List<Camping_Item__c> getItems() {
        // Perform isAccessible() checking first, then
        return [SELECT Id, Name, Quantity__c, 	Packed__c, 	Price__c,
                CreatedById, 	LastModifiedById, CreatedDate
        FROM Camping_Item__c];
    }

    @AuraEnabled
        public static Camping_Item__c saveItem(Camping_Item__c item) {
        // Perform isUpdatable() checking first, then
        insert item;
        return item;
    }
}