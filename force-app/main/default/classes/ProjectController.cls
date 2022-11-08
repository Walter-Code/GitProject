public with sharing class ProjectController {
    
    @AuraEnabled(cacheable=true)
    public static Project__c getProject(Id projectId){
        System.debug('##'+projectId);
        return [SELECT Id, Status__c FROM Project__c WHERE Id = :projectId];
    }
}