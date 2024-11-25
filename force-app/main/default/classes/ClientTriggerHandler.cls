public with sharing class ClientTriggerHandler implements TriggerHandler{
    public ClientTriggerHandler() {

    }

    public void beforeInsert(List<SObject> newList) {}
    public void afterInsert(List<SObject> newList, Map<Id, SObject> newMap) {}
    public void beforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}
    public void afterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}

    public void beforeDelete (List<SObject> oldList, Map<Id, SObject> oldMap) {
        for(Client__c clientInstance: (List<Client__c>) oldList) {
            if(clientInstance.Contact__c == NULL) {
                clientInstance.addError(System.label.Error_Before_Delete_Client);
            }
        }
    }
    
    public void afterDelete(List<SObject> oldList, Map<Id, SObject> oldMap) {}
    public void afterUndelete(List<SObject> newList, Map<Id, SObject> newMap) {}

}