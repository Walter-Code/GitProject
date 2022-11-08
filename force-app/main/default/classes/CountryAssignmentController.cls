public class CountryAssignmentController {
    public Map<Integer, Country__c> editCountries{get;set;}
    public Country__c addCountry{get;set;}
    public List<CountryModel> countries{get;set;}
    public Integer tempSno{get;set;}
    public boolean editChecked{get;set;}
    Integer i;
    public CountryAssignmentController(){
        editChecked = false;
        i = 0;
        tempSno = 0;
        addCountry = new Country__c();
        countries = new List<CountryModel>();
    }
    
    public void save(){
        CountryModel cm = new CountryModel();
        if(tempSno == 0){
            cm.Country = addCountry;
            cm.srno = ++i;
            cm.isChecked = false;
            countries.add(cm);
        }
        else{
            cm.Country = addCountry;
        }
        tempSno = 0;
        addCountry = new Country__c();
    }
    
    public void editRecord(){
        for(CountryModel cm : countries){
            if(cm.srno == tempSno){
                addCountry = cm.country;
            }
        }
    }
    
    public void deleteRecord(){
        Integer temp = 0;
        for(CountryModel cm : countries){
            if(cm.srno == tempSno){
                break;
            }
            temp++;
        }
        countries.remove(temp);
        if(tempSno == temp){
            tempSno = 0;
        }
    }
    
    public void MultipleDelete(){
        Integer temp = 0;
        List<Integer> ids = new List<Integer>();
        for(CountryModel cm : countries){
            if(cm.isChecked){
                ids.add(temp);
            }
            temp++;
        }
        //System.debug(ids);
        Integer j = 0;
        for(Integer i : ids){
            i = i - j;
            countries.remove(i);
            j++;
        } 
    }
    
    public void multipleEdit(){
        editChecked = true;
        editCountries = new Map<Integer, Country__c>();
        //Integer temp = 0;
        for(CountryModel cm : countries){
            if(cm.isChecked){
                editCountries.put(cm.srno, cm.Country);
            }
            //temp++;
        }
    }
    
    public void saveMultipleEdit(){
        //Integer temp = 0;
        for(CountryModel cm : countries){
            if(editCountries.get(cm.srno) != null){
                cm.Country = editCountries.get(cm.srno);
                cm.isChecked = false;
            }
            //temp++;
        }
        editChecked = false;
    }
    
    @testVisible class CountryModel{
        public Country__c Country{get;set;}
        public Integer srno{get;set;}
        public boolean isChecked{get;set;}
    }
    
    public PageReference submit(){
        List<Country__c> addCountries = new List<Country__c>();
        for(CountryModel cm : countries){
            addCountries.add(cm.country);
        }
        try{
        	insert addCountries;
        }
        catch(Exception e){
            ApexPages.addMessages(e);
        }
        PageReference pg = new PageReference('/apex/CountryAssignment');
        pg.setRedirect(true);
        return pg;
    }
}