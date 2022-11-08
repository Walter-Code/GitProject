public class BookingControllerAddMultiple 
{
    public Booking__c booking1 {get;set;}
    public Booking__c booking2 {get;set;}
    public Booking__c booking3 {get;set;}
    public List<Booking__c> bookings{get;set;}
    
    public BookingControllerAddMultiple()
    {
        bookings = new List<Booking__c>();
        bookings.add(booking1);
        bookings.add(booking2);
        bookings.add(booking3);
    }
    
    public PageReference save()
    {
        try{
            upsert bookings;
        }
        catch(Exception e)
        {
            ApexPages.addMessages(e);
            return null;
        }
        
        PageReference pg = new PageReference('/apex/BookingListCustom');
        return pg;
    }
}