public class CustomAttachmentController {
    public blob addFile{get;set;}
    
    public void save(){
        System.debug(addFile);
        Attachment attach = new Attachment();
        attach.Name = 'demo.txt';
        attach.ParentId = '0035g000002ftoMAAQ';
        attach.Body = addFile;
        upsert attach;
    }
}