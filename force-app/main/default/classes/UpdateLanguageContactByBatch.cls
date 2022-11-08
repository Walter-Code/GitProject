public class UpdateLanguageContactByBatch implements Database.Batchable<SObject> {
	
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id, AccountId, Account.Name, Account.Fax, Languages__c from Contact]);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> contacts){
        for(Contact con : contacts){
            con.Languages__c = con.Account.Name;
            con.OtherPhone = con.Account.Fax;
        }
        
        upsert contacts;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Contact Language Field Successfully Updated.');
    }
}