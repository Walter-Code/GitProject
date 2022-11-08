public class OpportunityDetailController {
	
    public Opportunity OpportunityObj{get;set;}
    @testVisible String oid;
    public OpportunityDetailController(){
        oid = ApexPages.currentPage().getParameters().get('id');
        if(oid != null){
            try{
            	opportunityObj = [Select Id, Name, Amount, Stage_Type__c, OrderNumber__c, AccountId from Opportunity where Id =: oid];
            }catch(Exception e){
                
            }
        }
    }
}