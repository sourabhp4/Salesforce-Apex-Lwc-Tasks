public with sharing class InvoiceTriggerHandler {
    public InvoiceTriggerHandler() {

    }

    public static void appendName(Invoice__c[] invoiceList) {

        for (Invoice__c invoiceInstance: invoiceList) {
            invoiceInstance.name__c += ' ABSYZ';
        }
    }

    public static void checkStatusClosed(Invoice__c[] invoiceList) {
        for (Invoice__c invoiceInstance: invoiceList)
            if (invoiceInstance.status__c == 'Closed')
                invoiceInstance.addError('Invoice records with status as Closed can not be deleted');
    }
}