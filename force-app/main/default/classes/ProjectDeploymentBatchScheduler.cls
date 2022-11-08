/*
    Name        :   SendEmailBatchScheduler
    Date        :   12 March 2021
    Author      :   Vishal Chandnani
    Description :   This class is a Scheduler class which executes batch class at 12:00 AM everyday;
*/

public class ProjectDeploymentBatchScheduler implements Schedulable {
    
    public void execute(SchedulableContext scheduleContext){
        Database.executeBatch(new ProjectDeploymentBatch());
    }
}