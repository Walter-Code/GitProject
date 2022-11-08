/******************************************************************************************************************
Class Name         : AccountTriggerHandlerTest
Description        : This class is a test class of AccountTriggerHandler
Organization       :  

Revision History   :-
Version             Date            Author                
1.0                 7/15/2021         
*******************************************************************************************************************/
@isTest
public class AccountTriggerHandlerTest {
	
    @isTest
    public static void testupdateForeCast(){
        Test.setMock(HttpCalloutMock.class, new AccountForecastMock());
        
        Account acc = new Account(Name = 'Test Forecast');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Rony', LastName = 'Gross', Email = 'ronygross@gmail.com');
        con.AccountId = acc.Id;
        insert con;
        
        Test.startTest();
        acc.BillingPostalCode = '35004';
        update acc;
        Test.stopTest();
    }
}