public with sharing class AccountController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [ SELECT Id, Name, Industry,
        (SELECT Id, FirstName, LastName FROM Contacts)
        FROM Account ];
    }

    @AuraEnabled
    public static Id addAccount(Account acc){
        upsert acc;
        return acc.Id;
    }

    @AuraEnabled
    public static void deleteAccount(Account acc){
        System.debug('deleteMethod'+acc);
        delete acc;
    }
}