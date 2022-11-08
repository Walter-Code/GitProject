import { LightningElement, track } from 'lwc';
import pubsub from 'c/pubsub';
import deleteAccount from '@salesforce/apex/AccountController.deleteAccount';

export default class AccountRecordsListComponent extends LightningElement {
    @track accountList = [];
    connectedCallback(){
        pubsub.subscribe("show", message=> {
            this.accountList.push(message);
        })
    }

    deleteRecord(event){
        let delRecord = {};
        delRecord = this.accountList.filter( element => {
            return event.currentTarget.dataset.id == element.Id;
        })
        let index = this.accountList.indexOf(delRecord[0]);
        this.accountList.splice(index, 1);

        deleteAccount({acc : delRecord[0]})
        .then(result => {
            console.log(result);
        }).catch(error => {
            console.log(error);
        })
    }

    editRecord(event){
        let updateRecord = {};
        updateRecord = this.accountList.filter(element => {
            return event.currentTarget.dataset.id == element.Id;
        })
        let index = this.accountList.indexOf(updateRecord);
        this.accountList.splice(index, 1);

        pubsub.publish("update",updateRecord);
    }
}