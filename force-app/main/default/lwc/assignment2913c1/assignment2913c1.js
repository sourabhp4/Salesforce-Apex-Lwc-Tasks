import { LightningElement, wire } from 'lwc';
import myLMS1 from '@salesforce/messageChannel/myLMS1__c';
import { publish, MessageContext } from 'lightning/messageService';

export default class Assignment2913c1 extends LightningElement {

    message;
    @wire(MessageContext)
    messageContext;

    handleChange (event) {
        this.message = event.detail.value;
    }

    passValue () {
        const payload = { myMessage: this.message };
        publish(this.messageContext, myLMS1, payload);
    }
}