public class CountryController {
    List<Country__c> countries;
    public String selectedCountry{get;set;}
    public String selectedState{get;set;}
    public List<SelectOption> countryoptions{get;set;}
    public List<SelectOption> stateOptions{get;set;}
    public List<SelectOption> cityOptions{get;set;}
    Map<String , Set<String>> cityStateMap;
    public CountryController(){
        countries = [Select Id, Name, State__c, City__c from Country__c order by Name];
        countryoptions = new List<SelectOption>();
        loadCountry();
    }
	
    void loadCountry(){
        Country__c temp = new Country__c();
        countryoptions.add(new SelectOption('--None--','--None--'));
        for(Country__c con : countries){
            if((temp.name != null? temp.name.toUpperCase() : temp.name) != con.name){
                countryoptions.add(new SelectOption(con.Name, con.Name));
            }
            temp = con;
        }
    }
    
    void loadStates(){
        cityStateMap = new Map<String , Set<String>>();
        Set<String> stateList;
        Country__c temp = new Country__c();
        for(Country__c con : countries){
            temp = con;
            if(temp.name.toUpperCase() == con.name.toUpperCase()){
                stateList = cityStateMap.get(con.Name);
                if(stateList == null){
                    stateList = new Set<string>();
                }
                stateList.add(con.State__c);
                cityStateMap.put(con.Name, stateList);
            }
            else{ break; }
        }
    }
    
    void loadCities(){
        cityStateMap = new Map<String , Set<String>>();
        Set<String> cityList;
        Country__c temp = new Country__c();
        for(Country__c con : countries){
            temp = con;
            if(temp.State__c.toUpperCase() == con.State__c.toUpperCase()){
                cityList = cityStateMap.get(con.state__c);
                if(cityList == null){
                    cityList = new Set<string>();
                }
                cityList.add(con.city__c);
                cityStateMap.put(con.state__c, cityList);
            }
            else{ break; }
        }
    }
    
    public void fetchStates(){
        loadStates();
        System.debug('## '+selectedCountry);
        stateoptions = new List<SelectOption>();
        set<String> states = cityStateMap.get(selectedCountry);
        if(states != null){
            stateoptions.add(new SelectOption('','--None--'));
            for(String state : states){
                stateOptions.add(new SelectOption(state, state));
            }
        }
        cityOptions = new List<SelectOption>();
    }
    
    public void fetchCities(){
        loadCities();
        System.debug('$$ '+selectedState);
        cityOptions = new List<SelectOption>();
        cityOptions.add(new SelectOption('','--None--'));
        Set<String> cities = cityStateMap.get(selectedState);
        if(cities != null){
            for(String city : cities){
                cityoptions.add(new SelectOption(city, city));
            }
        }
    }
}