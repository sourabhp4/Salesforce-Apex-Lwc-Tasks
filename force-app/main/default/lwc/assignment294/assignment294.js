import { LightningElement, wire, api } from 'lwc';
import { getRecord, createRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";

import getAllContactsSearch from '@salesforce/apex/Assignment29.getAllContactsSearch';

export default class Assignment294 extends LightningElement {
    @api recordId;
    @api account;

    name;
    rating;

    get options() {
        return [
            { label: 'Hot', value: 'Hot' },
            { label: 'Warm', value: 'Warm' },
            { label: 'Cold', value: 'Cold' },
        ];
    }

    @wire(getRecord, {
        recordId: "$recordId",
        fields: [NAME_FIELD, INDUSTRY_FIELD, RATING_FIELD],
    })
    getAccount ({ data, error }) {
        if (data) {
            this.account = data;
        }
    }

    async handleCreate() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.name;
        fields[RATING_FIELD.fieldApiName] = this.rating;
    
        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };
    
        try {
          await createRecord(recordInput);
        } catch (error) {
            console.log(error);
        }
    }

    handleChange (event) {
        if (event.target.name == 'name')
            this.name = event.detail.value;
        else if (event.target.name == 'rating')
            this.rating = event.detail.value;
    }


    @api contacts;
    searchString;

    columns = [
        { label: 'Contact Name', fieldName: 'Name' },
        { label: 'Title', fieldName: 'Title' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
    ];

    
    @wire (getAllContactsSearch, { conName: "$searchString" }) 
    getContacts ({ data, error }) {
        if (data)
            this.contacts = data;
    }

    handleSearchChange (event) {
        this.searchString = event.detail.value;
    }
}