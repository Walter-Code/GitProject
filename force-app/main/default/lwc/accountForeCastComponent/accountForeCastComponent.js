import { LightningElement, api, wire } from 'lwc';
//Getting fields of account from Salesforce Schema to eliminate the dependency of apex class.
import FORECAST_FIELD from "@salesforce/schema/Account.Forecast__c";
import FORECAST_ICON_FIELD from "@salesforce/schema/Account.Forecast_Icon__c";
import FORECAST_TEMPERATURE_FIELD from "@salesforce/schema/Account.Temperature__c";
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
const fields = [FORECAST_FIELD, FORECAST_ICON_FIELD, FORECAST_TEMPERATURE_FIELD];

export default class AccountForeCastComponent extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields })
    account;

    //Created getter method so it can be accessible by HTML without creating any property.
    get forecast() {
        return getFieldValue(this.account.data, FORECAST_FIELD);
    }

    get forecastIcon() {
        return getFieldValue(this.account.data, FORECAST_ICON_FIELD);
    }

    get forecastTemperature() {
        return getFieldValue(this.account.data, FORECAST_TEMPERATURE_FIELD);
    }
}