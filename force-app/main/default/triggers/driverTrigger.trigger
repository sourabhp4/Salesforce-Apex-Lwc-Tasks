trigger driverTrigger on Driver__c (before delete) {
    TriggerDispatcher.run(new DriverTriggerHandler());
}