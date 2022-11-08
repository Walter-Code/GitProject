({
	openCloseModel : function(component, event, helper) {
		component.set('v.isModalOpen', !component.get('v.isModalOpen'));
        component.set('v.showSpinner', true);
        setTimeout(() => {
            component.set('v.showSpinner', false);
        }, 1000);
	},
    
    doinit : function(component, event, helper) {
		var action = component.get('c.getFieldsFromFieldSet');
        action.setParams({
            fieldSetApiName : 'Opportunity_Field_Set', objectApiName : 'Opportunity'
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS'){
                console.log('Response = ', response.getReturnValue());
                component.set('v.fieldApiNames', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
    
    handleSuccess : function(component,event,helper) {
    	var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'Record Created successfully',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
        component.set('v.isModalOpen', false);
    }
})