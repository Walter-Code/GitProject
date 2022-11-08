public class ContactAttachmentController {
    public List<ContactModel> contactModels{get;set;}
    Set<Id> contactIds = new Set<Id>();
    //public Attachment attach{get;set;}
    public ContactAttachmentController(){
        //attach = new Attachment();
        contactModels = new List<ContactModel>();
        List<Contact> contacts = new List<Contact>();
        List<Attachment> attachments = new List<Attachment>();
        contacts = [Select Id, Name, AccountId, Birthdate, Email, Fax from Contact];
        
        for(Contact con : contacts){
            contactIds.add(con.id);
        }
        
        attachments = [Select Id, description, parentId, body, name from Attachment where parentId in : contactIds];
        
        for(Contact con : contacts){
            ContactModel cm =  new ContactModel();
            cm.con = con;
            cm.isUrlExists = false;
            for(Attachment att : attachments){
                if(att.ParentId == con.Id){
                    cm.isUrlExists = true;
                    cm.att = att;
                    break;
                }
            }
            contactModels.add(cm);
        }
    }
    
    public PageReference save(){
        List<Attachment> attachments = new List<Attachment>();
        for(ContactModel cm : ContactModels){
            /*if(cm.addFile != null){
                Attachment attach = new Attachment();
				attach.Name = cm.con.Name + '.jpg';
				attach.Body = cm.addFile;
                attach.ParentId = cm.con.Id;
				upsert attach;
            }*/
            if(cm.attachment.Body != null){
                cm.attachment.parentId = cm.con.id;
                attachments.add(cm.attachment);
            }
       }
       upsert attachments;
       PageReference pg =  new PageReference('/apex/ContactAttachmentDemo');
       pg.setRedirect(true);
       return pg;
    }
    
    class ContactModel{
        //public blob addFile{get;set;}
        public boolean isUrlExists{get;set;}
        public Contact con{get;set;}
        public Attachment att{get;set;}
        public Attachment attachment{get;set;}
        
        public ContactModel(){
            attachment  = new Attachment();
        }
    }
}