public class EmailAssignmentController {
    public List<ContactModel> contactModels{get;set;}
    public String cc{get;set;}
    public String bcc{get;set;}
    public String subject{get;set;}
    public String body{get;set;}
    public String emails{get;set;}
    public Integer temp{get;set;}
    List<String> emailAddresses;
    
    public EmailAssignmentController(){
        emailAddresses = new List<String>();
        emails = '';
        Integer i = 0;
        contactModels = new List<ContactModel>();
        List<Contact> contacts = [Select Id, Name, Fax, Email from Contact];
        for(Contact con : contacts){
            ContactModel cm =  new ContactModel();
            cm.index = i++;
            cm.con = con;
            cm.isChecked = false;
            contactModels.add(cm);
        }
    }
    
    public void addEmails(){
        Integer j = 0;
        if(contactModels.get(temp).isChecked){
         	emails += contactModels.get(temp).con.Email + ' , ';
        	emailAddresses.add(contactModels.get(temp).con.Email);
        }else{
			Integer tem = emailAddresses.indexOf(contactModels.get(temp).con.Email);
            emailAddresses.remove(tem);
            emails = emails.remove(contactModels.get(temp).con.Email + ' , ');
        }
    }
    
    public PageReference sendEmails(){
        
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        sem.setToAddresses(emailAddresses);
        
        List<String> ccList = cc.split(' ');
        List<String> bccList = bcc.split(' ');
        
        sem.setCcAddresses(ccList);
        sem.setBccAddresses(bccList);
        sem.setSubject(subject);
        sem.setPlainTextBody(body);
        emailMessages.add(sem);
        Messaging.sendEmail(emailMessages);
        PageReference pg = new PageReference('/apex/EmailAssignment');
        pg.setRedirect(true);
        return pg;
    }
    
    class ContactModel{
        public Contact con{get;set;}
        public boolean isChecked{get;set;}
        public Integer index{get;set;}
    }
}