import { LightningElement, wire } from 'lwc';
import ACCOUNT_RECORDS from '@salesforce/apex/AccountController.getAccounts';


export default class AccountListComponent extends LightningElement {
    accounts;
    contacts;

    @wire(ACCOUNT_RECORDS)
    fetchAccounts({error, data}) {
        if (error) {
            // TODO: Error handling
        } else if (data) {
            console.log({...data});
            this.accounts = data;
        }
    }
}