public class UpdateContactMailingAddressController {
    public boolean isSubmit{get;set;}
    public List<Contact> contacts{get;set;}
    public List<SelectOption> accountList{get;set;}
    public Account account{get;set;}
    public Id tempId{get;set;}
    public boolean isSelected{get;set;}
    public UpdateContactMailingAddressController(){
        List<Account> accounts = [Select Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry 
                                 from Account];
        
        isSubmit = false;
        account = new Account();
        isSelected = false;
        accountList = new List<SelectOption>();
        for(Account acc : accounts){
            accountList.add(new SelectOption(acc.Id,acc.Name));
        }
    }
    
    public void changeAccount(){
        isSelected = true;
        isSubmit = false;
        account = [Select Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry 
                   from Account where Id = :tempId];
    }
    
    public void submit(){
        isSubmit = true;
     	contacts = [Select Id, Name, MailingStreet, MailingCity, MailingState,
           						 MailingPostalCode, MailingCountry from Contact where AccountId = :tempId];
        
        for(Contact con : contacts){
            con.MailingCity = account.BillingCity;
            con.MailingCountry = account.BillingCountry;
            con.MailingPostalCode = account.BillingPostalCode;
            con.MailingState = account.BillingState;
            con.MailingStreet = account.BillingStreet;
        }
        upsert account;
        upsert contacts;
    }
}