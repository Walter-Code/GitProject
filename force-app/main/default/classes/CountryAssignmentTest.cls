@isTest
class CountryAssignmentTest {
    @isTest
    static void getCountriesList(){
        Country__c con = new Country__c(City__c = 'Ajmer');
        Map<Integer, Country__c> editCountries = new Map<Integer, Country__c>();
        editCountries.put(1, con);
        CountryAssignmentController.CountryModel cm = new CountryAssignmentController.CountryModel();
        cm.Country = con;
        cm.isChecked = false;
        cm.srno = 1;
        List<CountryAssignmentController.CountryModel> cmList = new List<CountryAssignmentController.CountryModel>();
		cmList.add(cm);
        
        CountryAssignmentController countryObj = new CountryAssignmentController();
        countryObj.editCountries = editCountries;
        countryObj.countries = cmList;
        countryObj.save();
        countryObj.tempSno = 1;
        countryObj.deleteRecord();
    }
    
   	@isTest
    static void getSaveButton(){
        Country__c con = new Country__c(City__c = 'Ajmer');
        CountryAssignmentController.CountryModel cm = new CountryAssignmentController.CountryModel();
        cm.Country = con;
        cm.isChecked = false;
        cm.srno = 1;
        List<CountryAssignmentController.CountryModel> cmList = new List<CountryAssignmentController.CountryModel>();
		cmList.add(cm);
        
        
        CountryAssignmentController countryObj = new CountryAssignmentController();
        countryObj.countries = cmList;
        countryObj.save();
        countryObj.editRecord();
        countryObj.deleteRecord();
    }
    
    @isTest
    static void deleteButton(){
        Integer temp;
        CountryAssignmentController countryObj = new CountryAssignmentController();
        countryObj.tempSno = temp;
    }
}