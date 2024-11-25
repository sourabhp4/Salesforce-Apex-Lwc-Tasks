public with sharing class TriggerDispatcher {
    public TriggerDispatcher() {

    }

    public static void run(TriggerHandler handler) {
        if(trigger.isBefore) {
            if(trigger.isInsert) {
                handler.beforeInsert (trigger.new);
            }
            if(trigger.isUpdate) {
                handler.beforeUpdate (trigger.newMap, trigger.oldMap);
            }
            if(trigger.isDelete) {
                handler.beforeDelete (trigger.old, trigger.oldMap);
            }
        }
        if(trigger.isAfter) {
            if(trigger.isInsert) {
                handler.afterInsert (trigger.new, trigger.newMap);
            }
            if(trigger.isUpdate) {
                handler.afterUpdate (trigger.newMap, trigger.oldMap);
            }
            if(trigger.isDelete) {
                handler.afterDelete (trigger.old, trigger.oldMap);
            }
        }
    }
}