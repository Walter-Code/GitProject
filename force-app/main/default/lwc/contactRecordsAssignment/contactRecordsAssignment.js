import { LightningElement, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/contactController.getContacts';

export default class ContactRecordsAssignment extends LightningElement {

    @track tempList;
    @track contactList;
    cities = [
        {label : "All Records", value : "All Records"},
        {label : "Ajmer", value : "Ajmer"},
        {label : "Jaipur", value : "Jaipur"},
        {label : "Kota", value : "Kota"},
        {label : "Alwar", value : "Alwar"}
    ];
    columns = [
        {label : "FirstName" , fieldName : "FirstName"},
        {label : "LastName" , fieldName : "LastName"},
        {label : "Email" , fieldName : "Email"},
        {label : "Contact No" , fieldName : "Phone"},
        {label : "City" , fieldName : "OtherCity"}
    ];
    selectedCity;

    @wire(getContacts, {})
    getContacts ({error, data}) {
        if (error) {
            // TODO: Error handling
        } else if (data) {
            this.tempList = data;
            this.contactList = data;
            console.log(JSON.parse(JSON.stringify(this.contactList)));
        }
    }

    handleChange(event){
        this.contactList = this.tempList;
        this.selectedCity = event.target.value;
        if(this.selectedCity != 'All Records'){
            this.contactList = this.contactList.filter(element => {
                return element.OtherCity == this.selectedCity;
            });
        }
    }
}