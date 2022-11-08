/******************************************************************************************************************
Class Name         : AccountForecastBatch
Description        : This batch class is used to send update forecast field of account and 
					send email to contacts if the forecast is snow or rain.
Organization       :  

Revision History   :-
Version             Date            Author                
1.0                 7/15/2021         
*******************************************************************************************************************/
public class AccountForecastBatch implements Database.Batchable<SObject>, Database.Stateful,  Database.AllowsCallouts {
    
    List<Account> updateAccounts; // Created list to update only those accounts which meet the criteria.
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        updateAccounts  = new List<Account>();
        //Querying the accounts where zipcode is not blank.
        return Database.getQueryLocator([Select Id, Name, BillingPostalCode, Forecast__c, Forecast_Icon__c
                                         FROM Account WHERE BillingPostalCode != '']);
    }
    
    public void execute(Database.BatchableContext batchContext, List<Account> accounts){
        for(Account acc : accounts){
            try {
                String jsonString = AccountForecastUtil.retrieveForecastData(acc.BillingPostalCode);
                if(jsonString != 'Error' || jsonString != 'Exception'){
                    Map<String, Object> objectMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
                    Map<String, Object> currentConditionMap = objectMap != null ? ((Map<String, Object>)objectMap.get('current') != null ? (Map<String, Object>)objectMap.get('current') : null) : null;
                    Map<String, Object> conditionMap = (Map<String, Object>) currentConditionMap.get('condition');
                    if(conditionMap != null && conditionMap.size() > 0){
                        System.debug('Current condition text = ' + conditionMap.get('text'));
                        System.debug('Current condition icon = ' + conditionMap.get('icon'));
                        acc.Forecast__c = (String) conditionMap.get('text');
                        acc.Forecast_Icon__c = (String) conditionMap.get('icon');
                        acc.Temperature__c = (Decimal) currentConditionMap.get('temp_c');
                        updateAccounts.add(acc);
                    }
                }
            }
            catch (Exception e) {         
                System.debug('Error:' + e.getMessage() + 'Line no:' + e.getLineNumber() );           
            }
            
        }
    }
    public void finish(Database.BatchableContext batchContext){
        if(updateAccounts != null && updateAccounts.size() > 0){ 
            try{
            	update updateAccounts;
                AccountForecastUtil.sendEmail(updateAccounts);
            }catch(Exception exceptionObj){
                System.debug('Exception in batch = ' + exceptionObj.getMessage());
            }  
        }
    } 
}