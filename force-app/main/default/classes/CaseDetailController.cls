public class CaseDetailController {
    public Case caseObj{get;set;}
    @testVisible String csid;
    public CaseDetailController(){
        csid = ApexPages.currentPage().getParameters().get('id');
        getDetail(csid); 
    }
   	
    @testVisible void getDetail(String csid){
        if(csid != null){
            try{
                caseObj = [Select Id, Subject, Status, Type, Origin, AccountId from Case where Id =: csid];
            }catch(Exception e){
                
            }
        }
    }
}