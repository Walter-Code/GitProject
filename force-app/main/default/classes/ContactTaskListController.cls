public class ContactTaskListController {
    public List<Task> tasks{get;set;}
    public String ids{get;set;}
    String cid;
    public boolean id{get;set;}
    public List<Task> tasksUpdate{get;set;}
    public ContactTaskListController(){
        tasks = [Select id, WhoId, WhatId, OwnerId from task where WhoId = null];
        cid = ApexPages.currentPage().getParameters().get('cid');
        System.debug('## '+tasks);
    }
    
    public PageReference save(){
        System.debug('## '+task.Id);
        try{
            for(Task a : tasks){
                String tempCid = ApexPages.currentPage().getParameters().get(a.Id);
                if(tempCid != null){
                    a.WhoId = cid;     
                }
            }
            upsert tasks;
        }catch(Exception e){
            ApexPages.addMessages(e);
        }
        PageReference pg =  new PageReference('/lightning/r/Contact/'+cid+'/view');
        return pg;
    }
    
}