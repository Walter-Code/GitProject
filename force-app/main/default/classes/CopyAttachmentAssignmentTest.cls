@isTest
public class CopyAttachmentAssignmentTest {
	
    static List<CopyAttachmentAssignmentController.AttachmentModel> insertAttachmentModel(){
        CopyAttachmentAssignmentController.AttachmentModel attModel = new CopyAttachmentAssignmentController.AttachmentModel();
        attModel.attach = returnAttachmentObj();
        attModel.isChecked = false;
        List<CopyAttachmentAssignmentController.AttachmentModel> attModels = new List<CopyAttachmentAssignmentController.AttachmentModel>();
        attModels.add(attModel);
        return attModels;
    }
    
    static Attachment returnAttachmentObj(){
        Attachment att=new Attachment();   	
    	att.Name='Unit Test Attachment';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	att.body=bodyBlob;
        att.parentId='0015g0000047e4HAAQ';
        return att;
    }
    
    static void insertAttachmentObj(){
        Attachment att=new Attachment();   	
    	att.Name='Unit Test Attachment';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	att.body=bodyBlob;
        att.parentId='0015g0000047e4HAAQ';
        insert att;
    }
    
    @isTest
    static void constructorTesting(){
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
    }
    
    static List<CopyAttachmentAssignmentController.objModel> insertSObjectModel(Account acc){
        CopyAttachmentAssignmentController.objModel obj = new CopyAttachmentAssignmentController.objModel();
        obj.isChecked = false;
        obj.Name = 'Vishal';
        obj.obj = acc;
        List<CopyAttachmentAssignmentController.objModel> objList = new List<CopyAttachmentAssignmentController.objModel>();
        objList.add(obj);
        return objList;
    }
    
    @isTest
    static void getAttachmentsfun(){
        insertAttachmentObj();
		CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.selectedObject = 'Account';
        cpa.attachmentList = [Select Id, Name from Attachment];
        cpa.getAttachments();
    }
    
    @isTest
    static void showSearchButtonPositivefun(){
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.selectedObjectDemo = 'Account';
        cpa.showSearchButton();
    }
    
    @isTest
    static void showSearchButtonNegativefun(){
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.showSearchButton();
    }
    
    @isTest
    static void getObjectRecordsfun(){
        Account acc = new Account(Name = 'Vishal');
        insert acc;
        
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.selectedObjectDemo = 'Account';
        cpa.objectList = [Select Id, Name from Account];
        cpa.getObjectRecords();
    }
    
    @isTest
    static void showPopupNegativefun(){
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.showPopUp();
    }
    
    @isTest
    static void showPopupPositivefun(){
        insertAttachmentObj();
        
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.attachments = [Select Id, Name from Attachment];
        cpa.showPopUp();
    }
    
    @isTest
    static void hidePopupfun(){
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.hidePopUp();
    }
    
    @isTest
    static void searchRecordfun(){
        Account acc = new Account(Name = 'Vishal');
        insert acc;
		
        List<CopyAttachmentAssignmentController.objModel> objList = insertSobjectModel(acc);
        
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.objModelsTemp = objList;
        cpa.searchName = 'Vis';
        System.debug('##'+cpa.objModelsTemp);
        cpa.searchRecord();
    }
    
    @isTest
    static void copyTofun(){
        insertAttachmentObj();
        
        Account acc = new Account(Name = 'Vishal');
        insert acc;
        
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.attachments = [Select Id, Name, Body, ParentId, ContentType from Attachment];
        cpa.SobjectList = [Select Id from Account];
        cpa.toCopy();
    }
    
    @isTest
    static void checkAllRecordsPositivefun(){
        Account acc = new Account(Name = 'Vishal');
        insert acc;
        List<CopyAttachmentAssignmentController.objModel> objList = insertSobjectModel(acc);
        
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.masterCheckRecord = true;
        cpa.objModels = objList;
        cpa.checkAllRecords();
    }
    
    @isTest
    static void checkAllRecordsNegativefun(){
        Account acc = new Account(Name = 'Vishal');
        insert acc;
        List<CopyAttachmentAssignmentController.objModel> objList = insertSobjectModel(acc);
        
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.masterCheckRecord = false;
        cpa.objModels = objList;
        cpa.checkAllRecords();
    }
    
    @isTest
    static void checkAllAttachmentsfun(){
        List<CopyAttachmentAssignmentController.AttachmentModel> attModels = insertAttachmentModel();
        CopyAttachmentAssignmentController cpa = new CopyAttachmentAssignmentController();
        cpa.attachmentModels = attModels;
        cpa.masterCheckAttachment = true;
        cpa.checkAllAttachments();
        cpa.changeMasterCheckAttachment();
        cpa.masterCheckAttachment = false;
        cpa.checkAllAttachments();
        cpa.changeMasterCheckRecord();
    }
}