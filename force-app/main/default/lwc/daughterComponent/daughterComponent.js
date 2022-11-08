import { LightningElement } from 'lwc';

export default class DaughterComponent extends LightningElement {
    sendMessage(){
        const myEvent = new CustomEvent("sendmessage",{detail : "Miss You Bhai"});
        this.dispatchEvent(myEvent);
    }
}