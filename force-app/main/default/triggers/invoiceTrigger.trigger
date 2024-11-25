trigger invoiceTrigger on Invoice__c (before insert, before delete) {
    if(trigger.isBefore && trigger.isInsert) {
        InvoiceTriggerHandler.appendName(trigger.new);
    }

    if(trigger.isBefore && trigger.isDelete) {
        InvoiceTriggerHandler.checkStatusClosed(trigger.old);
    }
}