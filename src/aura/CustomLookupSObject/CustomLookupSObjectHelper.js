({
	doSearch : function(component) {
		component.set('v.showSpinner', true);
		var searchString = component.get('v.searchString');
		var inputElement = component.find('lookup');
		var lookupList = component.find('lookuplist');
		var lensString = component.find('lensString');
		var lookupAddNew = component.find('lookupAddNew');
		inputElement.set('v.errors', null);
		$A.util.removeClass(lookupList, 'hide');

		var sObjectAPIName = component.get('v.sObjectAPIName');
		var sObjectRecordType = component.get('v.sObjectRecordType');
		var relatedObjectId = component.get('v.relatedObjectId');
		var relatedFieldAPIName = component.get('v.relatedFieldAPIName');
		var filterExpression = component.get('v.filterExpression') || '';
		var isExclude = component.get('v.isExclude');

		component.set('v.matches', null);
		var action;
		if (typeof searchString === 'undefined' || searchString.length < 2) {
			$A.util.addClass(lensString, 'hide');
			if (!($A.util.isEmpty(relatedObjectId)) && !($A.util.isEmpty(relatedFieldAPIName))) {
				action = component.get('c.getRelatedRecords');
				action.setAbortable();
				action.setParams({
					sObjectAPIName: sObjectAPIName,
					relatedObjectId: relatedObjectId,
					relatedFieldAPIName: relatedFieldAPIName,
					filterExpression: filterExpression
				});
			}
			if (sObjectRecordType.length === 0 && ($A.util.isEmpty(relatedObjectId) || $A.util.isEmpty(relatedFieldAPIName))) {
				action = component.get('c.getRecent');
				action.setAbortable();
				action.setParams({
					sObjectAPIName : sObjectAPIName,
					filterExpression: filterExpression
				});
			} else if (sObjectRecordType.length >= 0 && ($A.util.isEmpty(relatedObjectId) || $A.util.isEmpty(relatedFieldAPIName))){
				action = component.get('c.getRecentWithRecordTypes');
				action.setAbortable();
				action.setParams({
					sObjectAPIName: sObjectAPIName,
					sObjectRecordType: sObjectRecordType,
					isExclude: isExclude,
					filterExpression: filterExpression
				});
			}
			action.setCallback(this, function(response) {
				var state = response.getState();
				if (component.isValid()) {
					if (state === 'SUCCESS') {
						var matches = response.getReturnValue();
						component.set('v.matches', matches);

					} else if (state === 'ERROR') {
						var errors = response.getError();

						if (errors && errors[0] && errors[0].message) {
							console.log($A.get('$Label.Tigris.Error') + errors[0].message);
						} else {
							console.log($A.get('$Label.Tigris.Unknown_error'));
						}
					}
					$A.util.removeClass(lookupAddNew, 'hide');
					component.set('v.showSpinner', false);
				}
			});

			$A.enqueueAction(action);
		} else {
			$A.util.removeClass(lensString, 'hide');
			if (!($A.util.isEmpty(relatedObjectId)) && !($A.util.isEmpty(relatedFieldAPIName))) {
				action = component.get('c.getRelatedRecordsSearch');
				action.setAbortable();
				action.setParams({
					searchString: searchString,
					sObjectAPIName: sObjectAPIName,
					relatedObjectId: relatedObjectId,
					relatedFieldAPIName: relatedFieldAPIName,
					filterExpression: filterExpression
				});
			}
			if (sObjectRecordType.length === 0 && ($A.util.isEmpty(relatedObjectId) || $A.util.isEmpty(relatedFieldAPIName))) {
				action = component.get('c.searchSObjects');
				action.setAbortable();
				action.setParams({
					searchString: searchString,
					sObjectAPIName: sObjectAPIName,
					filterExpression: filterExpression
				});
			} else if (sObjectRecordType.length > 0 && ($A.util.isEmpty(relatedObjectId) || $A.util.isEmpty(relatedFieldAPIName))) {
				action = component.get('c.searchSObjectsWithRecordTypes');
				action.setAbortable();
				action.setParams({
					searchString: searchString,
					sObjectAPIName: sObjectAPIName,
					sObjectRecordType: sObjectRecordType,
					isExclude: isExclude,
					filterExpression: filterExpression
				});
			}
			action.setCallback(this, function(response) {
				var state = response.getState();
				if (component.isValid()) {
					if (state === 'SUCCESS') {
						var matches = response.getReturnValue();
						if (matches.length === 0) {
							component.set('v.matches', null);
							component.set('v.showSpinner', false);
							return;
						}
						component.set('v.matches', matches);
					} else if (state === 'ERROR') {
						var errors = response.getError();
						if (errors) {
							if (errors[0] && errors[0].message) {
								console.log($A.get('$Label.Tigris.Error') + errors[0].message);
							}
						} else {
							console.log($A.get('$Label.Tigris.Unknown_error'));
						}
					}
					$A.util.removeClass(lookupAddNew, 'hide');
					component.set('v.showSpinner', false);
				}
			});
			$A.enqueueAction(action);
		}
	},

	handleSelection : function(component, event) {
		this.manageLookupVisibility(component);
		var objectId = this.resolveId(event.currentTarget.id);
		var objectLabel = event.currentTarget.innerText.trim();
		var instanceId = component.get('v.instanceId');
		var updateEvent = component.getEvent('updateLookupIdEvent');
		updateEvent.setParams({
			sObjectId: objectId,
			instanceId: instanceId,
			name: objectLabel
		});
		component.set('v.searchString', objectLabel);
		updateEvent.fire();
	},

	createNewRecord : function(component, event) {
		var instanceId = component.get('v.instanceId');
		var createEvent = component.getEvent('createNewRecordForLookupIdEvent');
		createEvent.setParams({
			instanceId: instanceId
		});
		createEvent.fire();
		this.closeInput(component);
	},

	populateLookup : function(component, event) {
		var idFromEvent = event.getParam('sObjectId');
		var nameFromEvent = event.getParam('sObjectName');
		var instanceIdFromEvent = event.getParam('instanceId');
		var instanceId = component.get('v.instanceId');
		if (instanceIdFromEvent === instanceId) {
			this.manageLookupVisibility(component);
			var updateEvent = component.getEvent('updateLookupIdEvent');
			updateEvent.setParams({
				sObjectId: idFromEvent,
				instanceId: instanceId
			});
			component.set('v.searchString', nameFromEvent);
			updateEvent.fire();
		} else {
			//console.log('Unknown instance id: ' + instanceIdFromEvent);
		}
	},

	clearSelectionOutside : function(component, event) {

		var instanceIdFromEvent = event.getParam('instanceId');
		var instanceId = component.get('v.instanceId');

		if (instanceIdFromEvent === instanceId) {
			component.set('v.searchString', '');
			var lookupPill = component.find('lookup-pill');
			$A.util.addClass(lookupPill, 'hide');
			var lookup = component.find('lookup');
			$A.util.removeClass(lookup, 'hide');
			var searchIcon = component.find('searchIcon');
			$A.util.removeClass(searchIcon, 'hide');
			var lookupDiv = component.find('lookup-div');
			$A.util.removeClass(lookupDiv, 'hide');
		} else {
			//console.log('Unknown instance id: ' + instanceIdFromEvent);
		}
	},

	clearSelection : function(component) {
		var clearEvent = component.getEvent('clearLookupIdEvent');
		var instanceId = component.get('v.instanceId');
		clearEvent.setParams({
			instanceId: instanceId
		});
		clearEvent.fire();
		component.set('v.searchString', '');
		var lookupPill = component.find('lookup-pill');
		$A.util.addClass(lookupPill, 'hide');
		var lookup = component.find('lookup');
		$A.util.removeClass(lookup, 'hide');
		var searchIcon = component.find('searchIcon');
		$A.util.removeClass(searchIcon, 'hide');
		var lookupDiv = component.find('lookup-div');
		$A.util.removeClass(lookupDiv, 'hide');

	},

	manageLookupVisibility : function(component) {
		var lookupList = component.find('lookuplist');
		$A.util.addClass(lookupList, 'hide');
		var lookupAddNew = component.find('lookupAddNew');
		$A.util.addClass(lookupAddNew, 'hide');
		var lookup = component.find('lookup');
		$A.util.addClass(lookup, 'hide');
		var searchIcon = component.find('searchIcon');
		$A.util.addClass(searchIcon, 'hide');
		var lookupPill = component.find('lookup-pill');
		$A.util.removeClass(lookupPill, 'hide');
	},

	closeInput : function(component, event) {
		var lookupList = component.find('lookuplist');
		$A.util.addClass(lookupList, 'hide');

		var lookupAddNew = component.find('lookupAddNew');
		$A.util.addClass(lookupAddNew, 'hide');
	},

	resolveId : function(elmId) {
		var i = elmId.lastIndexOf('_');
		return elmId.substr(i + 1);
	},

})