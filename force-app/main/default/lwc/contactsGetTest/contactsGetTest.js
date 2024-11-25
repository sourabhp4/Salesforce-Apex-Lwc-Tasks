import { LightningElement, api } from 'lwc';

import getContactsRelated from '@salesforce/apex/OpportunityLWCController.getContactsRelated'

export default class ContactsGetTest extends LightningElement {
    @api recordId;
    @api objectApiName;

    results = [];
    isPresent = true;

    async getContacts () {
        if (this.refs.idElement.value){
            this.results = await getContactsRelated ({ accId: this.refs.idElement.value })
            if (this.results.length == 0) {
                this.isPresent = false
            }
        }
    }

}