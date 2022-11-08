public class AccountListWithAggregateController {
    //public Map<String, Integer> accountMap{get;set;}
    public Map<Id, Account> accMap{get;set;}
    public Map<Id, Integer> tempMap{get;set;}
    public Set<Id> ids{get;set;}
    public AccountListWithAggregateController(){
       	//accountMap = new Map<String, Integer>();
    	getAccountList();
        ids = accMap.keySet();
    }
    
    void getAccountList(){
        List<AggregateResult> aggResults = [Select count(Id) contacts, AccountId From Contact GROUP BY AccountId];
        accMap = new Map<Id, Account>([Select Id, Name From Account]);
        tempMap = new Map<Id, Integer>();
        //System.debug(aggResults);
        
        for(AggregateResult agg : aggResults){
            Integer count = (Integer)agg.get('contacts');
            Id accId = (Id)agg.get('AccountId');
            tempMap.put(accId, count);
            //yoyo.put(accId,tempMap);
        }
        
        for(Account acc : accMap.values()){
            if(tempMap.get(acc.Id) == null){
                tempMap.put(acc.Id, 0);
            }
        }
    }
}