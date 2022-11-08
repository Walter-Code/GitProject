import { LightningElement } from 'lwc';

export default class TestPicklistComponent extends LightningElement {
    
    handleSelectedValue(event){
        console.log('Selected Value = ', event.detail);
    }
}