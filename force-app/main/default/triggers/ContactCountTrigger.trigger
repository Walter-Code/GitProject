trigger ContactCountTrigger on Contact (before insert, before update) {
    List<Contact> contacts = trigger.new;
    List<Contact> tempContacts = trigger.old;
    Set<Id> ids = new Set<Id>();    
    for(Contact con : contacts){
        ids.add(con.AccountId);
    }
    
    if(trigger.IsUpdate){
        for(Contact con : tempcontacts){
            ids.add(con.AccountId);
        }   
    }
    
    Map<Id, Account> accountMap = new Map<Id, Account>([Select Id, Name, Total_Contact__c from Account where Id In :ids]);
    
    if(trigger.isInsert){
        for(Contact con : contacts){
            if(con.AccountId != null){
                accountMap.get(con.AccountId).Total_Contact__c = accountMap.get(con.AccountId).Total_Contact__c + 1;
            }
        }
    }
    
    if(trigger.isUpdate){
        for(Contact con : contacts){
            if(trigger.oldMap.get(con.Id).AccountId != trigger.newMap.get(con.Id).AccountId){
                if(trigger.oldMap.get(con.Id).AccountId != null){
                 	accountMap.get(trigger.oldMap.get(con.Id).AccountId).Total_Contact__c = accountMap.get(trigger.oldMap.get(con.Id).AccountId).Total_Contact__c - 1;   
                }
                if(trigger.newMap.get(con.Id).AccountId != null){
                 	accountMap.get(trigger.newMap.get(con.Id).AccountId).Total_Contact__c = accountMap.get(trigger.newMap.get(con.Id).AccountId).Total_Contact__c + 1;   
                }
            }
        }   
    }
    upsert accountMap.values();
}