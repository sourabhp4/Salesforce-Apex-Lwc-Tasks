import { api, LightningElement } from 'lwc';

export default class InvokeFlowInLWC extends LightningElement {
    
    outputVariables;
    
    get inputVariables () {
        return [
            {
                name: 'varT_name',
                type: 'String',
                value: 'Sourabh'
            }
        ]
    }

    handleStatusChange (event) {
        if (event.detail.status == 'FINISHED') {
            this.outputVariables = event.detail.outputVariables
            console.log('Flow Finihed ' + JSON.stringify(this.outputVariables))
        }

    }
}