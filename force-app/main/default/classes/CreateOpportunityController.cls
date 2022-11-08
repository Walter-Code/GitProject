public class CreateOpportunityController {

    @AuraEnabled
    public static List<String> getFieldsFromFieldSet(String fieldSetApiName, String objectApiName){
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectApiName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        
        List<String> fieldsApiNames = new List<String>();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetApiName);
        for(Schema.FieldSetMember fieldSetMemberObj : fieldSetObj.getFields()){
            fieldsApiNames.add(fieldSetMemberObj.getFieldPath());
        }
        return fieldsApiNames;
    }
}