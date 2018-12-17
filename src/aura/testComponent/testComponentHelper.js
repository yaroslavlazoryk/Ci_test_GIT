({
	helperMethod : function(component, event) {
		var lookupRes= component.find("lookup");
        console.log(lookupRes);
        lookupRes.hideLookupResult();
	}
})