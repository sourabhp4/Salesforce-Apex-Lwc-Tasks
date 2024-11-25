trigger opportunityTrigger on Opportunity (before delete) {

    if(trigger.isBefore && trigger.isDelete) {
        OpportunityTriggerHandler.deleteRelatedCompetitors(trigger.old);
    }
}