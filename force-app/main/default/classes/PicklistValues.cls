public with sharing class PicklistValues {
    
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getPicklistValues(String objectApiName, String fieldApiName){
        Map<String, String> picklistValuesMap = new Map<String, String>();
        try {
            Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectApiName);
            Schema.DescribeSObjectResult res = convertToObj.getDescribe();
            List<Schema.PicklistEntry> picklistEntryList = res.fields.getMap().get(fieldApiName).getDescribe().getPicklistValues(); 
            for(Schema.PicklistEntry pickListVal : picklistEntryList){
                picklistValuesMap.put(pickListVal.getLabel(), pickListVal.getValue());
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return picklistValuesMap;
    }
}