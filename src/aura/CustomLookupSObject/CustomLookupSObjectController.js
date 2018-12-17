({
	search : function(component, event, helper) {
		helper.doSearch(component);
	},

	create : function(component, event, helper) {
		helper.createNewRecord(component);
	},

	select : function(component, event, helper) {
		helper.handleSelection(component, event);
	},

	clear : function(component, event, helper) {
		helper.clearSelection(component);
	},

	close : function(component, event, helper) {
		helper.closeInput(component, event);
	},

	clearOutside : function(component, event, helper) {
		helper.clearSelectionOutside(component, event);
	},

	mouseIn : function(component, event, helper) {
		component.set('v.isMouseIn', true);
	},

	mouseOut : function(component, event, helper) {
		component.set('v.isMouseIn', false);
	},

	blurHandle : function(component, event, helper) {
		const isMouseIn = component.get('v.isMouseIn');

		if (isMouseIn) {
			component.set('v.isActiveDiv', true);
			return;
		} else {
			component.set('v.isActiveDiv' , false);
			window.setTimeout (
				$A.getCallback(function() {
					if (component.isValid()) {
						if (component.get('v.isActiveDiv') === false) {
							helper.closeInput(component, event);
						}
					}
				}), 100
			);
			return;
		}
	},

	focusHandle : function(component, event, helper) {
		component.set('v.isActiveDiv', true);
	},

	populate : function(component, event, helper) {
		helper.populateLookup(component, event)
	},

	handleError : function(component, event, helper) {
		var instanceIdFromEvent = event.getParam('instanceId');
		var instanceId = component.get('v.instanceId');
		if (instanceIdFromEvent === instanceId) {
			$A.util.addClass(component.find('lookup'), 'errors');
		}
	},

})