({
	myAction : function(component, event, helper) {
        console.log('check');
		  alert("You clicked: " + event.getSource().get("v.label"));
	}
})