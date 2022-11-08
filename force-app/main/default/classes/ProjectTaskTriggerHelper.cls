/*
 	Name 		: 	ProjectTaskTriggerHelper
	Date 		: 	8 March 2021
	Author 		: 	Vishal Chandnani
	Description : 	This class is a helper class for ProjectTaskTrigger in which I make two function first is updating status of 
					Project according to Project_Task completion. Second Function is validating record by checking that the 
					attachment description is Terms & Condition.
*/

public class ProjectTaskTriggerHelper {
    
    public static void validateRecord(Map<Id, Project_Task__c> newMap, Map<Id, Project_Task__c> oldMap){
        Set<Id> projectTaskIds = new Set<Id>();
        for(Project_Task__c task : newMap.values()){
            if(task.Completed__c && oldMap.get(task.Id).Completed__c != newMap.get(task.Id).Completed__c){
                projectTaskIds.add(task.Id);
            }
        }
        
        Map<Id, Attachment> attachmentMap = new Map<Id, Attachment>();
        for(Attachment attachment : [Select Id, ParentId, Description From Attachment 
                                     where ParentId In :projectTaskIds AND Description like '%Terms & Conditions%']){
            attachmentMap.put(attachment.parentId, attachment);
        }
        
        for(Project_Task__c task : newMap.values()){
            if(attachmentMap.get(task.Id) == null){
                task.Completed__c.addError('You have atleast one attachment and its description must be Terms & Conditions');
            }
        }
    }
    
    public static void updateProjectStatus(Map<Id, Project_Task__c> newMap, Map<Id, Project_Task__c> oldMap){
        Set<Id> projectIds = new Set<Id>();
        for(Project_Task__c task : newMap.values()){
            if(task.Completed__c && oldMap.get(task.Id).Completed__c != newMap.get(task.Id).Completed__c){
                projectIds.add(task.Project__c);   
            }
        }
        
        Map<Id, Project__c> projectMap = new Map<Id, Project__c>([SELECT Id, Status__c FROM Project__c where Id In : projectIds]);
        
        if(projectMap.size() > 0){
            for(Project_Task__c task : newMap.values()){
                if(projectMap.get(task.Project__c) != null){
                 	projectMap.get(task.Project__c).Status__c = getStatus(task);   
                }
            }
            if(projectMap.size() > 0){
             	update projectMap.values();   
            }
        }
    }
    
    public static String getStatus(Project_Task__c task){
        String taskType = '';
        switch on task.Type__c{
            when 'New Task'{
         		taskType = 'New';       
            }when 'Planning Phase'{
                taskType = 'Planning';
            }when 'Construction Work'{
                taskType = 'Construction';
            }when 'Completion Step'{
                taskType = 'Deployment';
            }when 'Contract End'{
                taskType = 'Signoff';
            }
        }
        return taskType;
    }
}