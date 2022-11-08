public class LogoutEventTriggerHelper {
    
    @future(callout=true)
    public static void httpServiceMethod(){
        /*Account acc1 = new Account(Name = 'Outside If Account');
        insert acc1;*/
        System.debug('Account Logged Out Successfully');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('Response = ' + response);
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Received the following animals:');
            for (Object animal: animals) {
                System.debug(animal);
            }
            Account acc = new Account(Name = '29 october logout check', Address__c = (String)animals[0]);
            insert acc;
            System.debug('Response = ' + response);
        }
    }
}