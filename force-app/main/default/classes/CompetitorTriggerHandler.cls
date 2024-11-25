public with sharing class CompetitorTriggerHandler {
    public CompetitorTriggerHandler() {

    }

    public static void makeUndeleteTrue (Competitor__c[] competitorList) {

        List<Competitor__c> updateCompetitorList = new List<Competitor__c> ();

        for (Competitor__c compInstance: competitorList) {
            updateCompetitorList.add(new Competitor__c(Id=compInstance.Id, Undeleted_Record__c = true));
        }

        Database.update(updateCompetitorList);
    }
}