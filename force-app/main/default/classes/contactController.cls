public inherited sharing class contactController {
    
    @AuraEnabled(cacheable = true)
    public static List<Contact> getContacts(){
        return [SELECT Id, FirstName, LastName, Email, Phone, OtherCity FROM Contact];
    }
}