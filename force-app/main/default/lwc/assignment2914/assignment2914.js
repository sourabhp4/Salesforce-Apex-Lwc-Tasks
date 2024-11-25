import { LightningElement, track, wire } from 'lwc';
import getTenContacts from '@salesforce/apex/Assignment29.getTenContacts';

import Assignment2914Modal from 'c/assignment2914Modal';

export default class Assignment2914 extends LightningElement {

    columns = [
        { label: 'Contact Name', fieldName: 'Name' },
        {
            type: "button", 
            label: 'View', 
            initialWidth: 100, 
            typeAttributes: {
                label: 'View',
                name: 'View',
                title: 'View',
                disabled: false,
                value: 'view',
                iconPosition: 'left',
                iconName:'utility:preview',
                variant:'Brand'
            }
        },
    ];

    @track contacts;

    @wire(getTenContacts)
    getContacts ({ data, error }) {
        if (data)
            this.contacts = data;
    }

    async setCurrentContactId (event) {
        const result = await Assignment2914Modal.open({
            size: 'large',
            description: 'Accessible description of modal\'s purpose',
            content: event.detail.row.Id,
        });
    }
}