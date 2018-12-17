({
    //typeahead already initialized
    typeaheadInitStatus : {},
    
    typeaheadOldValue : {},
    //Creates the typeahead component using RequireJS, jQuery, Bootstrap and Bootstrap Typeahead
    createTypeaheadComponent: function(component){
        
        require.config({
            paths: {
                "jquery": "/resource/Lgt_InputLookup/js/jquery-2.1.1.min.js?",
                "bootstrap": "/resource/Lgt_InputLookup/js/bootstrap.min.js?",
                "boot-typeahead" : "/resource/Lgt_InputLookup/js/typeahead.js?",
            }
        });
        
        var self = this;
        var globalId = component.getGlobalId();
        //loading library sequentially
        require(["jquery"], function($) {
            require(["bootstrap", "boot-typeahead"], function(bootstrap, typeahead) {
                var inputElement = $('[id="'+globalId+'_typeahead"]');

                //inits the typeahead
                inputElement.typeahead({
                    hint: false,
                    highlight: true,
                    minLength: 2
                },
                {
                    name: 'objects',
                    displayKey: 'value',
                    source: self.substringMatcher(component)
                })
                //selects the element
                .bind('typeahead:selected', 
                      function(evnt, suggestion){
                          $A.run(function(){
                              component.set('v.value', suggestion.id);
                              component.set('v.nameValue', suggestion.value);
                          });
                      });
            });//require end
        });//require end
    },
     // Method used by the typeahead to retrieve search results
    substringMatcher : function(component) {
        //usefull to escape chars for regexp calculation
        function escapeRegExp(strng) {
          return strng.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
        }
        
        return function findMatches(qa, cb) {
            qa = escapeRegExp(qa);
            var action = component.get("c.searchSObject");
            var self = this;
      
      action.setParams({
                'type' : component.get('v.type'),
                'searchString' : qa,
            });
            
            action.setCallback(this, function(a) {
                if(a.error && a.error.length){
                    return $A.error('Unexpected error: '+a.error[0].message);
                }
                var result = a.getReturnValue();

                var matcheStr, substrRegex;
                
                
                var matcheStr = [];// an array that will be populated with a substring matches
                
                
                var substrRegex = new RegExp(qa, 'i');// regex used to determine if a string contains the substring `qa`
                var strs = JSON.parse(result);
                // iterate through the pool of strings and for any string that
                // contains the substring `qa`, add it to the `matches` array
                $.each(strs, function(i, str) {
                    if (substrRegex.test(str.value)) {
                        // typeahead jQuery plugin expects suggestion to a 
                        // JavaScript object, refer to typeahead doc for more information
                        matcheStr.push({ value: str.value , id: str.id});
                    }
                });
                if(!strs || !strs.length){
                    
                    $A.run(function(){
                        component.set('v.value', null);
                    });
                }
                cb(matcheStr);
            });
            $A.run(function(){
                $A.enqueueAction(action);
            });
        };
    },
    //Method used on initialization to get the "name" value of the lookup
    loadFirstValue : function(component) {
        //this is necessary to avoid multiple initializations (same event fired again and again)
        if(this.typeaheadInitStatus[component.getGlobalId()]){ 
      return;
        }
        this.typeaheadInitStatus[component.getGlobalId()] = true;
        this.loadValue(component);
           
    },
    //Method used to load the initial value of the typeahead 
    //(used both on initialization and when the "v.value" is changed)
    loadValue : function(component, skipTypeaheadLoading){
        this.typeaheadOldValue[component.getGlobalId()] = component.get('v.value');
        var action = component.get("c.getCurrentValue");
        var self = this;
        action.setParams({
            'type' : component.get('v.type'),
            'value' : component.get('v.value'),
        });
        
        action.setCallback(this, function(a) {
            if(a.error && a.error.length){
                return $A.error('Unexpected error: '+a.error[0].message);
            }
            var result = a.getReturnValue();
            
            
      component.set('v.isLoading',false);
            component.set('v.nameValue',result);
            if(!skipTypeaheadLoading) self.createTypeaheadComponent(component);
        });
        $A.enqueueAction(action);
    }
})