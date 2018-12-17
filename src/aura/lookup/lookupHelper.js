({
    searchHelper : function(component,event,getInputkeyWord) {
    component.set("v.Message", '');
    var action = component.get("c.fetchLookUpValues");
    action.setParams({
        'searchKeyWord': getInputkeyWord,
        'ObjectName' : component.get("v.objectAPIName")
    });
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {

            var storeResponse = response.getReturnValue();
            if (storeResponse.length == 0) {
                component.set("v.Message", 'No Result Found...');
            } else {
                component.set("v.Message", '');
            }
        component.set("v.listOfSearchRecords", storeResponse);
        }
    });
    $A.enqueueAction(action);
    },

    showPill : function(component, event) {
        var pill = component.find("lookup-pill");
        $A.util.addClass(pill, 'slds-show');
        $A.util.removeClass(pill, 'slds-hide');
        var container = component.find("lookupDropdownContainer");
        $A.util.addClass(container, 'slds-hide');
        $A.util.removeClass(container, 'slds-show');
    },

    hidePill : function(component, event) {
        var pill = component.find("lookup-pill");
        $A.util.addClass(pill, 'slds-hide');
        $A.util.removeClass(pill, 'slds-show');
        var container = component.find("lookupDropdownContainer");
        $A.util.addClass(container, 'slds-show');
        $A.util.removeClass(container, 'slds-hide');
    },

    showResultList : function(component, event) {
        var container = component.find("lookupDropdownContainer");
        $A.util.addClass(container, "slds-has-input-focus");
        var dropdown = component.find("lookupDropdown");
        $A.util.removeClass(dropdown, "slds-combobox-lookup");
        $A.util.addClass(dropdown, "slds-is-open");
        document.getElementById("combobox").setAttribute("aria-expanded", true);
    },

    hideResultList : function(component, event) {
        var container = component.find("lookupDropdownContainer");
        $A.util.removeClass(container, "slds-has-input-focus");
        var dropdown = component.find("lookupDropdown");
        $A.util.addClass(dropdown, "slds-combobox-lookup");
        $A.util.removeClass(dropdown, "slds-is-open");
        document.getElementById("combobox").setAttribute("aria-expanded", false);
    }
})