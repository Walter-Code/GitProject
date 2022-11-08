public class IncreaseRoomPriceAssignment implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
    	return Database.getQueryLocator([Select Id, Price__c from Room__c]);    
    }
    
    public void execute(Database.BatchableContext bc, List<Room__c> roomList){
        for(Room__c rm : roomList){
            if(rm.Price__c <= 8000){
                rm.Price__c += 2000;
            }
        }
        upsert roomList;
    }
    
    public void finish(Database.BatchableContext bc){
        List<Messaging.SingleEmailMessage> messageList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        List<String> addresses = new List<String>{'vishalchandnani41@gmail.com'};
        sem.setToAddresses(addresses);
        sem.setSubject('Reminder For Increase Room Price');
        sem.setHtmlBody('Hii Sir, <br/> It\'s Just a reminder of increase in our hotel room price.<br/><br/> Thanks & Regards<br/> Vishal');
        messageList.add(sem);
        Messaging.sendEmail(messageList);
        
        System.debug('Mail SuccessFully Sent');
    }
}