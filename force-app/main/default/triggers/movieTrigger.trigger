trigger movieTrigger on Movie__c (after update, after insert) {
    if (trigger.isAfter && (trigger.isInsert || trigger.isUpdate)) {
        MovieTriggerHandler.sendEmailOnAllActorsAvailable(trigger.new, trigger.oldMap, trigger.isUpdate, trigger.isInsert);
    }
}