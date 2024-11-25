trigger competitorTrigger on Competitor__c (after undelete) {

    if (trigger.isAfter && trigger.isUndelete) {
        CompetitorTriggerHandler.makeUndeleteTrue(trigger.new);
    }
}