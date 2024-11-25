import { LightningElement } from 'lwc';

export default class Assignment2916 extends LightningElement {

    url;

    handleURL (event) {
        this.url = event.detail.url;
    } 
}