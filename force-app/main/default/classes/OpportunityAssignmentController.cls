public class OpportunityAssignmentController {
    public List<OpportunityModel> opportunityModels{get;set;}
    
    public OpportunityAssignmentController(){
        opportunityModels = new List<OpportunityModel>();
    	List<Opportunity> opportunities = [Select Id, Name, Amount, Type from Opportunity];
        List<AggregateResult> aggAmount = [Select count(Id) countRecord, sum(Amount) sumAmounts, max(Amount) maxAmount, min(Amount) minAmount,
                                           avg(Amount) avgAmount, StageName from Opportunity group By StageName];
        
        for(AggregateResult agg : aggAmount){
            OpportunityModel op = new OpportunityModel();
            op.sumAmount = (Decimal)agg.get('sumAmounts');
            op.maxAmount = (Decimal)agg.get('maxAmount');
            op.minAmount = (Decimal)agg.get('minAmount');
            op.avgAmount = (Decimal)agg.get('avgAmount');
            op.StageName = (String)agg.get('StageName');
            op.countRecord = (Integer)agg.get('countRecord');
            opportunityModels.add(op);
        }
    }
    
    class OpportunityModel{
        public Decimal sumAmount{get;set;}
        public Decimal maxAmount{get;set;}
        public Decimal minAmount{get;set;}
        public Decimal avgAmount{get;set;}
        public Integer countRecord{get;set;}
        public String StageName{get;set;}
    }
}