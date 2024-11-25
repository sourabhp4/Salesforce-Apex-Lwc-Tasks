public with sharing class PostTriggerHandler {
    public PostTriggerHandler() {

    }

    public static Boolean isCompletedOnce = false;

    public static void updateHandler (List<Post__c> triggerNewPosts) {

        if(isCompletedOnce) 
            return;

        isCompletedOnce = true;

        List<Post__c> updatedPosts = new List<Post__c> ();

        for(Post__c postInstance: triggerNewPosts) {
            if (postInstance.Likes__c == postInstance.Comments__c) {
                updatedPosts.add(new Post__c(Id = postInstance.Id, Content__c = 'Likes and comments are equal'));
            }
        }

        Database.update(updatedPosts);
    }
}