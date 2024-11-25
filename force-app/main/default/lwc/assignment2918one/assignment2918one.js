import { api, LightningElement } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { FlowNavigationNextEvent } from 'lightning/flowSupport';

export default class Assignment2918one extends LightningElement {
    @api recordId;

    nameField = NAME_FIELD;
    typeField = TYPE_FIELD;
    industryField = INDUSTRY_FIELD;

    
    handleSuccess () {

        const eventToast = new ShowToastEvent({
            title: 'Record Update',
            message: 'Account record is updated successfully',
            variant: 'success'
        });
        this.dispatchEvent(eventToast);

        let flowEvent = new FlowNavigationNextEvent();
        this.dispatchEvent(flowEvent);
    }
}