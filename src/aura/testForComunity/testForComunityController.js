/**
 * Created by new on 26.01.2018.
 */
({
myAction : function(component, event, helper) {
        console.log('check');
		  alert("You clicked: " + event.getSource().get("v.label"));
        window.location.replace("https://slavislove-dev-ed.lightning.force.com/servlet/networks/switch?startURL=%2Fsecur%2Flogout.jsp");

	},
          handleClick : function (cmp, event, helper) {
            alert("You clicked: " + event.getSource().get("v.label"));
        },
    fillLicense : function(component, event, helper) {
        component.set("v.License", component.find("LicenseId").get("v.value"));
        console.log(component.get("v.License"));
        console.log(component.find("LicenseId").get("v.value"));

          // create a one-time use instance of the serverEcho action
                // in the server-side controller
                var action = component.get("c.serverEcho");


                // Create a callback that is executed after
                // the server-side action returns
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        // Alert the user with the value returned
                        // from the server
                        alert("From server: " + response.getReturnValue());

                        // You would typically fire a event here to trigger
                        // client-side notification that the server-side
                        // action is complete
                    }
                    else if (state === "INCOMPLETE") {
                        // do something
                        alert("From server: " + response.getReturnValue());
                    }
                    else if (state === "ERROR") {
                        var errors = response.getError();
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                console.log("Error message: " +
                                         errors[0].message);
                            }
                        } else {
                            console.log("Unknown error");
                        }
                        alert("From server: " + response.getReturnValue());
                    }
                });

                // optionally set storable, abortable, background flag here

                // A client-side action could cause multiple events,
                // which could trigger other events and
                // other server-side action calls.
                // $A.enqueueAction adds the server-side action to the queue.
                $A.enqueueAction(action);
    },

})