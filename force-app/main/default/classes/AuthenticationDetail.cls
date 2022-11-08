public with sharing class AuthenticationDetail{
    /*End point Url to web service callout*/
    private final static String ENP_POINT_URL = 'https://test.salesforce.com/services/oauth2/token';
    //For development and production https://login.salesforce.com/services/oauth2/token
    //And for sandbox https://test.salesforce.com/services/oauth2/token
    private final static String REQUEST_BODY = 'grant_type=password&client_id={0}&client_secret={1}&username={2}&password={3}';
    private final static String USERNAME = 'akansha.bhatnagar-external@alfuttaim.admin.staging';
    private final static String PASSWORD = 'Corona@2019xGeXyERzOjNSZF7IrAYLgqSv';
    private final static String CONSUMER_KEY = '3MVG9RezSyZYLh2vvLft_JPyP6zoFKyiy8c.h.om_QRXaWWKl8zlo5te2XoIbjpiW8VYXZErmlxdRUBtuwm.B';
    private final static String CONSUMER_SECRET = '46050BA0BA556D80846254861FD9F0449FDDE5BC605C02C02F2B1C80A4CC51DB';
    
    /*To generate Access token Method*/
    public static OAuth getAccessToken(){
        try{
            HttpRequest req = new HttpRequest();
            req.setEndpoint(ENP_POINT_URL);
            req.setMethod('POST');          
            Blob headerValue = Blob.valueOf(USERNAME + ':' + PASSWORD);
            String authorizationHeader = 'BASIC ' +
            EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader); 
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            req.setBody(String.format(REQUEST_BODY ,new string[]{CONSUMER_KEY,CONSUMER_SECRET,
                                                                 USERNAME,PASSWORD}));
            req.setTimeout(60000);
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('Get Body = '+ res.getBody());
            OAuth objAuthenticationInfo = (OAuth)JSON.deserialize(res.getbody(), OAuth.class);
            System.debug(''+ objAuthenticationInfo.access_token.split('!'));
            System.debug('objAuthenticationInfo = ' + objAuthenticationInfo);
            return objAuthenticationInfo;
        }catch(CallOutException ce){
            throw ce;
        }
        //return null;
    }
    
    /*To get Access token property*/
    public static OAuth authenticationDetail{
        get{
            if(authenticationDetail == null){
                authenticationDetail = getAccessToken();
            }
            return authenticationDetail;
        }set;
    }
        
    /*To get aouthentication detail Wrapper*/
    public class OAuth{
        public String id{get;set;}
        public String issued_at{get;set;}
        public String instance_url{get;set;}
        public String signature{get;set;}
        public String access_token{get;set;}    
    }   
}