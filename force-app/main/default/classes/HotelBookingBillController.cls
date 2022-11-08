public class HotelBookingBillController {
	
    public String renderValue{get;set;}
    public HotelBookingBillController(ApexPages.StandardController sc){
        
    }
    public void downloadClick(){
        renderValue = 'PDF';
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=BookingBill.pdf');
    }
}