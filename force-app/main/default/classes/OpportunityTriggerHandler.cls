public with sharing class OpportunityTriggerHandler {
    public OpportunityTriggerHandler() {

    }

    public static void deleteRelatedCompetitors (List<Opportunity> oppList) {

        List<Competitor__c> competitorRecordsForDelete = new List<Competitor__c> ();
        
        List<Opportunity> oppWithCompetitor = [Select Id, (Select Id From Competitors__r) From Opportunity Where Id IN :oppList];
    
        for (Opportunity oppInstance: oppWithCompetitor) {
            competitorRecordsForDelete.addAll(oppInstance.Competitors__r);
        }

        Database.delete(competitorRecordsForDelete);
    }
}