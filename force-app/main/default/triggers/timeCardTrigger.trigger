trigger timeCardTrigger on Timecard_Header__c (after insert, before update) {

    if (trigger.isAfter && trigger.isInsert) {
        TimeCardTriggerHandler.beforeInsert (trigger.new);
    }
    if (trigger.isBefore && trigger.isUpdate) {
        TimeCardTriggerHandler.beforeUpdate (trigger.newMap, trigger.oldMap);
    }
}