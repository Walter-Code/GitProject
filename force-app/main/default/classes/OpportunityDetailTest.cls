@isTest
public class OpportunityDetailTest {
	@isTest
    static void getOpportunityDetail(){
        Opportunity op = new Opportunity();
        PageReference pg = Page.OpportunityDetailPage;
        pg.getParameters().put('0065g000002MiL0AAK',op.Id);
        Test.setCurrentPage(pg);
        OpportunityDetailController opp = new OpportunityDetailController();
        opp.OpportunityObj = op;
    }
}