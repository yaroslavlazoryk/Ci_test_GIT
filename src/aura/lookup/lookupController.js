({
    clear :function(component,event,helper){
        helper.hidePill(component, event);
        component.set("v.SearchKeyWord",null);
        component.set("v.listOfSearchRecords", null );
        component.set("v.selectedRecord", {} );
    },

    selectRecord : function(component, event, helper) {
        var params = event.getParam('arguments');
        component.set('v.selectedRecord', params.selectedRecord);
        helper.showPill(component, event);
        helper.hideResultList(component, event);
        document.getElementById("combobox").setAttribute("aria-expanded", false);
    },

    keyPressController : function(component, event, helper) {
        var getInputkeyWord = component.get("v.SearchKeyWord");
        if( getInputkeyWord.length > 0 ){
            helper.searchHelper(component,event,getInputkeyWord);
        } else {
            helper.searchHelper(component,event,'');
        }
    },

    showResultList : function(component, event, helper) {
        var input = component.find("inputText");
        input.set("v.errors", null);
        helper.showResultList(component, event);
        var getInputkeyWord = component.get("v.SearchKeyWord");
        if(getInputkeyWord==null){
            getInputkeyWord='';
        }
        helper.searchHelper(component,event,getInputkeyWord);
    },

    hideResultList : function(component, event, helper) {
        var params = event.getParam('arguments');
        if(params.componentId != undefined && params.componentId !== ''){
            if (params.componentId.indexOf('HTMLInputElement') === -1){
                helper.hideResultList(component, event);
                document.getElementById('combobox').setAttribute('aria-expanded', false);
            }
        } else {
            helper.hideResultList(component, event);
            document.getElementById('combobox').setAttribute('aria-expanded', false);
        }
    },

    hideSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get('e.toggle');
        evt.setParams({ isVisible : false });
        evt.fire();
    },

    showSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get('e.toggle');
        evt.setParams({ isVisible : true });
        evt.fire();
    },
})