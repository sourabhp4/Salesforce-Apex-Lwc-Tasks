public class ScheduledOpportunityUpdateJob implements Schedulable {
    
    public void execute(SchedulableContext sc) {

        List<Opportunity> notClosedOpportunities = [SELECT Id, OwnerId From Opportunity Where StageName != 'Closed Won' AND StageName != 'Closed Lost'];
        List<Task> newTasks = new List<Task> ();

        for (Opportunity oppInstance : notClosedOpportunities) {
            newTasks.add(new Task(Subject='Review', ActivityDate=Date.today(), WhatId=oppInstance.Id, OwnerId=oppInstance.OwnerId, Status='Not Started'));
        }
        Database.insert(newTasks);
    }
    
    public static void scheduleJob() {
        String cronExpression = '0 0 9 ? * 2';
        ScheduledOpportunityUpdateJob jobInstance = new ScheduledOpportunityUpdateJob();
        System.schedule('Add Task to Opportunity - Every Monday 9AM', cronExpression, jobInstance);
    }
}