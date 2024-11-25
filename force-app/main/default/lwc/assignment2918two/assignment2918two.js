import { LightningElement, api } from 'lwc';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import { FlowNavigationNextEvent } from 'lightning/flowSupport';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Assignment2918two extends LightningElement {
    firstNameField = FIRST_NAME_FIELD;
    lastNameField = LAST_NAME_FIELD;
    emailField = EMAIL_FIELD;
    phoneField = PHONE_FIELD;
    
    @api accountId;

    handleSubmit (event) {
        event.preventDefault()
        event.detail.fields.AccountId = this.accountId
        this.refs.recordSavingElement.submit(event.detail.fields)
    }
    
    handleSuccess (event) {
        const eventToast = new ShowToastEvent({
            title: 'Record Create',
            message: 'Contact record is created successfully with Record ID: ' + event.detail.id,
            variant: 'success'
        });
        this.dispatchEvent(eventToast);

        let flowEvent = new FlowNavigationNextEvent();
        this.dispatchEvent(flowEvent);
    }
}