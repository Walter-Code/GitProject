/*
 	Name 		: 	SendEmailBatchHelper
	Date 		: 	12 March 2021
	Author 		: 	Vishal Chandnani
	Description : 	This class is a helper of SendEmailBatch class in which I make static function which is used to send
					email to those Project Owner whose Project status is 'Deployment' and I also send email to assign task 
					Owner.
*/

public class ProjectDeploymentBatchHelper {
    
    public static void sendEmailMessages(List<Project__c> projectList, Id completeTaskTemplateId, Id projectOwnerTemplateId){
        List<Messaging.SingleEmailMessage> emailMsgList = new List<Messaging.SingleEmailMessage>();
        
        for(Project__c project : projectList){
            Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
            emailMsg.setTemplateId(completeTaskTemplateId);
            emailMsg.setTargetObjectId(project.Project_Owner__c);
            emailMsg.setWhatId(project.Id);
            emailMsg.setSaveAsActivity(false);
            emailMsgList.add(emailMsg);
            
            Messaging.SingleEmailMessage templateEmailMsg = new Messaging.SingleEmailMessage();
            templateEmailMsg.setToAddresses(new List<String>{project.Project_Tasks__r.get(0).Owner.Email});
            templateEmailMsg.setTemplateId(projectOwnerTemplateId);
            templateEmailMsg.setTargetObjectId(project.Project_Owner__c);
            templateEmailMsg.setWhatId(project.Project_Tasks__r.get(0).Id);
            templateEmailMsg.setTreatTargetObjectAsRecipient(false);
            templateEmailMsg.setSaveAsActivity(false);
            emailMsgList.add(templateEmailMsg);
            
        }
        
        if(emailMsgList.size() > 0){
         	//Messaging.sendEmail(emailMsgList);
        }
    }
}