import { LightningElement } from 'lwc';

export default class C2pParentComponentAssignment extends LightningElement {
    showSection = false;
    count = 0;
    countries = '';
    showDetails(event){
        this.showSection = true;
        this.count = event.detail[1];
        this.countries = event.detail[0];
    }
}