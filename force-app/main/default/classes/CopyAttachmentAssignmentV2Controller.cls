public class CopyAttachmentAssignmentV2Controller {
    public String searchName{get;set;}
    public List<SelectOption> objects{get;set;}
    public String selectedObject{get;set;}
    public List<AttachmentModel> attachmentModels{get;set;}
    public boolean showPop{get;set;}
    public boolean masterCheckAttachment{get;set;}
    List<Attachment> attachments;
    public CopyAttachmentAssignmentV2Controller(){
        attachmentModels = new List<AttachmentModel>();
        showPop = false;
        objects = new List<SelectOption>();
        objects.add(new SelectOption('','--None--'));
        objects.add(new SelectOption('Account', 'Account'));
        objects.add(new SelectOption('Contact', 'Contact'));
        objects.add(new SelectOption('Opportunity', 'Opportunity'));
    }
    
    public void getAttachments(){
        attachmentModels = new List<AttachmentModel>();
        if(selectedObject != null){
            String query = 'Select Id, Name from '+selectedObject;
            Map<Id, SObject> sobjectMap = new Map<Id, SObject>(Database.query(query));
            Set<Id> ids = sobjectMap.keySet();
            List<Attachment> attachments = [Select Id, Name, ParentId, ContentType, Body from
                                            Attachment where parentId In :ids];
            for(Attachment att : attachments){
                AttachmentModel am = new AttachmentModel();
                am.attach = att;
                am.isChecked = false;
                attachmentModels.add(am);
            } 
        }
    }
    
    class AttachmentModel{
        public Attachment attach{get;set;}
        public boolean isChecked{get;set;}
    }
}