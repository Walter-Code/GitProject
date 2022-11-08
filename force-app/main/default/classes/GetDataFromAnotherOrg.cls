@RestResource(urlMapping='/v1/getdata/*')
global class GetDataFromAnotherOrg {
    @HttpPost
    global static String getData(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        String requestBody  = RestContext.request.requestBody.toString();
        System.debug('Data = '+requestBody);
    	return 'Hello';
    }
}