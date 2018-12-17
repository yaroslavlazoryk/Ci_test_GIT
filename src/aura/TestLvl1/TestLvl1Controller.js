/**
 * Created by new on 18.01.2018.
 */
({
    changeAttr : function(component, event, helper) {
        console.log(component.get('v.attr'));
        component.set('v.attr', 'himanLVL1');
        console.log(component.get('v.attr'));
//console.log('gggg');
    }
})