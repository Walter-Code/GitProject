public class UpdateAccountTypeByBatch implements Database.Batchable<SObject> {
	
    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('Start Method');
        return Database.getQueryLocator([Select Id, Type from Account]);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> accounts){
        System.debug('Execute Method');
        Integer count = 0;
        AsyncApexJob jobId = [Select Id from AsyncApexJob where Id =: bc.getJobId()];
        System.debug('JobId = '+jobId);
        System.debug('aa'+accounts.size());
        for(Account acc : accounts){
            acc.Type = '';
            count++;
        }
        if(accounts.size() < 5){
       		System.abortJob(jobId.Id);
        }
        
        System.debug('Aborted');
        update accounts;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Finish Method');
        //Database.executeBatch(new UpdateLanguageContactByBatch(), 10);
    }
}