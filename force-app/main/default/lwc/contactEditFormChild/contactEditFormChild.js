import { LightningElement, api } from 'lwc';

export default class ContactEditFormChild extends LightningElement {

    @api firstName;
    @api lastName;
    @api dob;
    @api email;
    @api phone;
    @api accountName;

    hide() {

        // let conObject = {
        //     firstName: this.firstName;
        // };

        // let event = new CustomEvent('fieldedit', { detail: conObject });
        let event = new CustomEvent('fieldedit');
        this.dispatchEvent(event);
    }

    @api
    callMeFromParent () {
        console.log('hello');
        alert('From Child');
    }
}