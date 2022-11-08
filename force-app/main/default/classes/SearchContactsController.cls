/*
 	Name 		: 	SearchContactsController
	Date 		: 	4 March 2021
	Author 		: 	Vishal Chandnani
	Description : 	In this class I am fetching a list of Contacts and execute searching on the basis of email and name of 
					Contact and also displaying a checkbox on each record. When user select one option from the list and 
					tick the checkboxes, then that particular records will be updated. After that I add sorting on the
					click of header of each column and also applying custom pagination.
*/

public class SearchContactsController {
    public List<ContactModel> contactModelList {get;set;}
    public String searchValue {get;set;}
    public String selectedValue {get;set;}
    public Integer start {get;set;}
    public Integer pageSize {get;set;}
    public String selectedField {get;set;}
    public Integer remainingRecords {get;set;}
    
    String tempName;
    public String sortOrder {get;set;}
    List<ContactModel> contactModelTempList;
    
    public SearchContactsController(){
        pageSize = 5;
        contactModelTempList = new List<ContactModel>();
        contactModelList = new List<ContactModel>();
        fetchContacts();
    }
    
    public void fetchContacts(){
        /*---------------getContacts----------------*/
        contactModelTempList.clear();
        String query = 'SELECT Id, Name, Email, Account.Name, Phone, Type__c FROM Contact';
        if(String.isNotBlank(searchValue)){
            query += ' WHERE name LIKE \'%' + searchValue + '%\' OR email LIKE \'%' + searchValue + '%\'';
        }
        query += ' LIMIT 100';
        List<Contact> contacts = Database.query(query);
        
        /*------------Filling Data in contactModelTempList---------------*/
        for(Contact contactRecord : contacts){
            ContactModel cm = new ContactModel();
            cm.contactRecord = contactRecord;
            cm.isChecked = false;
            contactModelTempList.add(cm);
        }
        
        fetchContactModelList();
        
        if(contactModelTempList.size() == 0){
            Apexpages.addMessage(new ApexPages.Message(Apexpages.Severity.INFO, 'No Record Found'));
        }
    }
    
    public void fetchContactModelList(){
        start = 0;
        contactModelList.clear();
        for(Integer i = 0; i < pageSize && i < contactModelTempList.size(); i++){
            contactModelList.add(contactModelTempList.get(i));
        }
        remainingRecords = contactModelTempList.size() - Math.mod(contactModelTempList.size(), pageSize);
    }
    
    /*------------------Adding PickList Values----------------------------*/
    public List<SelectOption> getOptions(){
        List<SelectOption> tempOptions = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Contact.Type__c.getDescribe();
        List<Schema.PicklistEntry> pickList = fieldResult.getPicklistValues();
       
        tempOptions.add(new SelectOption('','--None--'));
        for(Schema.PicklistEntry ple : pickList){
        	tempOptions.add(new SelectOption(ple.getLabel(), ple.getValue()));
        }
        return tempOptions;
    }
    
    /*---------------------------------Save Click ----------------------------*/
    public PageReference updateRecords(){
        if(String.isBlank(selectedValue)){
        	Apexpages.addMessage(new ApexPages.Message(Apexpages.Severity.FATAL, 'Please Select at Least One Type'));
        	return null;
        }
        
		List<Contact> contacts = new List<Contact>();
        for(ContactModel cm : contactModelTempList){
            if(cm.isChecked){
                cm.contactRecord.Type__c = selectedValue;
                contacts.add(cm.contactRecord);
                cm.isChecked = false;
            }
        }
        if(contacts.size() > 0){
            update contacts;
            return null;
        }else{
            Apexpages.addMessage(new ApexPages.Message(Apexpages.Severity.FATAL, 'Please Select at Least One Record'));
        	return null;
        }
   	}
    
    /*--------------------------Sorting-------------------------*/
    public void sortList(){
        if(tempName != selectedField){
            sortOrder = 'asc';
        }else{
            sortOrder = (sortOrder == 'asc') ? 'desc':'asc';
        }
        String query = 'SELECT Id, Name, Email, Account.Name, Phone, ';
        query += 'Type__c FROM Contact ORDER BY '+ selectedField + ' '+ sortOrder;
        
        contactModelTempList.clear();
        for(Contact contactRecord : Database.query(query)){
            ContactModel cm = new ContactModel();
            cm.contactRecord = contactRecord;
            cm.isChecked = false;
            contactModelTempList.add(cm);
        }
        
        tempName = selectedField;
        fetchContactModelList();
    }
    
    /*---------------Page Size PickList--------------------------*/
    public List<SelectOption> getPageSizeList(){
        return new List<SelectOption>{new SelectOption('5','5'), 
            						  new SelectOption('10','10'),
            						  new SelectOption('15','15'),
            						  new SelectOption('20','20')};
    }
    
    /*----------------------Custom Pagination------------------------------*/
    public void first(){
        if(start > 0){
            contactModelList.clear();
         	start = 0;
            
            for(Integer i = start; i < pageSize; i++){
                contactModelList.add(contactModelTempList.get(i));
            }
        }
    }
    
    public void previous(){
        if(start > 0){
            contactModelList.clear();
            start -= pageSize;
            
            for(Integer i = start; i < pageSize+start; i++){
                contactModelList.add(contactModelTempList.get(i));
            }
        }
    }
    
    public void next(){
        if(start < remainingRecords){
        	contactModelList.clear();
            start += pageSize;
            
            for(Integer i = start; i < pageSize+start && i<contactModelTempList.size(); i++){
                contactModelList.add(contactModelTempList.get(i));
            }
        }
         
    }
    
    public void last(){
        if(start < remainingRecords){
        	contactModelList.clear();
            start = remainingRecords;
            
            for(Integer i = start; i < contactModelTempList.size(); i++){
                contactModelList.add(contactModelTempList.get(i));
            }
        }
    }
    
    class ContactModel{
        public Contact contactRecord {get;set;}
        public Boolean isChecked {get;set;}
    }
}