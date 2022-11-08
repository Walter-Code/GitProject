import { LightningElement, track } from 'lwc';
import {sum,minus,multiply,divide} from './calc';

export default class FirstFile extends LightningElement {
    num1 = 0;
    num2 = 0;
    result = 0;

    num1Fun(event){
        this.num1 = event.target.value;
    }

    num2Fun(event){
        this.num2 = event.target.value;
    }

    addition(){
        this.result = sum(parseInt(this.num1), parseInt(this.num2));
        console.log(this.result);
    }

    substract(){
        this.result = minus(this.num1, this.num2);
    }

    multiplication(){
        this.result = multiply(this.num1, this.num2);
    }

    division(){
        this.result = divide(this.num1, this.num2);
    }
}