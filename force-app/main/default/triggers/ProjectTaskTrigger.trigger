trigger ProjectTaskTrigger on Project_task__c ( after update) {
    
    if(trigger.isAfter){
        ProjectTaskTriggerHelper.validateRecord(trigger.newMap, trigger.oldMap);
        ProjectTaskTriggerHelper.updateProjectStatus(trigger.newMap, trigger.oldMap);
    }
}