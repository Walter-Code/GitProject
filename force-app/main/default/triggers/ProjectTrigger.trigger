trigger ProjectTrigger on Project__c (after insert) {
	
    if(trigger.isAfter){
        ProjectTriggerHelper.insertProjectTaskList(trigger.new);
    }
}