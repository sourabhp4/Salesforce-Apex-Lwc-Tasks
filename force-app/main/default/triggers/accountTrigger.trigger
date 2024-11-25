trigger accountTrigger on Account (before update, before insert, before delete) {
    if (trigger.isBefore && (trigger.isUpdate || trigger.isInsert)) {
        AccountTriggerHandler.updateRating(trigger.new);
    }

    if (trigger.isBefore && trigger.isDelete) {
        AccountTriggerHandler.preventDeleteIfMoreThan3Contacts(trigger.old);
    }

    if (trigger.isBefore && trigger.isUpdate) {
        AccountTriggerHandler.updateChildAccountPhone(trigger.new, trigger.newMap, trigger.oldMap);
    }
}