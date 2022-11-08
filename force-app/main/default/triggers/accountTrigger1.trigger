trigger accountTrigger1 on Account (before update, before delete) {
    
    Map<Id, Account> accountMap = new Map<Id, Account>(trigger.new);
    List<Opportunity> opportunities = [Select Id, Name, AccountId, Stage_Type__c from Opportunity where AccountId In :accountMap.keySet()];
    
    for(Opportunity opp : opportunities){
        Account acc = accountMap.get(opp.AccountId);
        Account accNewMap = trigger.newMap.get(acc.Id);
        Account accOldMap = trigger.oldMap.get(acc.Id);
        
        if(accNewMap.Account_Type__c != accoldMap.Account_Type__c){
            if(acc.Account_Type__c == 'Reseller'){
                opp.Stage_Type__c = '10';
            }else if(acc.Account_Type__c == 'Buyer'){
                opp.Stage_Type__c = '25';
            }else if(acc.Account_Type__c == 'Current Customer'){
                opp.Stage_Type__c = '100';
            }else{
                opp.Stage_Type__c = '0';
            }   
        }
    }
    if(AccountTriggerController.isCheck){
        
    }
    AccountTriggerController.isCheck = false;
    upsert opportunities;
    
    /*Map<Id, Account> accountMap = new Map<Id, Account>(trigger.new);
    List<Contact> contacts = [Select Id, FirstName, LastName, AccountId, Profile__c from Contact where AccountId In :accountMap.keySet()];
    
    for(Contact con : contacts){
        Account acc = accountMap.get(con.AccountId);
        if(acc.Website != null){
            con.Profile__c = acc.Website + '/' + con.FirstName.substring(0,1) + con.LastName;
        }
    }
    
    upsert contacts;*/
    
}