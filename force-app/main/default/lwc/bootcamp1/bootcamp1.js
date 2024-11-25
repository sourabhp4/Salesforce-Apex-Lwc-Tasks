import { LightningElement, wire } from 'lwc';
import getAnimalNames from '@salesforce/apex/ApexREST.getAnimalNames';

export default class Bootcamp1 extends LightningElement {
    animals;
    @wire(getAnimalNames)
    getAnimals ({ data, error }) {
        if (data) {
            console.log(data);
            this.animals = data;
        }
    }
}