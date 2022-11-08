import { LightningElement, track } from 'lwc';
import pubsub from 'c/pubsub';
import sendRequest from '@salesforce/apex/StatusFetcher.sendRequest';

export default class TopFilterComponent extends LightningElement {
  @track distanceRoute;
  firstInputValue = '';
  secondInputValue = '';
  routeName = '';
  showSpinner = false;
  getSelectedTravelModel(event){
    pubsub.publish("travelMode", event.currentTarget.dataset.name);
  } 

  searchClick(){
    this.showSpinner = true;
    this.firstInputValue = this.template.querySelector('.firstInput').value;
    this.secondInputValue = this.template.querySelector('.secondInput').value;
    console.log('First Input = '+firstInputValue);
    console.log('Second Input = '+secondInputValue);
    
    
    sendRequest({start : firstInputValue, destination : secondInputValue})
    .then((result) => {
      this.distanceRoute = JSON.parse(result);
      //console.log({...this.distanceRoute});
      this.showSpinner = false;
      pubsub.publish("distanceRoute", this.distanceRoute);
    }).catch((err) => {
      console.error(err);
    });
  
    this.distanceRoute = {
      totalDistance : 0,
      routeName : "No Route Found"
    }
    setTimeout(() => {
      this.showSpinner = false;
      pubsub.publish("distanceRoute", this.distanceRoute);
    }, 1000); 
    
  }
}