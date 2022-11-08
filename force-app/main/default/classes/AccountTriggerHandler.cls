/******************************************************************************************************************
Class Name         : AccountTriggerHandler
Description        : This apex class is a handler class of AccountTrigger which is used to update forecast fields in account.
Organization       :  

Revision History   :-
Version             Date            Author                
1.0                 7/15/2021         
*******************************************************************************************************************/
public class AccountTriggerHandler {

    //Method to update forecast fields
    public static void updateForeCast(List<Account> accountList, Map<Id, Account> oldAccountMap){
        for(Account acc : accountList){
            //Put a condition so the account can only be update when there is change in Postal Code. Also it stops recurssion.
            if(acc.BillingPostalCode != null && acc.BillingPostalCode != oldAccountMap.get(acc.Id).BillingPostalCode){
                retrieveDataFromWeatherApi(acc.BillingPostalCode, acc.Id);
            }
        }
    }
    
    //Created future method to call API and retrieve forecast field.
    @future(callout=true)
    public static void retrieveDataFromWeatherApi(String zipcode, Id accountId){
        String jsonString = AccountForecastUtil.retrieveForecastData(zipcode);
        if(jsonString != 'Error' || jsonString != 'Exception'){
            Map<String, Object> objectMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
            Map<String, Object> currentConditionMap = objectMap != null ? ((Map<String, Object>)objectMap.get('current') != null ? (Map<String, Object>)objectMap.get('current') : null) : null;
            Map<String, Object> conditionMap = (Map<String, Object>) currentConditionMap.get('condition');
            if(conditionMap != null && conditionMap.size() > 0){
                //Getting result in list so if the query return nothing it should not give any error.
                List<Account> accountList = [Select Id, Name, BillingPostalCode, Forecast__c, Forecast_Icon__c
                                             FROM Account WHERE Id =: accountId];
                if(accountList.size() > 0){
                    //Update fields at 0 index because query has a filter of Id which will always gives only one account.
                    accountList.get(0).Forecast__c = (String) conditionMap.get('text');
                    accountList.get(0).Forecast_Icon__c = (String) conditionMap.get('icon');
                    accountList.get(0).Temperature__c = (Decimal) currentConditionMap.get('temp_c');
                    try{
                        update accountList;
                        AccountForecastUtil.sendEmail(accountList);
                    }catch(Exception exceptionObj){
                        System.debug('Exception = ' + exceptionObj.getMessage());
                    }
                }
            }
        }
    }
}