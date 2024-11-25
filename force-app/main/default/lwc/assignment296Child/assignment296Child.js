import { api, LightningElement, track } from 'lwc';

export default class Assignment296Child extends LightningElement {

    message;
    @track messageLocal;

    handleChange (event) {
        this.message = event.detail.value;
    }

    passToParent () {
        let messageObj = { message: this.message };
        let event = new CustomEvent('passvalue', { detail: messageObj });
        this.dispatchEvent(event);
    }

    @api
    printHelloWorld () {
        console.log(123)
        this.messageLocal = 'Called by the parent';
    }
}