trigger HireFormTrigger on Hire_Form__c (before insert, after update) {	
    List<Case> cases = new List<Case>();
    if(trigger.isInsert){
        List<Contact> contacts = new List<Contact>();
        
        for(Hire_Form__c hf : trigger.new){
            Contact con = new Contact();
            con.FirstName = hf.First_Name__c;
            con.LastName = hf.Last_Name__c;
            con.Email = hf.Email__c;
            con.Phone = hf.Phone__c;
            hf.Status__c = 'In-Progress';
            contacts.add(con);
        }
        
        insert contacts;
        
        for(Integer i=0; i<trigger.new.size(); i++){
            trigger.new.get(i).Candidate__c = contacts.get(i).Id;
            Case cs = new Case();
            cs.ContactId = contacts.get(i).Id;
            cs.Status = 'New';
            cs.Origin = 'Web';
            cases.add(cs);
        }
        
        insert cases;   
    }
    
    if(trigger.isUpdate){
        cases.clear();
        Set<Id> contactIds = new Set<Id>();
        
        for(Hire_Form__c hf : trigger.new){
            if(hf.Status__c == 'completed'){
            	contactIds.add(hf.Candidate__c);    
            }
        }
        
        if(contactIds.size()>0){
         	cases = [Select Id, Status from Case where ContactId In : contactIds];   
        }
        
        for(Case cs : cases){
            cs.Status = 'Closed';
        }
        
        upsert cases;
    }
}