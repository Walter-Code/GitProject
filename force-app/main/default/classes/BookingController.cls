public class BookingController {
    public Booking__c booking 
    {get;set;}
    public List<Booking__c> multipleBookings{get;set;}
    
    public BookingController()
    {
        booking = new Booking__c();
        multipleBookings = new List<Booking__c>();
        multipleBookings.add(booking);
    	String bid = ApexPages.currentPage().getParameters().get('bid');
    	//System.debug(bid);
        if(string.isNotBlank(bid))
        {
            try{
            booking = [Select id,Customer__c,Customer_Email__c,Room_No__c,Status__c,
                       Check_In_Time__c,Check_Out_Time__c,Total_Hours__c,Amount__c 
                       from Booking__c where Id =: bid];
            }catch(Exception e){
                booking = new booking__c();
            }
        }
        
        //bookings = new List<Booking__c>();          
    }
    
    public void AddBooking()
    {
        booking = new Booking__c();
        multipleBookings.add(booking);
    }
    
    public void removeBooking()
    {
        multipleBookings.remove(multipleBookings.size()-1);
    }
    
    public PageReference save()
    {
        /*if(booking.id != null)
        {
            update booking;
        }
        else
        {
         	insert booking;   
        }*/
        
         try
        {
            upsert multipleBookings;
        }        
        catch(Exception ex){
            //Handle exception
            Apexpages.addMessages(ex);
            return null;
        }
        
        PageReference pg = new PageReference('/apex/BookingListCustom');
        return pg;
        
    }
    
    public PageReference saveAndNew()
    {
        try
        {
            upsert booking;
        }        
        catch(Exception ex){
            //Handle exception
            Apexpages.addMessages(ex);
            return null;
        }
        //upsert booking;
        PageReference pg = new PageReference('/apex/AddBooking');
        pg.setRedirect(true);
        return pg;
    }
}