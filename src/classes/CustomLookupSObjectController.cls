/*
* Developer: Vladimir Khryshchanovich <vladimir.hrishchanovich@succraft.com>
* Description: controller for custom LookupSObject lightning components.
*/
public with sharing class CustomLookupSObjectController
{

	@AuraEnabled
	public static LookupSObjectSearchResult[] searchSObjects(String searchString, String sObjectAPIName, String filterExpression) {

		searchString = String.escapeSingleQuotes(searchString);
		sObjectAPIName = String.escapeSingleQuotes(sObjectAPIName);
		//filterExpression = String.escapeSingleQuotes(filterExpression);

		
		String soql = 'SELECT Id, Name FROM ' + sObjectAPIName + ' WHERE Name Like \'%' + searchString + '%\'';
		if (!String.isBlank(filterExpression)) {
			soql += ' AND ' + prepareFilterExpression(filterExpression);
		}
		soql += ' LIMIT 5';
		List<sObject> searchList;

		try {
			searchList = Database.query(soql);
		} catch (Exception ex) {
			
		}

		List<LookupSObjectSearchResult> results = new List<LookupSObjectSearchResult>();

		for (SObject so : searchList) {
			results.add(new LookupSObjectSearchResult((String)so.get('Name'), so.Id));
		}
		return results;
	}

	@AuraEnabled
	public static LookupSObjectSearchResult[] searchSObjectsWithRecordTypes(String searchString, String sObjectAPIName, String sObjectRecordType, Boolean isExclude, String filterExpression) {

		searchString = String.escapeSingleQuotes(searchString);
		sObjectAPIName = String.escapeSingleQuotes(sObjectAPIName);
		sObjectRecordType = String.escapeSingleQuotes(sObjectRecordType);
		//filterExpression = String.escapeSingleQuotes(filterExpression);

		
		
		
		String soql = 'SELECT Id, Name FROM ' + sObjectAPIName + ' WHERE Name Like \'%' + searchString + '%\' ';

		soql += 'AND Recordtype.DeveloperName ';
		soql += isExclude ? 'NOT ' : '';
		soql += 'IN (\'' + sObjectRecordType + '\') ';
		if (!String.isBlank(filterExpression)) {
			soql += ' AND ' + prepareFilterExpression(filterExpression);
		}
		soql += ' LIMIT 5';

		List<sObject> searchList;

		try {
			searchList = Database.query(soql);
		} catch (Exception ex) {
			
		}
		List<LookupSObjectSearchResult> results = new List<LookupSObjectSearchResult>();

		for (SObject so : searchList) {
			results.add(new LookupSObjectSearchResult((String)so.get('Name'), so.Id));
		}
		return results;
	}

	@AuraEnabled
	public static LookupSObjectSearchResult[] getRecent(String sObjectAPIName, String filterExpression) {
		sObjectAPIName = String.escapeSingleQuotes(sObjectAPIName);
		//filterExpression = String.escapeSingleQuotes(filterExpression);

	
		String soqlRV = 'SELECT Id, Name, Type FROM RecentlyViewed WHERE Type = \'' + sObjectAPIName + '\'';
		soqlRV += ' LIMIT 100';
		System.debug(soqlRV);
		List<SObject> searchListRV = new List<SObject>();
		try {
			searchListRV = Database.query(soqlRV);
		} catch (Exception ex) {
			
		}
		Set<Id> recentIds = new Set<Id>();
		for (SObject sobj : searchListRV) {
			recentIds.add(sobj.Id);
		}
		String soql = 'SELECT Id, Name FROM ' + sObjectAPIName + ' WHERE Id IN: recentIds';
		if (!String.isBlank(filterExpression)) {
			soql += ' AND ' + prepareFilterExpression(filterExpression);
		}
		soql += ' LIMIT 5';
		List<SObject> searchList = new List<SObject>();
		try {
			searchList = Database.query(soql);
		} catch (Exception ex) {
			
		}
		List<LookupSObjectSearchResult> results = new List<LookupSObjectSearchResult>();
		for (SObject so : searchList) {
			results.add(new LookupSObjectSearchResult((String)so.get('Name'), so.Id));
		}
		return results;
	}

	@AuraEnabled
	public static LookupSObjectSearchResult[] getRelatedRecords(String sObjectAPIName, String relatedFieldAPIName, String relatedObjectId, String filterExpression) {
		sObjectAPIName = String.escapeSingleQuotes(sObjectAPIName);
		relatedObjectId = String.escapeSingleQuotes(relatedObjectId);
		relatedFieldAPIName = String.escapeSingleQuotes(relatedFieldAPIName);
		//filterExpression = String.escapeSingleQuotes(filterExpression);


		String soql = 'SELECT Id, Name FROM ' +sObjectAPIName + ' WHERE ' + relatedFieldAPIName + ' = \'' + relatedObjectId + '\'';
		if (!String.isBlank(filterExpression)) {
			soql += ' AND ' + prepareFilterExpression(filterExpression);
		}
		soql += ' LIMIT 5';
		List<SObject> searchList = new List<SObject>();
		try {
			searchList = Database.query(soql);
		} catch (Exception ex) {
		
		}
		List<LookupSObjectSearchResult> results = new List<LookupSObjectSearchResult>();
		for (SObject so : searchList) {
			results.add(new LookupSObjectSearchResult((String)so.get('Name'), so.Id));
		}
		return results;
	}

	@AuraEnabled
	public static LookupSObjectSearchResult[] getRelatedRecordsSearch(String searchString, String sObjectAPIName, String relatedFieldAPIName, String relatedObjectId, String filterExpression) {

		searchString = String.escapeSingleQuotes(searchString);
		sObjectAPIName = String.escapeSingleQuotes(sObjectAPIName);
		relatedObjectId = String.escapeSingleQuotes(relatedObjectId);
		relatedFieldAPIName = String.escapeSingleQuotes(relatedFieldAPIName);
		//filterExpression = String.escapeSingleQuotes(filterExpression);


		String soql = 'SELECT Id, Name FROM ' + sObjectAPIName + ' WHERE Name Like \'%' + searchString + '%\' AND ' + relatedFieldAPIName + ' = \'' + relatedObjectId + '\'';
		if (!String.isBlank(filterExpression)) {
			soql += ' AND ' + prepareFilterExpression(filterExpression);
		}
		soql += ' LIMIT 5';
		List<sObject> searchList;

		try {
			searchList = Database.query(soql);
		} catch (Exception ex) {
			
		}

		List<LookupSObjectSearchResult> results = new List<LookupSObjectSearchResult>();

		for (SObject so : searchList) {
			results.add(new LookupSObjectSearchResult((String)so.get('Name'), so.Id));
		}
		return results;
	}


	@AuraEnabled
	public static LookupSObjectSearchResult[] getRecentWithRecordTypes(String sObjectAPIName, String sObjectRecordType, Boolean isExclude, String filterExpression) {

		sObjectAPIName = String.escapeSingleQuotes(sObjectAPIName);
		sObjectRecordType = String.escapeSingleQuotes(sObjectRecordType);
		//filterExpression = String.escapeSingleQuotes(filterExpression);


		String soqlRV = 'SELECT Id, Name, Type FROM RecentlyViewed WHERE Type = \'' + sObjectAPIName + '\' ';
		soqlRV += 'AND Recordtype.DeveloperName ';
		soqlRV += isExclude ? 'NOT ' : '';
		soqlRV += 'IN (\'' + sObjectRecordType + '\')';
		soqlRV += ' LIMIT 100';
		List<SObject> searchListRV = new List<SObject>();
		try {
			searchListRV = Database.query(soqlRV);
		} catch (Exception ex) {
			
		}
		Set<Id> recentIds = new Set<Id>();
		for (SObject sobj : searchListRV) {
			recentIds.add(sobj.Id);
		}
		String soql = 'SELECT Id, Name FROM ' + sObjectAPIName + ' WHERE Id IN: recentIds';
		if (!String.isBlank(filterExpression)) {
			soql += ' AND ' + prepareFilterExpression(filterExpression);
		}
		soql += ' LIMIT 5';

		List<SObject> searchList = new List<SObject>();
		try {
			searchList = Database.query(soql);
		} catch (Exception ex) {
			
		}
		List<LookupSObjectSearchResult> results = new List<LookupSObjectSearchResult>();
		for (SObject so : searchList) {
			results.add(new LookupSObjectSearchResult((String)so.get('Name'), so.Id));
		}
		return results;
	}

	private static Id userId = UserInfo.getUserId();
	private static Id userProfileId = UserInfo.getProfileId();

	private static String prepareFilterExpression(String filterExpression) {
		return filterExpression
			.replaceAll('(?i)UserInfo.getUserId\\(\\)', 'userId')
			.replaceAll('(?i)UserInfo.getProfileId\\(\\)', 'userProfileId');
	}
}