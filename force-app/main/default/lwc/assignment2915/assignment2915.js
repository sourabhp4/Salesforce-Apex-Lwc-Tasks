import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Assignment2915 extends LightningElement {


    handleSuccess () {

        this.showToast('Successfully Created the contact', 'Success', 'success');
    }

    handleError () {
        this.showToast('Something went wrong while creating contact', 'Error', 'error');
    }

    showToast(message, title, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}