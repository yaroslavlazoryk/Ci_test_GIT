/**
 * Created by new on 25.09.2017.
 */
({
    doInit: function(component, event, helper) {
        var values = "a b c d e".split(' ');
        component.set("v.values", values);
    },
    dragstart: function(component, event, helper) {
        component.set("v.dragid", event.target.dataset.dragId);
    },
    drop: function(component, event, helper) {
        console.log("drop");
        var dragId = component.get("v.dragid"),
            values = component.get("v.values"),
            temp;
        temp = values[dragId];
        console.log(temp);
        console.log(values[event.target.dataset.dragId]);
        values[dragId] = values[event.target.dataset.dragId];
        values[event.target.dataset.dragId] = temp;
        component.set("v.values", values);
        event.preventDefault();
    },
    cancel: function(component, event, helper) {
        console.log("cancel");
        event.preventDefault();
    }
})