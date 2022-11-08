public class AccountListWithFieldSetController {
    public List<Account> accounts{get;set;}
    
    public AccountListWithFieldSetController(){
        List<Schema.FieldSetMember> fsList = SObjectType.Account.fieldSets.Account_Field_Set.getFields();
        String query = 'Select Id ';
        for(Schema.FieldSetMember f : fsList){
            query += ' , ' + f.getFieldPath();
        }
        query += ' from Account';
        System.debug('##'+query);
        accounts = Database.query(query);
        /*https://salesforce.stackexchange.com/questions/1474/how-to-get-fieldset-fields-in-apex-dynamically-fieldset-name-is-not-static#:~
		:text=String%20fieldSetName%20%3D%20'Account_FieldSet'%3B,all%20fields%20from%20this%20fieldset.&text=SObjectType.,Account.*/
    }
}