import { LightningElement } from 'lwc';
import sendMail from '@salesforce/apex/SendEmailController.sendMail';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class ContactForm extends LightningElement {
    subject = '';
    body = '';
    showModal = false;

    openModal(){
        this.showModal = true;
    }

    hideModal(){
        this.showModal = false;
    }
    
    subjectHandler(event){
            this.subject = event.target.value;
    }
    
    bodyHandler(event){
        this.body = event.target.value;		
    }
    
    submitform(){
        sendMail({subject : this.subject, body : this.body})
        .then(result => {
            const event = new ShowToastEvent({
                title: 'Email Sent',
                message: 'Email Sent Successfully',
                variant : 'success'
            });
            this.dispatchEvent(event);
            console.log(result);
            this.showModal = false;
        }).catch(error => {
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'Error while sending Email',
                variant : 'error'
            });
            this.dispatchEvent(event);
            console.log(error);
            this.showModal = false;
        })
    }
}