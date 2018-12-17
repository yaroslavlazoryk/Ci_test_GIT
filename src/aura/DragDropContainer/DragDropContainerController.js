({
    
    myAction : function(component, event, helper) {
        console.log('check');
		  alert("You clicked: " + event.getSource().get("v.label"));
        window.location.replace("https://slavislove-dev-ed.lightning.force.com/servlet/networks/switch?startURL=%2Fsecur%2Flogout.jsp");
    
	},
       handleClick : function (cmp, event, helper) {
        alert("You clicked: " + event.getSource().get("v.label"));
    },
	doInit : function(component, event, helper) {
        var newItems = [{
            title: 'One item',
            id: '23243342',
            status: 'New'
        },{
            title: 'One item2',
            id: '23243343',
            status: 'Closed'
        },{
                     title: 'One item3',
                     id: '23243344',
                     status: 'Deleted'
                 }
        ];
        component.set('v.allItems', newItems);
	},
    
    onPipelineChanged: function(component, event, helper) {
        var title = event.getParam('title');
        var item = event.getParam('item');
        var allLists = component.get('v.allItems');
	     var actualItem = allLists.find(function(el) {
            return el.id == item.id;
        });
        if (actualItem) {
            actualItem.status = title;
            component.set('v.allItems', allLists);
        } else {
            console.log('could not find item ', item, ' in list ', allLists);
        }

        
    }
 })