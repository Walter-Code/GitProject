global class FlowClass {

    @InvocableMethod
    public static void checkLoginFlow(){
        System.debug('Flow Running Successfully');
        //logout();
    }
    
    public static pagereference logout(){
       //perform Business logic here
        PageReference pageRef = new PageReference('/default/secur/logout.jsp');
        pageRef.setRedirect(true);
        return pageRef;
    }
}