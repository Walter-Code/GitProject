/******************************************************************************************************************
Class Name         : AccountForecastBatchSchedulerTest
Description        : This class is a test class of AccountForecastBatchScheduler and AccountForecastBatch
Organization       :  

Revision History   :-
Version             Date            Author                
1.0                 7/15/2021         
*******************************************************************************************************************/
@isTest
public class AccountForecastBatchSchedulerTest {
	@isTest
    public static void testAccountForecastBatchScheduler(){
        Test.setMock(HttpCalloutMock.class, new AccountForecastMock());
        
        Account acc = new Account(Name = 'Test Forecast', BillingPostalCode = '35004');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Rony', LastName = 'Gross', Email = 'ronygross@gmail.com');
        con.AccountId = acc.Id;
        insert con;
        
        Test.startTest();
    	System.schedule('Test Job', '0 0 1 1/1 * ? *', new AccountForecastBatchScheduler());
        Test.stopTest();
    }
    
}