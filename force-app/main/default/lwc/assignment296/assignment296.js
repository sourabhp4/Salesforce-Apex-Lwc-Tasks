import { LightningElement, track } from 'lwc';

export default class Assignment296 extends LightningElement {
    @track message;

    handleEvent (event) {
        this.message = event.detail.message;
    }

    callChildFunction () {
        this.refs.child.printHelloWorld();
    }
}