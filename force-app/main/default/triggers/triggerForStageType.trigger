trigger triggerForStageType on Opportunity (before insert, after update) {
    List<Opportunity> opportunities = trigger.new;
    Set<Id> ids = new Set<Id>();
    for(Opportunity opp : opportunities){
        ids.add(opp.AccountId);
    }
    Map<Id, Account> accountMap = new Map<Id, Account>([Select Id, Name, Account_Type__c from Account where 
                                                        Id In :ids]);
    List<Account> accounts = new List<Account>();
    if(trigger.isInsert){
        for(Opportunity opp : opportunities){
            Account acc = accountMap.get(opp.AccountId);
            if(acc != null){
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
    }else if(trigger.isUpdate){
        for(Opportunity opp : opportunities){
            Account acc = accountMap.get(opp.AccountId);
            Opportunity oppNewMap = trigger.oldMap.get(opp.Id);
            Opportunity oppOldMap = trigger.newMap.get(opp.Id);
            if(oppNewMap.Stage_Type__c != oppOldMap.Stage_Type__c){
                if(opp.Stage_Type__c == '0'){
                    acc.Account_Type__c = '';
                }else if(opp.Stage_Type__c == '10'){
                    acc.Account_Type__c = 'Reseller';
                }else if(opp.Stage_Type__c == '25'){
                    acc.Account_Type__c = 'Buyer';
                }else if(opp.Stage_Type__c == '100'){
                    acc.Account_Type__c = 'Current Customer';
                }
                accounts.add(acc);
            }
        }
        
        if(AccountTriggerController.isCheck){
            System.debug('#######');
            upsert accounts;
        }
        AccountTriggerController.isCheck = true;
    }
}