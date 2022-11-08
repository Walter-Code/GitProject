public class CopyAttachmentAssignmentController {
    public String searchName{get;set;}
    public List<objModel> objModels{get;set;}
    public List<AttachmentModel> attachmentModels{get;set;}
    public String selectedObjectDemo{get;set;}
    public String selectedObject{get;set;}
    public List<SelectOption> objects{get;set;}
    public boolean showPop{get;set;}
    public boolean masterCheckAttachment{get;set;}
    public boolean masterCheckRecord{get;set;}
    public boolean isSearch{get;set;}
    public boolean showList{get;set;}
    
    @testVisible List<SObject> objectList;
    @testVisible List<Attachment> attachmentList;
    @testVisible List<Attachment> attachments;
    @testVisible List<SObject> SobjectList;
    @testVisible List<objModel> objModelsTemp;
    public CopyAttachmentAssignmentController(){
        attachmentModels = new List<AttachmentModel>();
        attachments = new List<Attachment>();
        objModels = new List<objModel>();
        showPop = false;
        isSearch = false;
        showList = false;
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
            attachmentList = [Select Id, Name, ParentId, ContentType, Body from
                                            Attachment where parentId In :ids];
            for(Attachment att : attachmentList){
                AttachmentModel am = new AttachmentModel();
                am.attach = att;
                am.isChecked = false;
                attachmentModels.add(am);
            } 
        }
        objModels.clear();
    }
    
    public void showSearchButton(){
        objModels.clear();
        if(selectedObjectDemo == null){
        	isSearch = false;    
        }else{
            isSearch = true;
        }
        showList = false;
    }
    
    public void getObjectRecords(){
        objModels = new List<objModel>();
        if(selectedObjectDemo != null){
            String query = 'Select Id, Name from '+selectedObjectDemo;
            objectList = Database.query(query);
            for(SObject sobj : objectList){
                objModel objm = new objModel();
                objm.obj = sobj;
                objm.isChecked = false;
                objm.Name = (String)sobj.get('Name');
                objModels.add(objm);
            }
            objModelsTemp = objModels;   
        }
    }
    
    public void showPopUp(){
        showList = false;
        if(attachments.size()>0){
            showPop = true;
            selectedObjectDemo = '';
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please Select At Least One Attachment'));
        }
        isSearch = false;
        objModels.clear();
    }
    
    public void hidePopUp(){
        showPop = false;
    }
    
    public void searchRecord(){
        showList = true;
        getObjectRecords();
        objModels = objModelsTemp;
        List<objModel> objModelsDemo = new List<objModel>();
        for(ObjModel objm : objModels){
            if(objm.Name.containsIgnoreCase(searchName)){
                objModelsDemo.add(objm);
            }
        }
        
        objModels = objModelsDemo;
    }
    
    public PageReference toCopy(){
        List<Attachment> tempAttachmentList = new List<Attachment>();
        
        for(SObject objm : SobjectList){
            for(Attachment attach : attachments){
                Attachment att = new Attachment();
                att.Body = attach.Body;
                att.ParentId = objm.Id;
                att.ContentType = attach.ContentType;
                att.Name = attach.Name;
                tempAttachmentList.add(att);
            }
        }
        
        upsert tempAttachmentList;
        PageReference pg = new PageReference('/apex/CopyAttachmentAssignment');
        pg.setRedirect(true);
        return pg;
    }
    
    public void checkAllAttachments(){
        attachments = new List<Attachment>();
        for(AttachmentModel attModel : attachmentModels){
            if(masterCheckAttachment){
                attachments.add(attModel.attach);
                attModel.isChecked = true;
            }else{
                attachments.clear();
                attModel.isChecked = false;
            }
        }
    }
    
    public void changeMasterCheckAttachment(){
        attachments = new List<Attachment>();
        Integer count = 0;
        for(AttachmentModel attModel : attachmentModels){
            if(attModel.isChecked){
                count++;
                attachments.add(attModel.attach);
            }else{
                masterCheckAttachment = false;
                if(attachments.contains(attModel.attach)){
                    attachments.remove(attachments.indexOf(attModel.attach));
                }
            }
        }
        
        if(count == attachmentModels.size()){
            masterCheckAttachment = true;
        }
        
        System.debug('##'+attachments);
    }
    
    public void checkAllRecords(){
        SobjectList = new List<SObject>();
        for(objModel objm : objModels){
            if(masterCheckRecord){
                SobjectList.add(objm.obj);
                objm.isChecked = true;
            }else{
                SobjectList.clear();
                objm.isChecked = false;
            }
        }
    }
    
    public void changeMasterCheckRecord(){
        Integer count = 0;
        SobjectList = new List<SObject>();
        
        for(objModel objm : objModels){
            if(objm.isChecked){
                count++;
                SobjectList.add(objm.obj);
            }else{
                masterCheckRecord = false;
                if(SobjectList.contains(objm.obj)){
                    SobjectList.remove(SobjectList.indexOf(objm.obj));
                }
            }
        }
        
        if(count == objModels.size()){
            masterCheckRecord = true;
        }
    }
    
    @testVisible class AttachmentModel{
        public Attachment attach{get;set;}
        public boolean isChecked{get;set;}
    }
    
    @testVisible class objModel{
        public String Name{get;set;}
        public SObject obj{get;set;}
        public boolean isChecked{get;set;}
    }
}