import { LightningElement, wire } from 'lwc';

import getAllAccounts from '@salesforce/apex/Assignment29.getAllAccounts';

export default class Assignment292 extends LightningElement {
    accId

    options = []

    // @wire (getAllAccounts)
    // setAllAccounts({ data, error }) {
    //     if (data) {
    //         console.log(data)
    //         this.options = data.map(account => ({ label: account.Name, value: account.Id }))
    //         console.log(this.options)
    //     }
    //     console.log(this.options)
    // }

    async connectedCallback () {
        let results = await getAllAccounts()
        this.options = results.map(account => ({ label: account.Name, value: account.Id }))
    }

    handleChange (event) {
        this.accId = event.detail.value;
    }

    saveContact (event) {
        event.preventDefault()
        event.detail.fields.AccountId = this.accId
        this.refs.recordSavingElement.submit(event.detail.fields)
    }
}