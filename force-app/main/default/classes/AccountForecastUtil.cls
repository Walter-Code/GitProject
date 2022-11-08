/******************************************************************************************************************
Class Name         : AccountForecaseUtil
Description        : This apex class is a util class which is used by AccountTriggerHandler and AccountForecastBatch
					to send email and do callout to get forecast result from Weather API.
Organization       :  

Revision History   :-
Version             Date            Author                
1.0                 7/15/2021         
*******************************************************************************************************************/
public class AccountForecastUtil {
    
    //Method to retrieve Forecast data from Weather API
    public static String retrieveForecastData(String zipcode){
        WeatherAPI__c weatherAPI = WeatherAPI__c.getOrgDefaults();
        String apiKey = weatherAPI.API_Key__c;
        String endPoint = 'callout:Weather_api';
        try{
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();
            req.setEndpoint(endPoint+'/forecast.json?key='+apiKey+'&q=' + zipcode);
            req.setMethod('GET');
            System.debug('EndPoint = ' + req.getEndpoint());
            res = http.send(req);
            System.debug('Response Status Code = ' + res.getStatusCode());
            if(res.getStatusCode() == 200){
                System.debug('response = ' + res.getBody());
                return res.getBody();
            }
            return 'Error';
        }catch(Exception exceptionObj){
            System.debug('Exception = ' + exceptionObj.getMessage());
            return 'Exception';
        }
        
    } 
    
    //Method to send email to contacts when meet certain criteria.
    public static void sendEmail(List<Account> accountList){
        List<Messaging.SingleEmailMessage> messageList = new List<Messaging.SingleEmailMessage>();
        List<EmailTemplate> emailTemplateList = [Select Id FROM EmailTemplate WHERE DeveloperName = 'Forecast_Alert'];
        //Querying all the contacts related to the accounts.
        List<Contact> contactList = [Select Id, AccountId, Account.Forecast__c From Contact Where AccountId In : accountList];
        for(Contact con : contactList){
            //Added condition to check and send email to only those contacts where account forecast is rain or snow.
            if(con.Account.Forecast__c.equalsIgnoreCase('Partly cloudy') || con.Account.Forecast__c.equalsIgnoreCase('snow')){
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.setTemplateId(emailTemplateList.get(0).Id);
                message.setTargetObjectId(con.Id);
                message.setWhatId(con.AccountId);
                messageList.add(message);
            }
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messageList);
        if(results[0].success){
            System.debug('The email was sent successfully.');
        }else{
            System.debug('The email failed to send:' + results[0].errors[0].message);
        }
    }
}