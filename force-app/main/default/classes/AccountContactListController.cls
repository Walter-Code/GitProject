public class AccountContactListController {
    public String sObj{get;set;}
    public Integer pgVar{get;set;}
    public List<sObject> sObjectList;
    public Integer pgNo{get;set;}
    
    public AccountContactListController(){
        pgVar = 0;
        pgNo = 1;
    }
    
    public List<sObject> getSObjectList(){
        String query = 'Select Id, Name, Phone From '+sObj;
        sObjectList = Database.query(query);
        return sObjectList;
    }
    
    public void next(){
        if(pgVar < sObjectList.size()-Math.mod(sObjectList.size(), 10)){
            pgVar+=10;
            pgNo = pgVar/10 + 1;
        }	
    }
    
    public void previous(){
        if(pgVar > 0){
            pgVar -= 10;
            pgNo -= 1;
        }
    }
    
    public void first(){
        pgVar = 0;
        pgNo = 1;
    }
    
    public void last(){
        pgVar = sObjectlist.size() - Math.mod(sObjectlist.size(), 10);
        pgNo = pgVar/10 + 1;
    }
}