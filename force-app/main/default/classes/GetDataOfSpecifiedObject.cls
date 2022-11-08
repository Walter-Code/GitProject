@RestResource(urlMapping='/api/getdata/*')
global with sharing class GetDataOfSpecifiedObject {
    
    @HttpGet
    global static List<SObject> doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String objectName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        String query = 'SELECT Id, CreatedBy.Name FROM ' + objectName;
        List<sObject> objList = Database.query(query);
        System.debug('objList ==> ' + objList);
        return objList;
    }
    
}