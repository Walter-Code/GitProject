import { LightningElement } from 'lwc';
import { test } from './commonUtils.js';

export default class P2cParentComponentAssignment extends LightningElement {

    isVisible = false;

    value = '';
    options = [
            {    label : "India", value : "India" },
            {    label : "USA", value : "USA" },
            {    label : "UK", value : "UK" },
            {    label : "Spain", value : "Spain" },
            {    label : "Australia", value : "Australia" }
        ]

    handleChange(event){
        this.template.querySelector('c-p2c-child-component-assignment').showComponent = false;
        this.value = event.target.value;
    }

    show(){
        this.isVisible = true;
        window.addEventListener("load",function(){const e=document.getElementById("channext-banners");if(e&&!e.getElementsByTagName("iframe")[0]){var t=[],n=(["a","i","b","f","q","r","s","a","h","m","o","e"].reduce(function(e,t,n,i){return n%2==0&&e.push(i.slice(n+1,n+2)[0]),e},t),t.join("")),i=document.createElement(n),a=e.dataset.source,d=e.dataset.width||"100%";i.width=d,i.style.border="none",i.src=a;var c=Math.ceil(e.getBoundingClientRect().width/3);window.matchMedia("(max-width: 480px)").matches&&(c=Math.ceil(.75*e.getBoundingClientRect().width)),i.height=c,e.appendChild(i)}});
        console.log('Test = ', window.addEventListener("load",function(){const e=document.getElementById("channext-banners");if(e&&!e.getElementsByTagName("iframe")[0]){var t=[],n=(["a","i","b","f","q","r","s","a","h","m","o","e"].reduce(function(e,t,n,i){return n%2==0&&e.push(i.slice(n+1,n+2)[0]),e},t),t.join("")),i=document.createElement(n),a=e.dataset.source,d=e.dataset.width||"100%";i.width=d,i.style.border="none",i.src=a;var c=Math.ceil(e.getBoundingClientRect().width/3);window.matchMedia("(max-width: 480px)").matches&&(c=Math.ceil(.75*e.getBoundingClientRect().width)),i.height=c,e.appendChild(i)}}));
        this.template.querySelector('c-p2c-child-component-assignment').fetchDetails();
    }
}