import { LightningElement, wire } from 'lwc';

import { publish, MessageContext } from 'lightning/messageService';
import myLMS from '@salesforce/messageChannel/myLMS__c';

export default class ContactEditForm extends LightningElement {
    firstName;
    lastName;
    dob;
    email;
    phone;
    accountName;
    onlyShow = true;

    @wire(MessageContext)
    messageContext;

    onSave () {

        if (!this.refs.lastNameElement.value)
            return;

        this.firstName = this.refs.firstNameElement.value;
        this.lastName = this.refs.lastNameElement.value;
        this.dob = this.refs.dobElement.value;
        this.email = this.refs.emailElement.value;
        this.phone = this.refs.phoneElement.value;
        this.accountName = this.refs.accountElement.value;
        this.onlyShow = false;
    }

    onCancel () {
        this.firstName = null;
        this.lastName = null;
        this.dob = null;
        this.email = null;
        this.phone = null;
        this.accountName = null;
        this.onlyShow = true;
    }

    // onEdit (event) {
    onEdit () {
        // console.log(event.detail.firstName);
        this.onlyShow = true;
    }

    callChild () {
        // this.refs.childToDisplay.callMeFromParent ();

        const payload = { myMessage: 'Hello World' };
        publish(this.messageContext, myLMS, payload);
    }
}