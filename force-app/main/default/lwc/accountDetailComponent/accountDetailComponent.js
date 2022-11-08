import { LightningElement, wire, track } from 'lwc';
import addAccount from '@salesforce/apex/AccountController.addAccount';
import newAccount from './newAccount.html';
import pubsub from 'c/pubsub';

export default class AccountDetailComponent extends LightningElement {

    newAccountBtn = true;
    saveBtn = false;
    connectedCallback(){
        pubsub.subscribe("update", record => {
            this.newAcc = {};
            this.newAcc = record[0];
            if(Object.keys(this.newAcc).length != 0){
                this.newAccountBtn = true;
                this.saveBtn = false;
            }
        })
    }

    @track newAcc = {}

    saveClick(){
        const inputElement = this.template.querySelectorAll('lightning-input');
        
        [...inputElement].forEach(element => {
            this.newAcc[element.label] = element.value;
        });
       
        addAccount({acc : this.newAcc})
        .then(result => {
            console.log('Result = ',result);
            this.newAcc.Id = result;
        })
        .catch(error => {
            console.error('Error = ',error);
        })

        pubsub.publish("show", this.newAcc);
        
        this.newAccountBtn = false;
        this.saveBtn = true;
    }
    //console.log({...this.newAcc})
    //JSON.parse(JSON.stringfy(this.newAcc))
    //new Obj = Object.assign({}, this.newAcc)

    newAccountClick(){
        this.newAccountBtn = true;
        this.saveBtn = false;
        this.newAcc = {};
    }

    render(){
        return newAccount;
    }
}