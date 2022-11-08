import { LightningElement, wire } from 'lwc';
import ACCOUNT_LIST from '@salesforce/apex/AccountListWithContactCountController.fetchAccountModelList';
export default class AccountListWithContactCountComponent extends LightningElement {
    isShowCount = true;
    

    @wire(ACCOUNT_LIST)
    accountModelList;

    showCount(event){
        console.log(event.target.checked);
        this.isShowCount = event.target.checked;
    }
}