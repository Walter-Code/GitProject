/**
* @author 
* @date 
*
* @uses : Database.executeBatch(new UserEmailVerificationBatch(),1);
*
* @description This batch is use to send email varification link to
		users who not verfied their email.
 Note : Make sure to run the batch in 1 chunk size.
*/

global class UserEmailVerificationBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        // Fetching users who not verified their emails.
        String query = 'SELECT Id, UserId FROM TwoFactorMethodsInfo WHERE HasUserVerifiedEmailAddress = false';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<TwoFactorMethodsInfo> TwoFactorMethodsInfoList){
		
        //sending "Verify your email address in Salesforce" email.
        //if(Test.isRunningTest()){
            //System.debug('Test Class');
        //}else{
            //System.UserManagement.sendAsyncEmailConfirmation(TwoFactorMethodsInfoList[0].UserId,null,null ,null);
        //}
        

    }
    
    global void finish(Database.BatchableContext BC){
        
    }

}