import { LightningElement, wire, api } from 'lwc';
import getPicklistValues from '@salesforce/apex/PicklistValues.getPicklistValues';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PicklistComponent extends LightningElement {
    @api objectApiName = 'Account';
    @api fieldApiName = 'Industry';
    @api picklistLabel = 'Picklist';
    @api selectedValue = '';
    @api placeholder = '';
    options = [];

    @wire(getPicklistValues, {objectApiName : '$objectApiName', fieldApiName: '$fieldApiName'})
    getPicklistValues({error, data}){
        if(error){
            this.showToastEvent('Error', error.body.message, 'error')
        }else if(data){
            let arr = [];
            console.log('Data = ', data);
            Object.keys(data).forEach(currentItem => {
                arr.push({label : currentItem, value : data[currentItem]})
            });
            console.log('arr = ', arr);
            this.options = arr;
        }
    }


    showToastEvent(title, message, variant, mode){
        if(!mode){
            mode = 'dismissible';
        }
        this.dispatchEvent(new ShowToastEvent({
            title : title,
            message : message,
            variant : variant,
            mode : mode
        }))
    }

    handleChange(event){
        this.selectedValue = event.target.value;
        this.dispatchEvent(new CustomEvent('selectedvalue', {detail : this.selectedValue}));
    }
}