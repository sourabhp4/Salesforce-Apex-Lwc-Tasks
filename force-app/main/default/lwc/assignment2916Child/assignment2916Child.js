import { LightningElement } from 'lwc';

export default class Assignment2916Child extends LightningElement {


    handleClick (event) {
        if (event.target.name == 'absyz'){
            let newEvent = new CustomEvent('buttonclick', { detail: { url: 'https://absyz.com' } })
            this.dispatchEvent(newEvent)
        } 
        else if (event.target.name == 'trailhead'){
            let newEvent = new CustomEvent('buttonclick', { detail: { url: 'https://trailhead.salesforce.com/' } })
            this.dispatchEvent(newEvent)
        }

    }
}