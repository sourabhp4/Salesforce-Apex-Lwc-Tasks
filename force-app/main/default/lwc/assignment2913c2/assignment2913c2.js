import { LightningElement, wire } from 'lwc';
import myLMS1 from '@salesforce/messageChannel/myLMS1__c';

import {
    subscribe,
    unsubscribe,
    MessageContext
} from 'lightning/messageService';

export default class Assignment2913c2 extends LightningElement {
    message;

    @wire(MessageContext)
    messageContext;

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                myLMS1,
                (message) => this.handleMessage(message),
                // { scope: APPLICATION_SCOPE } //Optional
            );
        }
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
    
    // Handler for message received by component
    handleMessage(message) {
        this.message = message.myMessage;
    }

    // Pass scope to the subscribe() method.
    connectedCallback() {
        this.subscribeToMessageChannel ();
    }

    disconnectedCallback () {
        this.unsubscribeToMessageChannel();
    }
}