import { api, LightningElement } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import STAGE_NAME_FIELD from '@salesforce/schema/Opportunity.StageName';
import CLOSE_DATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';
import { FlowNavigationFinishEvent } from 'lightning/flowSupport';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Assignment2918three extends LightningElement {
    nameField = NAME_FIELD;
    stageNameField = STAGE_NAME_FIELD;
    closeDateField = CLOSE_DATE_FIELD;
    
    @api accountId;

    handleSubmit (event) {
        event.preventDefault()
        event.detail.fields.AccountId = this.accountId
        this.refs.recordSavingElement.submit(event.detail.fields)
    }

    handleSuccess (event) {
        const eventToast = new ShowToastEvent({
            title: 'Record Create',
            message: 'Opportunity record is created successfully with Record Id: ' + event.detail.id,
            variant: 'success'
        });
        this.dispatchEvent(eventToast);

        let flowEvent = new FlowNavigationFinishEvent();
        this.dispatchEvent(flowEvent);
    }
}