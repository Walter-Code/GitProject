import { LightningElement, wire, api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import STATUS from '@salesforce/schema/Project__c.Status__c';

export default class ProjectStatusComponent extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: STATUS })
    projectRecord;

    get myStep(){
        return getFieldValue(this.projectRecord.data, STATUS);
    }
}