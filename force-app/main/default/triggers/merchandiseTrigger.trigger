trigger merchandiseTrigger on Merchandise__c (before update) {
    if(trigger.isBefore && trigger.isUpdate) {
        MerchandiseTriggerHandler.doubleUnitPrice(trigger.new, trigger.oldMap);
    }
}