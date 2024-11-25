import { LightningElement } from 'lwc';

export default class ArchiveData extends LightningElement {
    value = null;
    isShowArchive = false;

    get options() {
        return [
            { label: 'Archive', value: 'archive' },
            { label: 'UnArchive', value: 'unarchive' },
        ];
    }

    handleRadioChange (event) {
        this.value = event.detail.value;
        this.isShow = true;
        if (this.value == 'archive')
            this.isShowArchive = true;
        else if (this.value == 'unarchive')
            this.isShowArchive = false;

    }
}