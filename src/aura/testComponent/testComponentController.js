({
    selectRecord : function(component, event, helper) {
        var selectedAccountGetFromEvent = event.getParam("recordByEvent");
        component.set("v.selectedRecord", selectedAccountGetFromEvent);
        var lookup = component.find("lookupId");
        var selectedRecord = component.get('v.selectedRecord');
        lookup.selectRecord(selectedRecord);
    },

	hideLookupResultList : function(component, event, helper) {
        var lookupRes = component.find('lookupId');
        component.set('v.containerId', event.target.toString());
        var containerId = component.get('v.containerId');
        lookupRes.hideLookupResult(containerId);
	}

})