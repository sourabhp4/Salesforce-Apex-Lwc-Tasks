trigger lineItemTrigger on Line_Item__c (after insert, before delete) {
    if (trigger.isAfter && trigger.isInsert) {
        LineItemTriggerHandler.countLineItemsInsert(trigger.new);
    }

    if (trigger.isBefore && trigger.isDelete) {
        LineItemTriggerHandler.countLineItemsDelete(trigger.old);
    }
}