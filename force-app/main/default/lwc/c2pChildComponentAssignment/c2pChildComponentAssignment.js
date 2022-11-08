import { LightningElement,track,api } from 'lwc';

export default class C2pChildComponentAssignment extends LightningElement {
    count = 0;
    countries = '';
    @api tempList = [];
    @track theList = [
        {
            id : 0,
            src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg",
            capital : "Delhi",
            continent : "Asia",
            population : "1.35 Billion",
            isChecked : false
        },
        {
            id : 1,
            src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg",
            capital : "New York",
            continent : "North America",
            population : "1.35 Billion",
            isChecked : false
        },
        {
            id : 2,
            src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg",
            capital : "London",
            continent : "UK",
            population : "1.35 Billion",
            isChecked : false
        }
    ]
 
    submit(){
        this.countries = '';
        this.theList.forEach(element => {
            if(element.isChecked){
                this.countries += ' ' + element.capital + ' ';
            }
        })
         const tempEvent = new CustomEvent("showdetails",{detail : [this.countries, this.count]});
         this.dispatchEvent(tempEvent);
 
    }
 
    checkboxChanged(event){
        let index = parseInt(event.target.value);
        if(event.target.checked){
             this.theList[index].isChecked = event.target.checked;   
             this.count++;
        }else{
             this.theList[index].isChecked = event.target.checked;   
             this.count--;
        }
 
    }
}