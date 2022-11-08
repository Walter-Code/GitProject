public class ContactTaskDemoController {
    public Contact con{get;set;}
    public ContactTaskDemoController(){
        con = new Contact();
        String cid = ApexPages.currentPage().getParameters().get('cid');
    	if(String.isNotBlank(cid))
        {
            try{
            	con = [Select Id, AccountId, Birthdate, Email, Fax from Contact where id = :cid]; 
            }
            catch(Exception e){
                con = new Contact();
            }
        }
    }
}