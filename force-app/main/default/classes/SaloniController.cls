public class SaloniController {
	public List<Selectoption> countries{get;set;}
    public String selectedcountry{get;set;}
    list <country__c> countrydata ;
    public SaloniController(){
        countries = new List<Selectoption>();
        countrydata =[select name , state__C , city__C from country__c];
        loadData();
    }	
     public void loadData(){
         for(country__C coun : countrydata){
            countries.add(new selectoption (coun.name.toLowercase(),coun.name.toLowercase()));
               }
    }
    public void fetchStates(){
        system.debug('@@');
    }
}