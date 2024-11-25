trigger contactTrigger on Contact (before insert, before update, after insert, after update, after delete, before delete, after undelete) {

    // if (trigger.isBefore && trigger.isInsert) {
    //     ContactTriggerHandler.maintainOnePrimaryContact(trigger.new);
    // }

    // if (trigger.isBefore && trigger.isUpdate) {
    //     ContactTriggerHandler.maintainOnePrimaryContactUpdate(trigger.new, trigger.old);
    // }

    // if (trigger.isBefore && trigger.isDelete) {
    //     ContactTriggerHandler.clearPrimaryContactName(trigger.old);
    // }

    // if (trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isDelete)) {
    //     if(trigger.isDelete)
    //         ContactTriggerHandler.updateActiveContactCount(trigger.old);
    //     else
    //         ContactTriggerHandler.updateActiveContactCount(trigger.new);
    // }

    // if (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
    //     ContactTriggerHandler.checkTypeVehicleNumber(trigger.new);
    // }

    // if (trigger.isBefore && trigger.isUpdate) {
    //     ContactTriggerHandler.restrictChangeOfSelectedType(trigger.oldMap, trigger.newMap);
    // }

    // if (trigger.isAfter && trigger.isInsert) {
    //     ContactTriggerHandler.copyContactToClientOrDriver(trigger.new);
    // }


    if (trigger.isAfter && (trigger.isInsert || trigger.isUndelete)) {
        ContactTriggerHandler.updateTotalValueAccountAfterInsert (trigger.new, trigger.newMap);
    }
    if (trigger.isAfter && trigger.isUpdate) {
        ContactTriggerHandler.updateTotalValueAccountAfterUpdate (trigger.new, trigger.oldMap);
    }
    if (trigger.isAfter && trigger.isDelete) {
        ContactTriggerHandler.updateTotalValueAccountAfterDelete (trigger.old, trigger.oldMap);
    }
}