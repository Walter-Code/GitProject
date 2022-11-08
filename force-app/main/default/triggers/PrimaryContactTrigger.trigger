trigger PrimaryContactTrigger on Contact (after insert, after update) {
    List<Contact> contacts = trigger.new;
    Set<Id> accountIds = new Set<Id>();
    
    for(Contact con : contacts){
        accountIds.add(con.AccountId);
    }
    
    if(trigger.isUpdate){
        for(Contact con : trigger.old){
            accountIds.add(con.AccountId);
        }   
    }

    Map<Id, Account> accountMap = new Map<Id, Account>([Select Id, Name, Primary_Contact_Email__c, Primary_Contact_Id__c, 
                                                        (Select Id, Name, Email From Contacts where Email != null Limit 1)
                                                        from Account where Id = :accountIds]);
    
    if(trigger.isInsert){
        for(Contact con : contacts){
            
            if(con.AccountId != null){
                Account acc = accountMap.get(con.AccountId);
                if(String.isNotBlank(con.Email)){
                    if(String.isBlank(acc.Primary_Contact_Email__c)){
                        acc.Primary_Contact_Email__c = con.Email;
                        acc.Primary_Contact_Id__c = con.Id;
                    }
                }
                if(acc.Primary_Contact_Id__c == null){
                    System.debug('##');
                   acc.Primary_Contact_Id__c = con.Id;
                }
            }
        }
    }
    
    if(trigger.isUpdate){
        for(Contact con : contacts){
            Account acc = accountMap.get(con.AccountId);
            Contact tempCon = null;
            if(accountMap.get(con.AccountId).Contacts.size()>0){
                tempCon = accountMap.get(con.AccountId).Contacts;
            }
            
            if(con.Email != null && acc.Primary_Contact_Email__c == trigger.oldMap.get(con.Id).Email){
                acc.Primary_Contact_Email__c = con.Email;
            }else if(con.Email == null && acc.Primary_Contact_Email__c == trigger.oldMap.get(con.Id).Email){
                if(tempCon != null){
                    acc.Primary_Contact_Email__c = tempCon.Email;
                }else{
                    acc.Primary_Contact_Email__c = null;
                }
            }else if(acc.Primary_Contact_Email__c == null){
                if(tempCon != null){
                    acc.Primary_Contact_Email__c = tempCon.Email; 
                }   else{
                    acc.Primary_Contact_Email__c = null;
                }
            }
        }
    }
    
    upsert accountMap.values();
}