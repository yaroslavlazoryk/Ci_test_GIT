({
    selectRecord : function(component, event, helper){
        var getSelectRecord = component.get("v.oRecord");
        console.log("name" + component.get("v.oRecord").Name);
        var compEvent = component.getEvent("oSelectedRecordEvent");
        compEvent.setParams({"recordByEvent" : getSelectRecord });
        compEvent.fire();
    },
})