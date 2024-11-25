trigger clientTrigger on Client__c (before delete) {
    TriggerDispatcher.run(new ClientTriggerHandler());
}