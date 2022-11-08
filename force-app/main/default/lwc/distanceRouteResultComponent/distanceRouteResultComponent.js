import { LightningElement, api } from 'lwc';
import pubsub from 'c/pubsub';

export default class BottomResultComponent extends LightningElement {
    selectedTravelMode = 'custom:custom31';
    showSecondComponent = false;
    isDisplayTime = false;
    totalDistance;
    totalMinutes = '';
    routeName = '';
    connectedCallback(){
        pubsub.subscribe("distanceRoute", record=> {
            this.totalDistance = parseInt(record.totalDistance);
            this.routeName = record.routeName;
            this.showSecondComponent = true;
            if(this.totalDistance != 0){
                this.isDisplayTime = true;
            }else{
                this.isDisplayTime = false;
            }
            this.getTime();
        })

        pubsub.subscribe("travelMode", record => {
            this.selectedTravelMode = record;
            this.getTime();
        })
    }

    getTime(){
        if(this.selectedTravelMode === 'custom:custom31'){
            this.calculate(60);
        }else if(this.selectedTravelMode === 'custom:custom36'){
            this.calculate(80);
        }else if(this.selectedTravelMode === 'action:new_lead'){
            this.calculate(10);
        }else if(this.selectedTravelMode === 'custom:custom80'){
            this.calculate(20);
        }else if(this.selectedTravelMode === 'custom:custom20'){
            this.calculate(700);
        }
    }
    calculate(num){
        let totalhours, totalMinutes;
        totalhours = Math.floor(this.totalDistance / num);
        if(totalhours == 0){
            totalMinutes = Math.ceil((this.totalDistance / num) * 60);
            this.totalTime = totalMinutes + ' min ';
        }else{
            totalMinutes = this.totalDistance % num;
            this.totalTime = totalhours + ' h '+ totalMinutes + ' min ';
        }
    }
}