import { api, LightningElement, wire } from 'lwc';
// import { getRecord } from 'lightning/uiRecordApi';
// import getOpportunities from '@salesforce/apex/OpportunityLWCController.getOpportunities'
import getContactsLeads from '@salesforce/apex/OpportunityLWCController.getContactsLeads'

const FIELDS = [ "Contact.FirstName", "Contact.LastName", "Contact.Phone" ];

import { ShowToastEvent } from 'lightning/platformShowToastEvent';


import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext
} from 'lightning/messageService';

// Import your message channel
import myLMS from '@salesforce/messageChannel/myLMS__c';

export default class ContactRecordViewForm extends LightningElement {
    @api recordId;
    @api objectApiName;

    // oppNameToBePassed = 'test';

    contactList;
    leadList;

    subscription = null;

    // @wire (getRecord, { recordId: "$recordId", fields: FIELDS })
    // record;

    // @wire (getOpportunities, { oppName: "$oppNameToBePassed" })
    // opportunitiesList;

    // @wire (getOpportunities, { oppName: "$oppNameToBePassed" })
    // opportunitiesList1 ({ data, error }) {
    //     if (data) {
    //         console.log('Before data', data)
    //         let modifiedOpportunities = []
    //         data.forEach(element => {
    //             let opportunity = {}
    //             opportunity.Name = 'Test ' + element.Name
    //             modifiedOpportunities.push(opportunity)
    //         })
    //         console.log('After data', modifiedOpportunities)
    //     } else {
    //         console.log('error', error)
    //     }
    // }

    // //Through wire
    // @wire (getContactsLeads, { email: 'test@email.com' })
    // callContactLeads () {

    // }

    //Through imperative method
    async callContactLeads () {
        try {
            let results = await getContactsLeads({ email: 'test@test.com' })
            console.log('hello', results)
            this.contactList = results.contacts
            this.leadList = results.leads
        } catch (error) {
            console.log(error)
        }
    }


    @wire(MessageContext)
    messageContext;

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                myLMS,
                (message) => this.handleMessage(message),
                // { scope: APPLICATION_SCOPE } //Optional
            );
        }
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    showToast(message) {
        const event = new ShowToastEvent({
            title: 'My Message',
            message,
            variant: 'success'
        });
        this.dispatchEvent(event);
    }
    
    // Handler for message received by component
    handleMessage(message) {
        console.log(message.myMessage);
        this.showToast(message.myMessage);
    }

    // Pass scope to the subscribe() method.
    connectedCallback() {
        this.subscribeToMessageChannel ();
    }

    disconnectedCallback () {
        this.unsubscribeToMessageChannel();
    }
}