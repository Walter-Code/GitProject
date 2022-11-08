public class ContactShiftingAssignmentController {
    public List<ContactModel> contactRelatedModels{get;set;}
    public List<ContactModel> contactNotRelatedModels{get;set;}
    public boolean masterCheck{get;set;}
    public boolean masterCheck2{get;set;}
    
    List<Contact> removeContacts;
    List<Contact> addContacts;
    public Id accId{get;set;}
    public ContactShiftingAssignmentController(ApexPages.StandardController sc){
        removeContacts = new List<Contact>();
        addContacts = new List<Contact>();
        
       	accId = sc.getId();
        contactRelatedModels = new List<ContactModel>();
        contactNotRelatedModels = new List<ContactModel>();
            
    	List<Contact> contactsRelated = [Select Id, Name From Contact where accountId = :accId];
        List<Contact> contactsNotRelated = [Select Id, Name From Contact where accountId = null];
        
        for(Contact con : contactsRelated){
            ContactModel cm = new ContactModel();
            cm.con = con;
            cm.isChecked = false;
            contactRelatedModels.add(cm);
        }
        
        for(Contact con : contactsNotRelated){
            ContactModel cm = new ContactModel();
            cm.con = con;
            cm.isChecked = false;
            contactNotRelatedModels.add(cm);
        }
    }
    
    public void RemoveId(){
        removeContacts = new List<Contact>();
        List<Integer> index = new List<Integer>();
        for(ContactModel cm : contactRelatedModels){
            if(cm.isChecked){
                ContactModel cnm = new ContactModel();
                cnm.con = cm.con;
                cnm.isChecked = false;
                ContactNotRelatedModels.add(cnm);
                removeContacts.add(cm.con);
                index.add(contactRelatedModels.indexOf(cm));
            }
        }
        Integer j = 0;
        for(Integer i : index){
            i -= j;
            contactRelatedModels.remove(i);
            j++;
        }
    }
    
    public void AddId(){
        addContacts = new List<Contact>();
        List<Integer> index = new List<Integer>();
        for(ContactModel cm : contactNotRelatedModels){
            if(cm.isChecked){
                ContactModel cnm = new ContactModel();
                cnm.con = cm.con;
                cnm.isChecked = false;
                ContactRelatedModels.add(cnm);
                addContacts.add(cm.con);
                index.add(contactNotRelatedModels.indexOf(cm));
            }
        }
        
        Integer j = 0;
        for(Integer i : index){
            i -= j;
            contactNotRelatedModels.remove(i);
            j++;
        }
    }
    
    public void submit(){
        for(Contact con : removeContacts){
            con.AccountId = null;
        }
        
        for(Contact con : addContacts){
            con.AccountId = accId;
        }
        
        upsert removeContacts;
        upsert addContacts;
    }
    
    public void checkAll(){
        for(ContactModel cm : contactRelatedModels){
            if(masterCheck){
                cm.isChecked = true;
            }
            else{
                cm.isChecked = false;
            }
        }
    }
    
    public void checkAll2(){
        for(ContactModel cm : contactNotRelatedModels){
            if(masterCheck2){
                cm.isChecked = true;
            }
            else{
                cm.isChecked = false;
            }
        }
    }
    
    public void changeMasterCheck(){
        Integer count = 0;
        for(ContactModel cm : ContactRelatedModels){
            if(!cm.ischecked){
                masterCheck = false;
            }
            else{
                count++;
            }
        }
        if(count == ContactRelatedModels.size()){
            masterCheck = true;
        }
    }
    
    public void changeMasterCheck2(){
        Integer count = 0;
        for(ContactModel cm : ContactNotRelatedModels){
            if(!cm.isChecked){
                masterCheck2 = false;
            }
            else{
                count++;
            }
        }
        if(count == ContactNotRelatedModels.size()){
            masterCheck2 = true;
        }
    }
    
    class ContactModel{
        public Contact con{get;set;}
        public boolean isChecked{get;set;}
    }
}