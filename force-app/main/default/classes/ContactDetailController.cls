public class ContactDetailController {
    public Contact contactObj{get;set;}
    
    public ContactDetailController(){
        String cid = ApexPages.currentPage().getParameters().get('id');
        if(cid != null){
            try{
            	contactObj = [Select Id, Name, Email, Phone, Fax, AccountId from Contact where Id =: cid];
            }catch(Exception e){
                
            }
        }
    }
}