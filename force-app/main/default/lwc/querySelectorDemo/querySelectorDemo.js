import { LightningElement } from 'lwc';

export default class QuerySelectorDemo extends LightningElement {
    arr = [
        'Vishal','Avneet','Urvashi','Aashi'
    ]

    clickFun(event){
        const myDiv = this.template.querySelector('div');
        myDiv.style.color = 'red';
        myDiv.innerText = "Hello Friends"

        const divElement = this.template.querySelectorAll('.child');
        Array.from(divElement).forEach(element =>{
            element.style.color = 'blue';
            element.setAttribute('title',element.innerHTML);
            element.setAttribute('align','center');
        });

        const myClass = this.template.querySelector('.myClass');
        myClass.innerHTML = '<p style="color:red">This tag is enabled by js manually</p>'
    }
}