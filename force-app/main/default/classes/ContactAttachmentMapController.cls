public class ContactAttachmentMapController {
    public List<ContactModel> contactModels{get;set;}
    public Map<Id , ContactModel> contactModelMap{get;set;}
    public ContactAttachmentMapController(){
        Map<Id , Contact> contactMap = getContacts();
        contactModels = new List<ContactModel>();
        contactModelMap = new Map<Id , ContactModel>();
        
        List<Id> contactIds = new List<Id>(contactMap.keySet());
        
        
        Map<Id , List<Attachment>> attachmentMap = new Map<Id , List<Attachment>>();
        List<Attachment> attachments = [Select Id, description, parentId, body, name 
                                        from Attachment where parentId in : contactMap.keyset()];
        //System.debug(contacts.values());
        Integer i = 0;
        for(Attachment att : attachments){
            List<Attachment> attachmentList = attachmentMap.get(att.ParentId);
            if(attachmentList == null){
                attachmentList = new List<Attachment>();
            }
            attachmentList.add(att);
            attachmentMap.put(att.parentId, attachmentList);
            ContactModel cm =  new ContactModel();
            cm.con = contactMap.get(att.ParentId);
            cm.isUrlExists = false;
            List<Attachment> attachmentListDemo = attachmentMap.get(att.ParentId);
            if(attachmentListDemo != null){
                cm.isUrlExists = true;
                cm.att = attachmentListDemo[attachmentListDemo.size()-1];
            }
            contactModelMap.put(att.ParentId , cm);
            contactModels.add(cm);
            i++;
        }
        
        
        
        /*for(Id ids : contactMap.keyset()){
            ContactModel cm =  new ContactModel();
            cm.con = contactMap.get(ids);
            cm.isUrlExists = false;
            List<Attachment> attachmentList = attachmentMap.get(ids);
            //System.debug(attachmentList);
            if(attachmentList != null){
                cm.isUrlExists = true;
                cm.att = attachmentList[attachmentList.size()-1];
            }
            /*for(Attachment att : attachments){
                if(att.ParentId == con.Id){
                    cm.isUrlExists = true;
                    cm.att = att;
                    break;
                }
            }
            contactModels.add(cm);
            contactModelMap.put(ids , cm);
        }*/
    }
    
    class ContactModel{
        public Attachment attachment{get;set;}
        public boolean isUrlExists{get;set;}
        public Contact con {get;set;}
        public Attachment att {get;set;}
        
        public ContactModel(){
            attachment = new Attachment();
        }
    }
    
    Map<Id , Contact> getContacts(){
        return new Map<Id , Contact>([Select Id, Name, AccountId, Birthdate, Email, Fax from Contact]);
    }
    
    public PageReference save(){
       List<Attachment> attachments = new List<Attachment>();
       for(ContactModel cm : ContactModels){
           if(cm.attachment.Body != null){
               System.debug(cm.attachment.body);
               cm.attachment.parentId = cm.con.id;
               attachments.add(cm.attachment);
           }
       }
       Upsert attachments;
       PageReference pg =  new PageReference('/apex/ContactAttachmentDemo');
       pg.setRedirect(true);
       return pg;
    }
}