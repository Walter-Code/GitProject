/*
 	Name 		: 	ContactSearchController
	Date 		: 	1 March 2021
	Author 		: 	Vishal Chandnani
	Description : 	In this class I am fetching a list of Contacts
					and execute searching on the basis of email and name
					of Contact.
*/
public class ContactsSearchController {
    public List<Contact> contactList {get;set;}
    public String searchValue {get;set;}
    
    public ContactsSearchController(){
        contactList = [SELECT Id, Name, Email, Account.Name, Phone, Type__c FROM Contact LIMIT 100];
    }
    
    /*-----------------------Search Click Function-----------------------------*/
    public void searchContacts(){
        String nameEmailValue = '%' + searchValue + '%';
        contactList = [SELECT Id, Name, Email, Account.Name, Phone, Type__c 
                       FROM Contact 
                       WHERE name LIKE :nameEmailValue OR email LIKE :nameEmailValue LIMIT 100];
    }
}