import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class Assignment2914Modal extends LightningModal {
    @api content;

    handleOkay() {
        this.close('okay');
    }

    handleOptionClick(e) {
        const { target } = e;
        const { id } = target.dataset;
        this.close(id);
      }
}