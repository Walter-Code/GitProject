import { LightningElement } from 'lwc';

export default class FatherComponent extends LightningElement {
    msg;
    displayMessage(event){
        this.msg = event.detail;
    }
}