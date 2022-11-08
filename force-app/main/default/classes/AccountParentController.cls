public class AccountParentController {
    public Id accId{get;set;}
    
    public Account getAccountDetail(){
        if(accId != null){
        	return [Select Id, Name, Phone, Fax, Website, Type from Account where Id =: accId];    
        }else{
            return null;
        }
        
    }
}