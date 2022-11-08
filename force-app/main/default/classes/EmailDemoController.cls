public class EmailDemoController {
    
    public EmailDemoController(){
        sendEmail2();
    }
    
    void sendEmail(){
        List<Messaging.SingleEmailMessage> emailmessages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        List<String> emails = new List<String>{'vishalchandnani41@gmail.com','Yoyo@gmail.com'};
        sem.setToAddresses(emails);
        sem.setSubject('Email To Check it\'s working or not......!!!');
        String body = 'Hii Dear,<br/> Are u Working??';
        body += '<br/><br/> Thanks & Regards <br/> '+UserInfo.getName();
        sem.setHtmlBody(body);
        emailmessages.add(sem);
        Messaging.sendEmail(emailmessages);
    }
    
    void sendEmail2(){
        List<Messaging.SingleEmailMessage> emailmessages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        List<String> emails = new List<String>{'vishalchandnani41@gmail.com','Yoyo@gmail.com'};
        sem.setToAddresses(emails);
        sem.setSubject('Email To Check it\'s working or not......!!!');
        
        Id bookId = getBookingId();
        List<EmailTemplate> templates = [Select Id from EmailTemplate where DeveloperName = 'Booking_Bill'];
        if(!(templates.IsEmpty()) && bookId != null){
            sem.setTemplateId(templates.get(0).Id);
            sem.setTargetObjectId('0035g000001obFrAAI');
            sem.setWhatId(bookId);
         	emailmessages.add(sem);
        	Messaging.sendEmail(emailmessages);
        }
    }
    
    Id getBookingId(){
        List<Booking__c> bookings = [Select Id from Booking__c where Id = 'a0B5g000000TvYpEAK'];
        return bookings.get(0).Id;
    }
}