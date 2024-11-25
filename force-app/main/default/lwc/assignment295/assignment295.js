import { LightningElement } from 'lwc';

export default class Assignment295 extends LightningElement {
    message;

    handleChange (event) {
        this.message = event.detail.value;
    }
}