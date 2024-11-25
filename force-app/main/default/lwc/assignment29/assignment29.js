import { LightningElement, api, wire } from 'lwc';

import getRelatedContacts from '@salesforce/apex/Assignment29.getRelatedContacts';
import getRelatedAccounts from '@salesforce/apex/Assignment29.getRelatedAccounts';


import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
import {deleteRecord} from 'lightning/uiRecordApi';

import {FlowAttributeChangeEvent} from 'lightning/flowSupport';

export default class Assignment29 extends LightningElement {
    @api recordId;
    name = "Sourabh P";
    isTextShow = false;

    columns = [
        { label: 'Contact Name', fieldName: 'Name' },
        { label: 'Title', fieldName: 'Title' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'Email', fieldName: 'Email' },
        { label: 'Contact Owner', fieldName: 'OwnerName' },
    ];

    data = [];

    showText () {
        this.isTextShow = !this.isTextShow;
    }

    @wire (getRelatedContacts, { accId: "$recordId"})
    getRelatedContacts({ data, error }) {
        if (data) {
            this.data = data.map(contact =>({ ...contact, OwnerName: contact.Owner.Name }));

            this.data = data.map((contact) => {
                let contactWithOwnerName = { ...contact, OwnerName: contact.Owner.Name }
                return contactWithOwnerName;
            })
        }
        
    }

    accounts;
    error;
    wiredAccountsResult;

    @wire(getRelatedAccounts)
    wiredAccounts(result){
        this.wiredAccountsResult = result;
        if(result.data){
            this.accounts = result.data;
            this.error = undefined;

        } else if(result.error){
            this.error = result.error;
            this.accounts = undefined;
        }
    }

    deleteAccount(event){
        const recordId = event.target.dataset.recordid;
        deleteRecord(recordId)
        .then(()=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title : 'Success',
                    message : 'Account Deleted',
                    variant : 'success'
                })
            );
            return refreshApex(this.wiredAccountsResult);
        })
        .catch((error)=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title : 'Error',
                    message : 'Error Deleting record',
                    variant : 'error'
                })
            );
        });
    }

    @api message;

    handleChange (event) {
        this.message = event.detail.value;
        this.dispatchEvent(new FlowAttributeChangeEvent("message", this.message));
    }
}