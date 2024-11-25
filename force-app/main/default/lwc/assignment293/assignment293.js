import { LightningElement, api, wire } from 'lwc';

import getAllContacts from '@salesforce/apex/Assignment29.getAllContacts';

export default class Assignment293 extends LightningElement {
    @api recordId;

    @wire(getAllContacts)
    contacts;

}