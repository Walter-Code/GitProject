public with sharing class AccountListWithContactCountController {
    
    @AuraEnabled(cacheable=true)
    public static List<AccountModel> fetchAccountModelList(){
        List<AccountModel> modelList = new List<AccountModel>();
        for(Account accountObj : [Select Id, Name, (Select Id from Contacts) from Account]){
            AccountModel accountModelObj = new AccountModel();
            accountModelObj.accountObj = accountObj;
            accountModelObj.contactCount = accountObj.Contacts.size();
            modelList.add(accountModelObj);
        }
        System.debug('##'+modelList);
        return modelList;
    }

    class AccountModel{
        @AuraEnabled
        public Account accountObj {get; set;}
        
        @AuraEnabled
        public Integer contactCount {get; set;}
    }
}