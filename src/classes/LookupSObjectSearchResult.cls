/*
 * Developer: Vladimir Khryshchanovich <vladimir.hrishchanovich@succraft.com>
 * Description: class to wrap up an SObject Label and its Id for LookupSObjectController.
 */
public with sharing class LookupSObjectSearchResult 
{
	@AuraEnabled public String SObjectLabel {get; set;}
	@AuraEnabled public Id SObjectId {get; set;}
		
	public LookupSObjectSearchResult(String sObjectLabel, Id sObjectId)
	{
		this.SObjectLabel = sObjectLabel;
		this.SObjectId = sObjectId;
	}
}