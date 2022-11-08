/*
 	Name 		: 	ProjectTriggerHelper
	Date 		: 	8 March 2021
	Author 		: 	Vishal Chandnani
	Description : 	This class is a helper class for ProjectTrigger in which I insert 5 project tasks.
*/

public class ProjectTriggerHelper {
    
    public static void insertProjectTaskList(List<Project__c> projectList){
        List<Project_Task__c> tasks = new List<Project_Task__c>();
        for(Project__c project : projectList){
            tasks.add(new Project_Task__c(Type__c = 'New Task', Project__c = project.Id));
            tasks.add(new Project_Task__c(Type__c = 'Planning Phase', Project__c = project.Id));
            tasks.add(new Project_Task__c(Type__c = 'Construction Work', Project__c = project.Id));
            tasks.add(new Project_Task__c(Type__c = 'Completion Step', Project__c = project.Id));
            tasks.add(new Project_Task__c(Type__c = 'Contract End', Project__c = project.Id));
        }
        
        insert tasks;
        
        for(Integer index = tasks.size() - 1; index > 0; index--){
            if(tasks.get(index).Type__c != 'New Task'){
                tasks.get(index).Previous_Task__c = tasks.get(index - 1).Id;   
            }
        }
        
        if(tasks.size() > 0){
            update tasks;
        }
    }
}