public with sharing class DriverTriggerHandler implements TriggerHandler{
    public DriverTriggerHandler() {

    }

    public void beforeInsert(List<SObject> newList) {}
    public void afterInsert(List<SObject> newList, Map<Id, SObject> newMap) {}
    public void beforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}
    public void afterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}

    public void beforeDelete (List<SObject> oldList, Map<Id, SObject> oldMap) {
        for(Driver__c driverInstance: (List<Driver__c>) oldList) {
            if(driverInstance.Contact__c == NULL) {
                driverInstance.addError(System.label.Error_Before_Delete_Driver);
            }
        }
    }
    
    public void afterDelete(List<SObject> oldList, Map<Id, SObject> oldMap) {}
    public void afterUndelete(List<SObject> newList, Map<Id, SObject> newMap) {}

    public static void restrictDeletion (Driver__c[] driverList) {
        
    }
}