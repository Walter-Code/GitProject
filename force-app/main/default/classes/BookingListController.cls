public class BookingListController {
	public List<Booking__c> bookings{get;set;} 
    integer count = 0;
    public List<Booking__c> demo{get;set;}
    public BookingListController()
    {
        bookings = [Select id,Customer__c,Customer_Email__c,Room_No__c,Status__c,
                    Check_In_Time__c,Check_Out_Time__c,Total_Hours__c,Amount__c 
                    from Booking__c];
        demo = 	[Select id,Customer__c,Customer_Email__c,Room_No__c,Status__c,
                Check_In_Time__c,Check_Out_Time__c,Total_Hours__c,Amount__c 
                from Booking__c Order By id limit 10];
    }
    
    public PageReference Beginning(){
        count = 0;
        demo = [Select id,Customer__c,Customer_Email__c,Room_No__c,Status__c,
                Check_In_Time__c,Check_Out_Time__c,Total_Hours__c,Amount__c 
                from Booking__c Order By id limit 10];
        return new PageReference('/apex/BookingListCustom');
    }
    
    public PageReference End(){
        count = bookings.size()/10;
        integer size = math.mod(bookings.size(), 10);
        if(size<=0)
            size = 10;
        demo = [Select id,Customer__c,Customer_Email__c,Room_No__c,Status__c,
               Check_In_Time__c,Check_Out_Time__c,Total_Hours__c,Amount__c 
               from Booking__c Order By id desc limit :size];
        return new PageReference('/apex/BookingListCustom');
    }
    
    public PageReference MyNext(){
        if(count < bookings.size()/10)
        {
            count++;
            integer size = count * 10;
            if(size >= bookings.size())
            {
                size -= 10;
                count--;
            }   
            demo = [Select id,Customer__c,Customer_Email__c,Room_No__c,Status__c,
              	   Check_In_Time__c,Check_Out_Time__c,Total_Hours__c,Amount__c 
                   from Booking__c Order By id limit 10 Offset :size];
            return new PageReference('/apex/BookingListCustom');
        }
        return null;
    }
    
    public PageReference MyPrevious(){
        if(count > 0){
            count--;
            integer size = count * 10;
            demo = [Select id,Customer__c,Customer_Email__c,Room_No__c,Status__c,
              	   Check_In_Time__c,Check_Out_Time__c,Total_Hours__c,Amount__c 
                   from Booking__c Order By id limit 10 Offset :size];
            return new PageReference('/apex/BookingListCustom');
        }
        return null;
    }
}