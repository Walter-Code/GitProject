import { LightningElement, track} from 'lwc';
import pubsub from 'c/pubsub';
import sendRequest from '@salesforce/apex/StatusFetcher.sendRequest';

export default class DistanceRouteFilterComponent extends LightningElement {
  @track distanceRoute;
  routeName = '';
  firstInputValue = '';
  secondInputValue = '';
  showSpinner = false;
  getSelectedTravelModel(event){
    pubsub.publish("travelMode", event.currentTarget.dataset.name);
  }

  handleFirst(event){
    this.firstInputValue = event.target.value;
  }
  handleSecond(event){
      this.secondInputValue = event.target.value;
  }
  
  searchClick(){
    console.log('First = '+this.firstInputValue);
    console.log("Second = "+this.secondInputValue);
    this.showSpinner = true;
    sendRequest({start : this.firstInputValue, destination : this.secondInputValue})
    .then((result) => {
      console.log(result);
      this.distanceRoute = JSON.parse(result);
      console.log({...this.distanceRoute});
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