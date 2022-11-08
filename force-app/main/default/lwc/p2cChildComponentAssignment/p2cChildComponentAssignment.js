import { LightningElement, api, track } from 'lwc';

export default class P2cChildComponentAssignment extends LightningElement {
    @api selectedcountry = '';
    @api showComponent = false;
    @track countryObj = {}

    countries = {
        ind : {
            
        }
    }
    @api fetchDetails(){
        this.showComponent = true;
        if(this.selectedcountry == 'India'){
            this.countryObj = {
                capital : "Delhi",
                population : "13500000",
                src : "https://ibirdssoftwareservices7-dev-ed--c.visualforce.com/resource/1614524114000/India_Image"
            }
        }else if(this.selectedcountry == "USA"){
            this.countryObj = {
                capital : "New York",
                population : "1300000",
                src : "https://ibirdssoftwareservices7-dev-ed--c.visualforce.com/resource/1614523484000/Usa_image"
            }
        }else if(this.selectedcountry == "UK"){
            this.countryObj = {
                capital : "London",
                population : "1120000",
                src : "https://ibirdssoftwareservices7-dev-ed--c.visualforce.com/resource/1614523512000/Uk_image"
            }
        }else if(this.selectedcountry == "Spain"){
            this.countryObj = {
                capital : "Madrid",
                population : "1234500",
                src : "https://ibirdssoftwareservices7-dev-ed--c.visualforce.com/resource/1614523535000/spain_image"
            }
        }else if(this.selectedcountry == "Australia"){
            this.countryObj = {
                capital : "Melbourne",
                population : "1568740",
                src : "https://ibirdssoftwareservices7-dev-ed--c.visualforce.com/resource/1614523581000/australia_image"
            }
        }
    }
}