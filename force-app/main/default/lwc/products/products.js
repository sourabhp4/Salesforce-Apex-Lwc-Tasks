import { LightningElement, wire, api, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { refreshApex } from "@salesforce/apex";

import getAllProducts from '@salesforce/apex/ProductController.getAllProducts';
import getExistingProducts from '@salesforce/apex/ProductController.getExistingProducts';
import createAccountProducts from '@salesforce/apex/ProductController.createAccountProducts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Products extends LightningElement {

    @api recordId;

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;
        }
    }

    columnsProducts = [
        { label: 'Name', fieldName: 'Name', sortable: "true" },
        { label: 'Product Code', fieldName: 'ProductCode', sortable: "true" },
    ];

    columnsAccountProducts = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Account Name', fieldName: 'AccountName' },
        { label: 'Product Name', fieldName: 'ProductName' },
    ];

    dataAll = [];

    @track searchString = '';
    
    @track sortBy = 'Name';
    @track sortDirection = 'asc';

    @wire(getAllProducts, { productCodeString: "$searchString", sortBy: "$sortBy", sortDirection: "$sortDirection" })
    setDataAll({ data, error }) {
        if (data) {
            this.dataAll = data;
            this.selectedItemArray = this.selectedItemArray.map((item) => (item));
        }
    }

    doSorting(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
    }

    dataExisting = [];
    dataExistingResponse = [];

    @wire(getExistingProducts, { accountId: "$recordId" })
    setDataExisting(response) {
        this.dataExistingResponse = response;
        if (response.data) {
            this.dataExisting = response.data.map( accProduct => ({ Name: accProduct.Name, AccountName: accProduct.Account__r.Name, ProductName: accProduct.Product__r.Name }) );
        } else if (response.error) {
            console.log('Error:', response.error);
        }
    }

    @track dataSelected = [];
    @track dataSelectedSet = new Set();

    @track selectedItemArray = [];

    getSelectedRows (event) {
        try {

            let tempSet = new Set(this.selectedItemArray);

            switch (event.detail.config.action) {
                case 'selectAllRows':
                    tempSet = new Set( [...tempSet, ...event.detail.selectedRows.map(item => (item.Id) )] )

                    this.dataSelected = [ ...this.dataSelected, ...this.dataAll.filter((product) => { return !this.dataSelectedSet.has(product.Id) && tempSet.has(product.Id); })];

                    this.dataSelectedSet = new Set( [...this.dataSelectedSet, ...event.detail.selectedRows.map(item => (item.Id) )] );
                    break;
                case 'deselectAllRows':
                    this.dataAll.map((item) => {
                        if (tempSet.has(item.Id)) {
                            tempSet.delete(item.Id)
                        }
                    })

                    this.dataAll.map((item) => {
                        if (this.dataSelectedSet.has(item.Id)) {
                            this.dataSelectedSet.delete(item.Id)
                        }
                    })

                    this.dataSelected = this.dataSelected.filter((product) => {
                        return this.dataSelectedSet.has(product.Id);
                    })

                    break;
                case 'rowSelect':
                    tempSet.add(event.detail.config.value);
                    this.dataSelected = [ ...this.dataSelected, ...this.dataAll.filter((product) => { return !this.dataSelectedSet.has(product.Id) && tempSet.has(product.Id); })];

                    this.dataSelectedSet.add(event.detail.config.value);
                  break;
                case 'rowDeselect':
                    tempSet.delete(event.detail.config.value);
                    this.dataSelectedSet.delete(event.detail.config.value);
                    this.dataSelected = this.dataSelected.filter((product) => {
                        return this.dataSelectedSet.has(product.Id);
                    })
                    break;
                default:
                  break;
            }
            this.selectedItemArray = [ ...tempSet ];
        } catch (error) {
            console.log('Error ', JSON.stringify(error.message));
        }
    }

    

    setSearchString (event) {
        this.searchString = event.detail.value;
    }

    async handleSave () {

        let products = this.dataSelected.map(product => ({ productName: product.Name, productId: product.Id }));

        if (await createAccountProducts({ accountId: this.recordId, products: products })) {
            this.dataSelected = [];
            this.dataSelectedSet = new Set();
            this.selectedItemArray = [];
            refreshApex(this.dataExistingResponse);
            const event = new ShowToastEvent({
                title: 'Success',
                variant: 'success',
                message: 'The Account Products have been created',
            });
            this.dispatchEvent(event);
        } else {
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: 'Something went wrong, Please try again later.',
            });
            this.dispatchEvent(event);
        }
    }
}
