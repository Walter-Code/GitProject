/*
 	Name 		: 	SendEmailBatch
	Date 		: 	12 March 2021
	Author 		: 	Vishal Chandnani
	Description : 	This class is a Batch class in which I fetch all Project records and write query to get visualforce template
					and html template.
*/

public class ProjectDeploymentBatch implements Database.Batchable<SObject>, Database.Stateful {
    List<EmailTemplate> emailTemplates;
    
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        emailTemplates = [Select Id FROM EmailTemplate WHERE 
                          DeveloperName = 'Remind_Project_Owner_Template' OR 
                          DeveloperName = 'Reminder_To_Complete_Task_Template'
                          Order By DeveloperName];
        
        return Database.getQueryLocator([Select Id, Name, Project_Owner__r.Email, Status__c, 
                                         (Select Id, Type__c, Owner.Email FROM Project_Tasks__r 
                                          WHERE Type__c = 'Contract End' limit 1) 
                                         FROM Project__c WHERE Status__c = 'Deployment']);
    }
    
    public void execute(Database.BatchableContext batchContext, List<Project__c> projectList){
        ProjectDeploymentBatchHelper.sendEmailMessages(projectList, emailTemplates.get(1).Id, emailTemplates.get(0).Id);
    }
    public void finish(Database.BatchableContext batchContext){
        System.debug('Email sent successfully');
    }
}