public class UploadProfileController {
    public Attachment att{get;set;}
    public List<Attachment> showAttachment{get;set;}
    Id conId;
    public UploadProfileController(ApexPages.StandardController sc){
        conId = sc.getId();
        List<String> content = new List<String>{'image/jpeg','image/png'};
        showAttachment = [Select Id, ContentType,Name,Body from Attachment where parentId = :conId 
                          And ContentType In :content
                          order by LastModifiedDate desc limit 1];
        
        att = new Attachment(parentId = conId);
    }
    
    public void save(){
        insert att;
    }
}