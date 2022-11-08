public with sharing class SendEmailController {
    
    @AuraEnabled
    public static String sendMail(String subject, String body){
        String caseEmail = 'bhawna@rkmsjj6rwpkg3ocm9zr1fewkpq14txrfq8jb4p9pjy9bfwmo3.0k-246jauaq.ap6.case.salesforce.com';
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject(subject);
            mail.setPlainTextBody(body);
            mail.setToAddresses(new List<String>{caseEmail});
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
        }catch(Exception e){
            return e.getMessage();
        }
        return 'Email Sent Successfully';
    }
}