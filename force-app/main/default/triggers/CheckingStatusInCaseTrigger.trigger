trigger CheckingStatusInCaseTrigger on Case (before insert) {
    System.debug('Supplied Email = ' + trigger.new[0].SuppliedEmail);
    System.debug('Supplied Name = ' + trigger.new[0].SuppliedName);
    System.debug('Contact Email = ' + trigger.new[0].ContactEmail);
    /*Map<Id, Case> caseMap = new Map<Id, Case>();
    
    List<Hire_Form__c> hireForms = new List<Hire_Form__c>();
    for(Case cs : trigger.new){
        if(cs.Status == 'Closed'){
            caseMap.put(cs.ContactId, cs);
        }
    }
    
    if(caseMap.size()>0){
     	hireForms = [Select Id, Status__c, Candidate__c from Hire_Form__c where Candidate__c In :caseMap.keySet()];   
    }
    
    for(Hire_Form__c hf : hireForms){
        if(hf.Status__c != 'Completed'){
            Case cs = caseMap.get(hf.Candidate__c);
	    	cs.Status.addError('Status cannot be closed until status in hire form is completed ');
        }
    }*/
}