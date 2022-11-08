/******************************************************************************************************************
Class Name         : AccountForecastBatchScheduler
Description        : This class is a Scheduler class which executes batch class at 1:00 AM everyday
Organization       :  

Revision History   :-
Version             Date            Author                
1.0                 7/15/2021         
*******************************************************************************************************************/

public class AccountForecastBatchScheduler implements Schedulable {
    
    public void execute(SchedulableContext scheduleContext){
        Database.executeBatch(new AccountForecastBatch(), 10); // Given size of the batch is 10 because doing callout from batch class.
    }
}