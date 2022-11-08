public class ContactTaskController {
    public List<ContactModel> attachmentList{get;set;}
    public contactTaskController(){
      	//attachments = new List<Attachment>();
      	attachmentList = new List<ContactModel>();
        for(Contact con : [Select Id, Name, AccountId, Birthdate, Email, Fax, 
                           (Select Id, description, name from Attachments)
                           from Contact] ){            
            ContactModel atc = new ContactModel();
            atc.urlExists = true;
           	if(con.attachments.size() == 0){
				//System.debug('true');
				atc.urlExists = false;         
            }else {
                atc.attach = con.attachments[con.attachments.size()-1];
                //System.debug('false');
            }
            atc.con = con;
            attachmentList.add(atc);
        }
    }
    public class ContactModel{
        public boolean urlExists{get;set;}
        public Attachment attach{get;set;}
        public Contact con{get;set;}
    }
}